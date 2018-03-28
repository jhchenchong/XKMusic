//
//  XKMusicCoverView.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKMusicCoverView.h"
#import "XKDiskView.h"

@interface XKMusicCoverView ()<UIScrollViewDelegate>

/// 顶部分割线
@property (nonatomic, strong) UIView *sepLineView;
/// 唱片背景
@property (nonatomic, strong) UIView *diskBgView;
/// 唱片视图
@property (nonatomic, strong) XKDiskView *leftDiskView;
@property (nonatomic, strong) XKDiskView *centerDiskView;
@property (nonatomic, strong) XKDiskView *rightDiskView;
@property (nonatomic, assign) NSInteger currentIndex;

/// 指针
@property (nonatomic, strong) UIImageView *needleView;
@property (nonatomic, strong) CADisplayLink *displayLink;

/// 是否正在动画
@property (nonatomic, assign) BOOL isAnimation;
@property (nonatomic, strong) NSArray *musics;
@property (nonatomic, copy) dispatch_block_t finished;
/// 是否是由用户点击切换歌曲 
@property (nonatomic, assign) BOOL isChanged;

@end

@implementation XKMusicCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        [self addSubview:self.sepLineView];
        [self addSubview:self.diskBgView];
        [self addSubview:self.diskScrollView];
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
        
        [self.diskScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        self.isAnimation = YES;
        
        [self.diskScrollView addSubview:self.leftDiskView];
        [self.diskScrollView addSubview:self.centerDiskView];
        [self.diskScrollView addSubview:self.rightDiskView];
        
        self.diskScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
        
        [self setScrollViewContentOffsetCenter];
    }
    return self;}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat diskW = CGRectGetWidth(self.diskScrollView.frame);
    CGFloat diskH = CGRectGetHeight(self.diskScrollView.frame);
    
    // 设置frame
    self.leftDiskView.frame   = CGRectMake(0, 0, diskW, diskH);
    self.centerDiskView.frame = CGRectMake(diskW, 0, diskW, diskH);
    self.rightDiskView.frame  = CGRectMake(2 * diskW, 0, diskW, diskH);
}

- (void)networkStateChanged:(NSNotification *)notify {
    self.currentIndex = self.currentIndex;
}

- (void)setupMusicList:(NSArray *)musics index:(NSInteger)currentIndex {
    [self resetCover];
    self.musics = musics;
    [self setCurrentIndex:currentIndex needChange:YES];
}

- (void)resetMusicList:(NSArray *)musics index:(NSInteger)currentIndex {
    self.musics = musics;
    [self setCurrentIndex:currentIndex needChange:NO];
}

- (void)scrollChangeIsNext:(BOOL)isNext finished:(dispatch_block_t)finished {
    self.isChanged = YES;
    self.finished = finished;
    
    CGFloat pointX = isNext ? 2 * SCREEN_WIDTH : 0;
    CGPoint offset = CGPointMake(pointX, 0);
    
    [self pausedWithAnimated:YES];
    [self.diskScrollView setContentOffset:offset animated:YES];
}

- (void)setCurrentIndex:(NSInteger)currentIndex needChange:(BOOL)needChange {
    if (currentIndex >= 0) {
        self.currentIndex = currentIndex;
        
        NSInteger count = self.musics.count;
        NSInteger leftIndex = (currentIndex + count - 1) % count;
        NSInteger rightIndex = (currentIndex + 1) % count;
        
        XKMusicModel *leftM = self.musics[leftIndex];
        XKMusicModel *centerM = self.musics[currentIndex];
        XKMusicModel *rightM = self.musics[rightIndex];
        
        self.centerDiskView.imgurl = centerM.music_cover;
        
        if (needChange) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self setScrollViewContentOffsetCenter];
                
                self.leftDiskView.imgurl = leftM.music_cover;
                self.rightDiskView.imgurl = rightM.music_cover;
                
                if (self.isChanged) {
                    !self.finished ? : self.finished();
                    self.isChanged = NO;
                }
            });
        } else {
            self.leftDiskView.imgurl  = leftM.music_cover;
            self.rightDiskView.imgurl = rightM.music_cover;
        }
    }
}

- (void)setScrollViewContentOffsetCenter {
    [self.diskScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
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
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
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
    self.centerDiskView.diskImgView.transform = CGAffineTransformIdentity;
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)animation {
    self.centerDiskView.diskImgView.transform = CGAffineTransformRotate(self.centerDiskView.diskImgView.transform, M_PI_4 / 100);
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollW = CGRectGetWidth(scrollView.frame);
    if (scrollW == 0) {
       return;
    }
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if (offsetX == 2 * scrollW) {
        
    } else if (offsetX == 0) {
        
    } else if (offsetX <= 0.5 * scrollW) { // 左滑
        NSInteger idx = (self.currentIndex - 1 + self.musics.count) % self.musics.count;
        XKMusicModel *model = self.musics[idx];
        
        if ([self.delegate respondsToSelector:@selector(scrollWillChangeModel:)]) {
            [self.delegate scrollWillChangeModel:model];
        }
    } else if (offsetX >= 1.5 * scrollW) { // 右滑
        NSInteger idx = (self.currentIndex + 1) % self.musics.count;
        XKMusicModel *model = self.musics[idx];
        
        if ([self.delegate respondsToSelector:@selector(scrollWillChangeModel:)]) {
            [self.delegate scrollWillChangeModel:model];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self pausedWithAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(scrollDidScroll)]) {
        [self.delegate scrollDidScroll];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEnd:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEnd:scrollView];
}

- (void)scrollViewDidEnd:(UIScrollView *)scrollView {
    CGFloat scrollW = CGRectGetWidth(scrollView.frame);
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX == 2 * scrollW) {
        NSInteger currentIndex = (self.currentIndex + 1) % self.musics.count;
        [self setCurrentIndex:currentIndex needChange:YES];
        XKMusicModel *model = self.musics[self.currentIndex];
        if ([self.delegate respondsToSelector:@selector(scrollDidChangeModel:)]) {
            [self.delegate scrollDidChangeModel:model];
        }
    } else if (offsetX == 0) {
        NSInteger currentIndex = (self.currentIndex - 1 + self.musics.count) % self.musics.count;
        [self setCurrentIndex:currentIndex needChange:YES];
        XKMusicModel *model = self.musics[self.currentIndex];
        if ([self.delegate respondsToSelector:@selector(scrollDidChangeModel:)]) {
            [self.delegate scrollDidChangeModel:model];
        }
    } else {
        [self setScrollViewContentOffsetCenter];
    }
    if ([self.delegate respondsToSelector:@selector(scrollDidEnd:)]) {
        [self.delegate scrollDidEnd:scrollView];
    }
}

#pragma mark - 懒加载
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

- (UIScrollView *)diskScrollView {
    if (!_diskScrollView) {
        _diskScrollView = [[UIScrollView alloc] init];
        _diskScrollView.delegate = self;
        _diskScrollView.pagingEnabled = YES;
        _diskScrollView.backgroundColor = [UIColor clearColor];
        _diskScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _diskScrollView;
}

- (XKDiskView *)leftDiskView {
    if (!_leftDiskView) {
        _leftDiskView = [[XKDiskView alloc] init];
    }
    return _leftDiskView;
}

- (XKDiskView *)centerDiskView {
    if (!_centerDiskView) {
        _centerDiskView = [[XKDiskView alloc] init];
    }
    return _centerDiskView;
}

- (XKDiskView *)rightDiskView {
    if (!_rightDiskView) {
        _rightDiskView = [[XKDiskView alloc] init];
    }
    return _rightDiskView;
}

- (UIImageView *)needleView {
    if (!_needleView) {
        _needleView = [[UIImageView alloc] init];
        _needleView.image = [UIImage imageNamed:@"cm2_play_needle_play"];
        [_needleView sizeToFit];
    }
    return _needleView;
}

@end
