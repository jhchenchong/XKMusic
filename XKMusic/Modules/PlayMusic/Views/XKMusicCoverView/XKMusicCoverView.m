//
//  XKMusicCoverView.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/2.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKMusicCoverView.h"


@interface XKMusicCoverView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *sepLineView;
@property (nonatomic, strong) UIView *diskBgView;

@property (nonatomic, copy) NSArray<XKMusicModel *> *models;

@property (nonatomic, strong) UIImageView *needleView;
@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL isAnimation;
@property (nonatomic, copy) dispatch_block_t finished;
@property (nonatomic, assign) BOOL isChange;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation XKMusicCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        
        [self addSubview:self.sepLineView];
        [self addSubview:self.diskBgView];
        [self addSubview:self.collectionView];
        [self addSubview:self.needleView];
        
        [self.sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.diskBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(66 - 2.5);
            make.width.height.mas_equalTo(SCREEN_WIDTH - 75);
        }];
        [self.needleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(-78);
        }];
        
        self.diskBgView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2].CGColor;
        self.diskBgView.layer.borderWidth = 10;
        self.diskBgView.layer.cornerRadius = (SCREEN_WIDTH - 75) * 0.5;
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count * 100;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XKMusicCoverViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XKMusicCoverViewCell" forIndexPath:indexPath];
    NSInteger itemIndex = indexPath.item % self.models.count;
    cell.imageURL = self.models[itemIndex].music_cover;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ((XKMusicCoverViewCell *) cell).diskView.diskImgView.transform = CGAffineTransformIdentity;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XKBLOCK_EXEC(self.didTapCellBlock);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.index == [self currentIndex]) {
        
    } else {
        if (self.isChange) {
            !self.finished ? : self.finished();
            self.isChange = NO;
        }
        XKMusicModel *model = self.models[[self currentIndex] % self.models.count];
        if (self.delegate && [self.delegate respondsToSelector:@selector(scrollDidChangeModel:)]) {
            [self.delegate scrollDidChangeModel:model];
        }
    }
    self.index = [self currentIndex];
    [self playedWithAnimated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self pausedWithAnimated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollDidScroll)]) {
        [self.delegate scrollDidScroll];
    }
}

- (void)setupMusicModels:(NSArray<XKMusicModel *> *)models index:(NSInteger)currentIndex {
    [self resetCover];
    self.isAnimation = NO;
    self.models = models;
    [self.collectionView reloadData];
    [self makeScrollViewScrollToIndex:currentIndex];
    self.index = [self currentIndex];
}

- (void)resetMusicModels:(NSArray<XKMusicModel *> *)models {
    self.models = models;
}

- (NSInteger)currentIndex {
    NSInteger index = 0;
    index = (self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5) / self.collectionView.frame.size.width;
    return MAX(0, index);
}

- (void)playedWithAnimated:(BOOL)animated {
    if (self.isAnimation) {
        return;
    }
    self.isAnimation = YES;
    [self setAnchorPoint:CGPointMake(25.0/97, 25.0/153) forView:self.needleView];
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            self.needleView.transform = CGAffineTransformIdentity;
        }];
    } else {
        self.needleView.transform = CGAffineTransformIdentity;
    }
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animation)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)pausedWithAnimated:(BOOL)animated {
    if (!self.isAnimation) {
        return;
    }
    self.isAnimation = NO;
    [self setAnchorPoint:CGPointMake(25.0/97, 25.0/153) forView:self.needleView];
    
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            self.needleView.transform = CGAffineTransformMakeRotation(-M_PI_2 / 3);
        }];
    } else {
        self.needleView.transform = CGAffineTransformMakeRotation(-M_PI_2 / 3);
    }
    
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)resetCover {
    XKMusicCoverViewCell *cell = (XKMusicCoverViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[self currentIndex] inSection:0]];
    cell.diskView.diskImgView.transform = CGAffineTransformIdentity;
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)animation {
    XKMusicCoverViewCell *cell = (XKMusicCoverViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[self currentIndex] inSection:0]];
    cell.diskView.diskImgView.transform = CGAffineTransformRotate(cell.diskView.diskImgView.transform, M_PI_4 / 100);
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

- (void)scrollToIndex:(NSInteger)targetIndex {
    if (targetIndex >= self.models.count * 100) {
        targetIndex = self.models.count * 100 * 0.5;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)makeScrollViewScrollToIndex:(NSInteger)index {
    [self scrollToIndex:(NSInteger)(self.models.count * 100 * 0.5 + index)];
}

- (void)scrollChangeIsNext:(BOOL)isNext finished:(dispatch_block_t)finished {
    self.finished = finished;
    self.isChange = YES;
    [self pausedWithAnimated:YES];
    NSInteger index = 0;
    isNext ? (index = self.index + 1) : (index = self.index - 1);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:isNext ? UICollectionViewScrollPositionLeft : UICollectionViewScrollPositionRight animated:YES];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
        [XKMusicCoverViewCell registerToCollectionView:_collectionView];
    }
    return _collectionView;
}

- (UIView *)sepLineView {
    if (!_sepLineView) {
        _sepLineView = [[UIView alloc] init];
        _sepLineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
    }
    return _sepLineView;
}

- (UIView *)diskBgView {
    if (!_diskBgView) {
        _diskBgView = [[UIView alloc] init];
        _diskBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    return _diskBgView;
}

- (UIImageView *)needleView {
    if (!_needleView) {
        _needleView = [[UIImageView alloc] init];
        _needleView.image = [UIImage imageNamed:@"cm2_play_needle_play"];
        [_needleView sizeToFit];
        [self setAnchorPoint:CGPointMake(25.0/97, 25.0/153) forView:_needleView];
        _needleView.transform = CGAffineTransformMakeRotation(-M_PI_2 / 3);
    }
    return _needleView;
}

@end


@interface XKMusicCoverViewCell()

@property (nonatomic, strong) XKDiskView *diskView;

@end

@implementation XKMusicCoverViewCell

- (void)setupCell {
    self.backgroundColor = [UIColor clearColor];
}

- (void)buildSubview {
    [self.contentView addSubview:self.diskView];
    [self.diskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    self.diskView.imgurl = imageURL;
}

- (XKDiskView *)diskView {
    if (!_diskView) {
        _diskView = [[XKDiskView alloc] init];
    }
    return _diskView;
}

@end
