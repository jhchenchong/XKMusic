//
//  XKDailyRecommendController.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDailyRecommendController.h"
#import "XKDailyRecommendModel.h"
#import "XKDailyRecommendCell.h"
#import "XKDailyRecommendHeaderView.h"
#import "XKToolbar.h"
#import "XKMusicModel.h"

@interface XKDailyRecommendController ()

@property (nonatomic, copy) NSArray<XKCellDataAdapter *> *adapters;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSMutableSet<NSNumber *> *selectedItemIndexes;

@property (nonatomic, strong) XKToolbar *toolbar;


@end

@implementation XKDailyRecommendController

- (BOOL)shouldCustomNavigationBarTransitionWhenPushDisappearing {
    return YES;
}

- (BOOL)shouldCustomNavigationBarTransitionWhenPopDisappearing {
    return YES;
}

- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
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
    [self requestData];
}

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.titleView.title = @"每日推荐";
}

- (void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.toolbar];
}

- (void)initTableView {
    [super initTableView];
    [XKDailyRecommendCell registerToTableView:self.tableView];
    [XKDailyRecommendHeaderView registerToTableView:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)requestData {
    [[XKDailyRecommendModel signalForDailyRecommendModels] subscribeNext:^(NSArray<XKDailyRecommendModel *> *x) {
        self.adapters = [[x.rac_sequence.signal map:^id _Nullable(XKDailyRecommendModel * _Nullable value) {
            return [XKDailyRecommendCell dataAdapterWithData:value cellHeight:60];
        }] toArray];
        [self.tableView reloadData];
    }];
}

- (void)resetHeaderView {
    XKDailyRecommendHeaderView *headerView = (XKDailyRecommendHeaderView *)[self.tableView headerViewForSection:0];
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

- (NSArray <XKMusicModel *> *)fetchMusicModels {
    NSArray <XKMusicModel *> *musicModels = [[self.adapters.rac_sequence.signal map:^id _Nullable(XKCellDataAdapter * _Nullable value) {
        XKDailyRecommendModel *model = value.data;
        XKMusicModel *musicModel = [[XKMusicModel alloc] init];
        musicModel.music_id = [NSString stringWithFormat:@"%ld", (long)model.ID];
        musicModel.music_name = model.name;
        musicModel.music_artist = model.artists.firstObject.name;
        musicModel.music_cover = model.album.blurPicUrl;
        return musicModel;
    }] toArray];
    return musicModels;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XKDailyRecommendCell *cell = (XKDailyRecommendCell *)[tableView dequeueReusableCellAndLoadDataWithAdapter:self.adapters[indexPath.row] indexPath:indexPath];
    cell.ClickMoreButtonBlock = ^(XKDailyRecommendCell *dailyRecommendCell) {
        [QMUITips showInfo:[NSString stringWithFormat:@"%ld", dailyRecommendCell.indexPath.row]];
    };
    if ([self.selectedItemIndexes containsObject:@(indexPath.row)]) {
        cell.selected = YES;
    } else {
        cell.selected = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.adapters[indexPath.row].cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XKDailyRecommendHeaderView *headerView = (XKDailyRecommendHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"XKDailyRecommendHeaderView"];
    [headerView setHeaderFooterViewBackgroundColor:UIColorWhite];
    XKWEAK
    headerView.playAllBlock = ^{
        XKSTRONG
        NSArray <XKMusicModel *> *musicModels = [self fetchMusicModels];
        if (musicModels.count == 0) {
            [QMUITips showError:@"没有数据别乱点哦🙂🙂🙂" inView:self.view.window hideAfterDelay:1];
            return;
        }
        [[XKPlayerController sharedInstance] playMusicWithIndex:0 musicModels:musicModels];
        [[XKPlayerController sharedInstance] setupMusicModels:musicModels];
        /// 稍微延迟一下再去执行push动画 第一次进入的动画效果看起来要流畅不少
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:[XKPlayerController sharedInstance] animated:YES];
        });
    };
    headerView.SelectedBlock = ^(BOOL isClick) {
        XKSTRONG
        if (isClick) {
            NSArray<NSIndexPath *> *indexPaths = [self.tableView indexPathsForRowsInRect:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.contentSize.height)];
            [self.selectedItemIndexes addObjectsFromArray:[[indexPaths.rac_sequence.signal map:^id _Nullable(NSIndexPath * _Nullable value) {
                return @(value.row);
            }] toArray]];
        } else {
            [self.selectedItemIndexes removeAllObjects];
        }
        [self handleToolbarButtonEnble];
        [self.tableView reloadData];
    };
    headerView.MultipleButtonBlock = ^(BOOL isClick) {
        XKSTRONG
        /// 左滑删除的同时点击了多选按钮 先将tableView的编辑状态设为NO，再继续下面的逻辑
        self.tableView.editing = NO;
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
            [self.tabBarController hideTabBar:YES animated:YES];
            [UIView animateWithDuration:0.3 animations:^{
                self.toolbar.frame = CGRectMake(0, SCREEN_HEIGHT - TabBarHeight, SCREEN_WIDTH, TabBarHeight);
            }];
        }
    };
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.editing == YES) {
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.editing == YES) {
        XKDailyRecommendHeaderView *headerView = (XKDailyRecommendHeaderView *)[tableView headerViewForSection:indexPath.section];
        if ([self.selectedItemIndexes containsObject:@(indexPath.row)]) {
            [self.selectedItemIndexes removeObject:@(indexPath.row)];
            headerView.isSelected = NO;
        } else {
            [self.selectedItemIndexes addObject:@(indexPath.row)];
            if (self.selectedItemIndexes.count == [self.tableView indexPathsForRowsInRect:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.contentSize.height)].count) {
                headerView.isSelected = YES;
            }
        }
        [self handleToolbarButtonEnble];
        [self.tableView reloadData];
    } else {
        NSArray<XKMusicModel *> *musicModels = [self fetchMusicModels];
        [[XKPlayerController sharedInstance] playMusicWithIndex:indexPath.row musicModels:musicModels];
        [[XKPlayerController sharedInstance] setupMusicModels:musicModels];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:[XKPlayerController sharedInstance] animated:YES];
        });
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"不感兴趣";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
        
        NSString *imageName = [NSString stringWithFormat:@"cm2_daily_banner%ld", [XKRandomHelper getRandomNumber:1 to:6]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:UIImageMake(imageName)];
        imageView.frame = _headerView.frame;
        [_headerView addSubview:imageView];
        
        UIImageView *calendarImageView = [[UIImageView alloc] initWithImage:UIImageMake(@"cm2_daily_cal_bg")];
        [_headerView addSubview:calendarImageView];
        
        QMUILabel *label = [[QMUILabel alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd";
        label.text = [dateFormatter stringFromDate:[NSDate date]];
        label.textColor = UIColorWhite;
        label.font = UIFontBoldMake(40);
        [label sizeToFit];
        [calendarImageView addSubview:label];
        label.center = CGPointMake(calendarImageView.center.x, calendarImageView.center.y + 8);
        
        QMUIButton *button = [[QMUIButton alloc] init];
        [button setImagePosition:QMUIButtonImagePositionLeft];
        button.spacingBetweenImageAndTitle = 5;
        [button setTitleColor:UIColorGray forState:UIControlStateNormal];
        button.titleLabel.font = UIFontBoldMake(12);
        [button setImage:UIImageMake(@"cm2_icn_light") forState:UIControlStateNormal];
        [button setTitle:@"根据你的音乐口味生成，每天6:00更新" forState:UIControlStateNormal];
        [_headerView addSubview:button];
        
        FBShimmeringView *shimmmeringView = [[FBShimmeringView alloc] init];
        shimmmeringView.shimmeringPauseDuration = 2;
        shimmmeringView.shimmeringAnimationOpacity = 0.7;
        [_headerView addSubview:shimmmeringView];
        shimmmeringView.contentView = button;
        shimmmeringView.shimmering = YES;
        
        [calendarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.headerView.mas_centerY);
            make.left.mas_equalTo(15);
        }];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-20);
        }];
        [shimmmeringView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-20);
            make.width.mas_equalTo(button);
            make.height.mas_equalTo(button);
        }];
        
    }
    return _headerView;
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

@end
