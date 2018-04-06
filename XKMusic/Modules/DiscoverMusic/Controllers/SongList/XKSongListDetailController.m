//
//  XKSongListDetailController.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKSongListDetailController.h"
#import "XKPlaylistDetailModel.h"
#import "XKDailyRecommendHeaderView.h"
#import "UIImage+Blur.h"
#import "XKSongListHeaderCell.h"
#import "XKSongListInfoModel.h"
#import "CBAutoScrollLabel.h"
#import "XKSongListDetailCell.h"

#define CELLHEIGHT KAUTOSCALE(250)
#define IMAGEVIEWHEIGHT (kTopHeight + CELLHEIGHT)

@interface XKSongListDetailController ()

@property (nonatomic, strong) XKPersonalizedModel *model;
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) XKSongListInfoModel *infoModel;
@property (nonatomic, strong) CBAutoScrollLabel *titleLabel;

@property (nonatomic, copy) NSArray<XKCellDataAdapter *> *adapters;

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
    self.navigationItem.titleView = self.titleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
}

- (void)requestData {
    [[XKPlaylistDetailModel signalForPlaylistDetailModelWithID:[NSString stringWithFormat:@"%ld", self.model.ID]] subscribeNext:^(XKPlaylistDetailModel *x) {
        self.infoModel = [XKSongListInfoModel modelWithName:x.name desc:x.desc playcount:x.playCount cover:self.model.picUrl creatorname:x.creator.nickname creatorIcon:x.creator.avatarUrl subscribedCount:x.subscribedCount commentCount:x.commentCount shareCount:x.shareCount];
        NSMutableArray *arrayM = @[].mutableCopy;
        for (Tracks *tracks in x.tracks) {
            XKMusicModel *model = [[XKMusicModel alloc] init];
            model.music_id = [NSString stringWithFormat:@"%ld", (long)tracks.ID];
            model.music_name = tracks.name;
            model.music_artist = tracks.artists[0].name;
            model.albumname = tracks.album.name;
            [arrayM addObject:model];
        }
        self.adapters = arrayM.copy;
        [self.tableView reloadData];
    } error:^(NSError * _Nullable error) {
        
    }];
}

- (void)initSubviews {
    [super initSubviews];
    self.tableView.backgroundColor = UIColorClear;
    [XKSongListDetailCell registerToTableView:self.tableView];
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
    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        XKSongListDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKSongListDetailCell"];
        return cell;
    } else {
        XKSongListHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKSongListHeaderCell"];
        if (self.infoModel) {
            cell.model = self.infoModel;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CELLHEIGHT;
    }
    return 60;
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
            if ([self.titleLabel.text isEqualToString:@"歌单"]) {
                self.titleLabel.text = self.infoModel.name;
            }
        } else {
            if (![self.titleLabel.text isEqualToString:@"歌单"]) {
                self.titleLabel.text = @"歌单";
            }
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
                [self setImgWithFadeAnimationUIImage:[image blurredImageWithRadius:100 iterations:10 tintColor:UIColorBlack]];
            });
        }];
    }
    return _bgImageView;
}

- (CBAutoScrollLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[CBAutoScrollLabel alloc] initWithFrame:CGRectMake(0, 0, KAUTOSCALE(150), [NSString oneLineOfTextHeightWithStringFont:UIFontBoldMake(17)])];
        _titleLabel.text = @"歌单";
        _titleLabel.textColor = UIColorWhite;
        _titleLabel.font = UIFontBoldMake(17);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.scrollSpeed = 20;
        [_titleLabel observeApplicationNotifications];
    }
    return _titleLabel;
}

@end
