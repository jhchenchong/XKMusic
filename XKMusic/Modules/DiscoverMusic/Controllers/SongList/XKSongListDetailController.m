//
//  XKSongListDetailController.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKSongListDetailController.h"
#import "XKPlaylistDetailModel.h"
#import <UIImageView+WebCache.h>
#import "XKDailyRecommendHeaderView.h"
#import "UIImage+Blur.h"
#import "XKSongListHeaderCell.h"

#define CELLHEIGHT KAUTOSCALE(250)
#define IMAGEVIEWHEIGHT (kTopHeight + CELLHEIGHT)

@interface XKSongListDetailController ()

@property (nonatomic, strong) XKPersonalizedModel *model;
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation XKSongListDetailController

- (instancetype)initWithPersonalizedModel:(XKPersonalizedModel *)model {
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

#pragma mark -- 配置导航栏
- (BOOL)shouldCustomNavigationBarTransitionWhenPushDisappearing {
    return YES;
}

- (BOOL)shouldCustomNavigationBarTransitionWhenPopDisappearing {
    return YES;
}

- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage qmui_imageWithColor:UIColorClear];
}

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.titleView.title = @"歌单";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[XKPlaylistDetailModel signalForPlaylistDetailModelWithID:[NSString stringWithFormat:@"%ld", self.model.ID]] subscribeNext:^(XKPlaylistDetailModel *x) {
        
    } error:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)initSubviews {
    [super initSubviews];
    self.tableView.backgroundColor = UIColorClear;
    [XKCustomCell registerToTableView:self.tableView];
    [XKSongListHeaderCell registerToTableView:self.tableView];
    [XKDailyRecommendHeaderView registerToTableView:self.tableView];
    [self.view insertSubview:self.bgImageView belowSubview:self.tableView];
}

- (void)layoutTableView {
    self.tableView.frame = CGRectMake(0, kTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTopHeight);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        XKCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKCustomCell"];
        cell.textLabel.text = @"浪漫恋星空";
        return cell;
    } else {
        XKSongListHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKSongListHeaderCell"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CELLHEIGHT;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        XKDailyRecommendHeaderView *headerView = (XKDailyRecommendHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"XKDailyRecommendHeaderView"];
        [headerView setHeaderFooterViewBackgroundColor:UIColorWhite];
        headerView.playAllBlock = ^{
            
        };
        headerView.SelectedBlock = ^(BOOL isClick) {
            
        };
        headerView.MultipleButtonBlock = ^(BOOL isClick) {
            
        };
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 50;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    if (offset >= 0) {
        if (offset > CELLHEIGHT) {
            self.bgImageView.qmui_top = -CELLHEIGHT;
        } else {
            self.bgImageView.qmui_top = -offset;
        }
        
        if (offset > CELLHEIGHT * 0.6) {
            self.titleView.title = @"浪漫恋星空";
        } else {
            self.titleView.title = @"歌单";
        }
    } else {
        if (offset == -kTopHeight) {
            self.bgImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, IMAGEVIEWHEIGHT);
            return;
        }
        CGFloat count = (IMAGEVIEWHEIGHT - offset) / IMAGEVIEWHEIGHT;
        self.bgImageView.frame = CGRectMake(-(SCREEN_WIDTH * count - SCREEN_WIDTH) / 2, 0, SCREEN_WIDTH * count, IMAGEVIEWHEIGHT * count);
    }
}

- (void)setImgWithFadeAnimationUIImage:(UIImage *)image {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.bgImageView.layer addAnimation:transition forKey:nil];
    self.bgImageView.image = image;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, IMAGEVIEWHEIGHT)];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_bgImageView sd_setImageWithURL:[NSURL URLWithString:self.model.picUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setImgWithFadeAnimationUIImage:[image blurredImageWithRadius:100 iterations:10 tintColor:[image qmui_averageColor]]];
            });
        }];
    }
    return _bgImageView;
}

@end
