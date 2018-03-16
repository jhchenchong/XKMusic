//
//  XKDisPrivatecontentComponent.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/14.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDisPrivatecontentComponent.h"
#import "XKPrivatecontentCell.h"
#import "XKPrivatecontentModel.h"

@interface XKDisPrivatecontentComponent ()

@property (nonatomic, strong) NSArray<XKPrivatecontentModel *> *models;

@end

@implementation XKDisPrivatecontentComponent

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<XKTableComponentDelegate>)delegate  {
    self = [super initWithTableView:tableView delegate:delegate];
    if (self) {
        self.title = @"独家放送";
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
    [collectionView registerClass:[XKPrivatecontentCell class] forCellWithReuseIdentifier:@"XKPrivatecontentCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XKPrivatecontentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XKPrivatecontentCell"
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
    if (indexPath.row == 2) {
        return CGSizeMake(SCREEN_WIDTH, KAUTOSCALE(160));
    } else {
        return CGSizeMake((SCREEN_WIDTH - 3) / 2, KAUTOSCALE(160));
    }
}

- (void)reloadDataWithTableView:(UITableView *)tableView inSection:(NSInteger)section {
    [[XKPrivatecontentModel signalForPrivatecontentModels] subscribeNext:^(NSArray<XKPrivatecontentModel *> *x) {
        self.models = x;
        [self.collectionView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setNeedUpdateHeightForSection:section];
        });
    }];
}

@end
