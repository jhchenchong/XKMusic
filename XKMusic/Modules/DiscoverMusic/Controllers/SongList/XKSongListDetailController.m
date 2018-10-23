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
#import "XKToolbar.h"
#import "XKLoadingView.h"

#define CELLHEIGHT KAUTOSCALE(250)
#define IMAGEVIEWHEIGHT (kTopHeight + CELLHEIGHT)

@interface XKSongListDetailController ()

@property (nonatomic, strong) XKPersonalizedModel *model;
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) XKSongListInfoModel *infoModel;
@property (nonatomic, strong) CBAutoScrollLabel *titleLabel;

@property (nonatomic, copy) NSArray<XKCellDataAdapter *> *adapters;

@property (nonatomic, strong) NSMutableSet<NSNumber *> *selectedItemIndexes;
@property (nonatomic, strong) XKToolbar *toolbar;
@property (nonatomic, strong) XKLoadingView *loadingView;

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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resetHeaderView];
    self.tableView.editing = NO;
    [self.selectedItemIndexes removeAllObjects];
    [UIView animateWithDuration:0.3 animations:^{
        self.toolbar.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, TabBarHeight);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [XKAppDelegateHelper showAnimationButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchInfoModel];
    [self requestData];
}

- (void)requestData {
    [[XKPlaylistDetailModel signalForPlaylistDetailModelWithID:[NSString stringWithFormat:@"%ld", self.model.ID]] subscribeNext:^(XKPlaylistDetailModel *x) {
        [self.loadingView dismiss];
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
        self.adapters = [arrayM.rac_sequence.signal map:^id _Nullable(XKMusicModel *value) {
            return [XKSongListDetailCell dataAdapterWithData:value];
        }].toArray;
        [self.tableView reloadData];
    } error:^(NSError * _Nullable error) {
        [self.loadingView dismiss];
    }];
}

- (void)fetchInfoModel {
    self.infoModel = [[XKSongListInfoModel alloc] init];
    self.infoModel.name = self.model.name;
    self.infoModel.cover = self.model.picUrl;
}

- (void)initSubviews {
    [super initSubviews];
    self.tableView.backgroundColor = UIColorClear;
    [XKSongListDetailCell registerToTableView:self.tableView];
    [XKSongListHeaderCell registerToTableView:self.tableView];
    [XKDailyRecommendHeaderView registerToTableView:self.tableView];
    [self.view insertSubview:self.bgImageView belowSubview:self.tableView];
    [self.view addSubview:self.toolbar];
    [self.loadingView showInView:self.view];
}

- (void)layoutTableView {
    self.tableView.frame = CGRectMake(0, kTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTopHeight);
}

- (void)resetHeaderView {
    XKDailyRecommendHeaderView *headerView = (XKDailyRecommendHeaderView *)[self.tableView headerViewForSection:1];
    [headerView resetHeaderView];
}

- (void)handleToolbarButtonEnble {
    if (self.tableView.editing == YES) {
        if (self.selectedItemIndexes.count == 0) {
            [self.toolbar toolbarButtonEnabled:NO];
        } else {
            [self.toolbar toolbarButtonEnabled:YES];
        }
    }
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
        XKSongListDetailCell *cell = (XKSongListDetailCell *)[tableView dequeueReusableCellAndLoadDataWithAdapter:self.adapters[indexPath.row] indexPath:indexPath];
        if ([self.selectedItemIndexes containsObject:@(indexPath.row)]) {
            cell.selected = YES;
        } else {
            cell.selected = NO;
        }
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
        XKWEAK
        headerView.SelectedBlock = ^(BOOL isClick) {
            XKSTRONG
            if (isClick) {
                NSArray<NSIndexPath *> *indexPaths = [self.tableView indexPathsForRowsInRect:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.contentSize.height)];
                [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj.section != 0) {
                        [self.selectedItemIndexes addObject:@(obj.row)];
                    }
                }];
            } else {
                [self.selectedItemIndexes removeAllObjects];
            }
            [self handleToolbarButtonEnble];
            [self.tableView reloadData];
        };
        headerView.MultipleButtonBlock = ^(BOOL isClick) {
            XKSTRONG
            self.tableView.editing = isClick;
            [self.selectedItemIndexes removeAllObjects];
            if (isClick == NO) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.toolbar.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, TabBarHeight);
                } completion:^(BOOL finished) {
                    [self.tabBarController hideTabBar:NO animated:YES];
                }];
            } else {
                [self handleToolbarButtonEnble];
                NSArray <XKCustomCell *> *cells = [tableView visibleCells];
                __block NSIndexPath *indexPath = nil;
                [cells enumerateObjectsUsingBlock:^(XKCustomCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[XKSongListDetailCell class]]) {
                        indexPath = ((XKSongListDetailCell *)obj).indexPath;
                        *stop = YES;
                    }
                }];
                NSInteger row = 0;
                (indexPath.row == 0) ? (row = indexPath.row) : (row = indexPath.row + 1);
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                [self.tabBarController hideTabBar:YES animated:YES];
                [UIView animateWithDuration:0.3 animations:^{
                    self.toolbar.frame = CGRectMake(0, SCREEN_HEIGHT - TabBarHeight, SCREEN_WIDTH, TabBarHeight);
                }];
            }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (self.tableView.editing == YES) {
            XKDailyRecommendHeaderView *headerView = (XKDailyRecommendHeaderView *)[tableView headerViewForSection:indexPath.section];
            if ([self.selectedItemIndexes containsObject:@(indexPath.row)]) {
                [self.selectedItemIndexes removeObject:@(indexPath.row)];
                headerView.isSelected = NO;
            } else {
                [self.selectedItemIndexes addObject:@(indexPath.row)];
                if (self.selectedItemIndexes.count == [self.tableView indexPathsForRowsInRect:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.contentSize.height)].count - 1) {
                    headerView.isSelected = YES;
                }
            }
            [self handleToolbarButtonEnble];
            [self.tableView reloadData];
        } else {
//            [self.navigationController pushViewController:[XKPlayerController sharedInstance] animated:YES];
//            NSArray<XKMusicModel *> *musicModels = [self fetchMusicModels];
//            [[XKPlayerController sharedInstance] setupMusicModels:musicModels];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
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

- (NSMutableSet<NSNumber *> *)selectedItemIndexes {
    if (!_selectedItemIndexes) {
        _selectedItemIndexes = [[NSMutableSet alloc] init];
    }
    return _selectedItemIndexes;
}

- (XKToolbar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[XKToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, TabBarHeight)];
        _toolbar.ClickButtonBlock = ^(XKToolbarButtonType type) {
            switch (type) {
                case XKToolbarButtonTypeNext:
                    [QMUITips showInfo:@"下一首播放"];
                    break;
                case XKToolbarButtonTypeAdd:
                    [QMUITips showInfo:@"收藏到歌单"];
                    break;
                case XKToolbarButtonTypeDownload:
                    [QMUITips showInfo:@"下载"];
                    break;
                case XKToolbarButtonTypeDelete:
                    [QMUITips showInfo:@"删除下载"];
                    break;
            }
        };
    }
    return _toolbar;
}

- (XKLoadingView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[XKLoadingView alloc] initWithFrame:CGRectMake(0, 0, KAUTOSCALE(40), KAUTOSCALE(40))];
        _loadingView.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    }
    return _loadingView;
}

@end
