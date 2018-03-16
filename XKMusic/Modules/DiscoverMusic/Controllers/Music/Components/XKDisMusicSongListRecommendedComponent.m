//
//  XKDisMusicSongListRecommendedComponent.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/6.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDisMusicSongListRecommendedComponent.h"
#import "XKPersonalizedModel.h"
#import "XKPersonalizedCell.h"

@interface XKDisMusicSongListRecommendedComponent()

@property (nonatomic, copy) NSArray<XKPersonalizedModel *> *models;

@end

@implementation XKDisMusicSongListRecommendedComponent

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<XKTableComponentDelegate>)delegate  {
    self = [super initWithTableView:tableView delegate:delegate];
    if (self) {
        self.title = @"推荐歌单";
        self.actionImageName = @"cm4_disc_title_arr";
        self.imageName = @"cm4_icn_title_line";
        self.titleFont = UIFontMake(16);
        self.titleColor = [XKColorHelper textMainColor];
    }
    return self;
}

- (CGFloat)heightForComponentHeader {
    return 50;
}

- (void)configureCollectionView:(UICollectionView *)collectionView {
    [super configureCollectionView:collectionView];
    collectionView.contentInset = UIEdgeInsetsZero;
    collectionView.scrollEnabled = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 10;
    [collectionView registerClass:[XKPersonalizedCell class] forCellWithReuseIdentifier:@"XKPersonalizedCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XKPersonalizedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XKPersonalizedCell"
                                                                         forIndexPath:indexPath];
    if (self.models) {
        cell.model = self.models[indexPath.row];
    }
    return cell;
}

- (CGFloat)heightForComponentItemAtIndex:(NSUInteger)index {
    return KAUTOSCALE(320) + 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH - 6) / 3, KAUTOSCALE(160));
}

- (void)reloadDataWithTableView:(UITableView *)tableView inSection:(NSInteger)section {
    [[XKPersonalizedModel signalForPersonalizedModels] subscribeNext:^(NSArray<XKPersonalizedModel *> *x) {
        self.models = x;
        [self.collectionView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setNeedUpdateHeightForSection:section];
        });
    }];
}

@end
