//
//  XKDisMusicController.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDisMusicController.h"
#import "XKDisMusicHeaderView.h"
#import "XKDisMusicSongListRecommendedComponent.h"
#import "XKBannerModel.h"
#import "XKDisPrivatecontentComponent.h"
#import "XKNewsongComponent.h"
#import "XKDJProgramComponent.h"
#import "XKAdjustSectionsController.h"
#import "XKDailyRecommendController.h"
#import "XKSongListController.h"
#import "XKLeaderboardController.h"
#import "XKSongListDetailController.h"

@interface XKDisMusicController ()<XKActionHeaderComponentDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) XKDisMusicHeaderView *headerView;
@property (nonatomic, strong) UIView *tableFootView;
/// 推荐歌单
@property (nonatomic, strong) XKDisMusicSongListRecommendedComponent *disMusicSongListRecommendedComponent;
/// 独家放送
@property (nonatomic, strong) XKDisPrivatecontentComponent *disPrivatecontentComponent;
/// 最新音乐
@property (nonatomic, strong) XKNewsongComponent *newsongComponent;
/// 主播电台
@property (nonatomic, strong) XKDJProgramComponent *DJProgramComponent;
@property (nonatomic, copy) NSDictionary *componentDict;


@end

@implementation XKDisMusicController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [XKAppDelegateHelper showAnimationButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestBanner];
}

- (void)requestBanner {
    [[XKBannerModel signalForBanner] subscribeNext:^(NSArray<XKBannerModel *> *x) {
        NSArray *banners = [[x.rac_sequence.signal map:^id _Nullable(XKBannerModel * _Nullable value) {
            return value.pic;
        }] toArray];
        self.headerView.cycleScrollView.imageURLStringsGroup = banners;
    }];
}

- (void)initSubviews {
    [super initSubviews];
    [self configTableView];
    [self configTipLabel];
}

- (void)configTableView {
    self.headerView = [[XKDisMusicHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
    self.headerView.backgroundColor = UIColorWhite;
    self.headerView.cycleScrollView.delegate = self;
    XKWEAK
    [[self.headerView.fmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [QMUITips showInfo:@"私人FM"];
    }];
    [[self.headerView.recommendButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        XKSTRONG
        XKDailyRecommendController *dailyRecommendController = [[XKDailyRecommendController alloc] init];
        dailyRecommendController.hidesBottomBarWhenPushed = NO;
        [self.navigationController pushViewController:dailyRecommendController animated:YES];
    }];
    [[self.headerView.songListButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        XKSTRONG
        XKSongListController *songListController = [[XKSongListController alloc] init];
        [self.navigationController pushViewController:songListController animated:YES];
    }];
    [[self.headerView.leaderboardsButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        XKSTRONG
        XKLeaderboardController *leaderboardController = [[XKLeaderboardController alloc] init];
        [self.navigationController pushViewController:leaderboardController animated:YES];
        
    }];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    self.tableView.backgroundColor = UIColorClear;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = self.tableFootView;
    self.disMusicSongListRecommendedComponent = [XKDisMusicSongListRecommendedComponent componentWithTableView:self.tableView delegate:self];
    self.disPrivatecontentComponent = [XKDisPrivatecontentComponent componentWithTableView:self.tableView delegate:nil];
    self.newsongComponent = [XKNewsongComponent componentWithTableView:self.tableView delegate:nil];
    self.DJProgramComponent = [XKDJProgramComponent componentWithTableView:self.tableView delegate:self];
    [self updateSections];
    [self.disMusicSongListRecommendedComponent reloadDataWithTableView:self.tableView inSection:[self.components indexOfObject:self.disMusicSongListRecommendedComponent]];
    [self.disPrivatecontentComponent reloadDataWithTableView:self.tableView inSection:[self.components indexOfObject:self.disPrivatecontentComponent]];
    [self.newsongComponent reloadDataWithTableView:self.tableView inSection:[self.components indexOfObject:self.newsongComponent]];
    [self.DJProgramComponent reloadDataWithTableView:self.tableView inSection:[self.components indexOfObject:self.DJProgramComponent]];
}

- (void)configTipLabel {
    UIView *tipView = [[UIView alloc] init];
    
    QMUIButton *button = [[QMUIButton alloc] init];
    [button setBackgroundImage:UIImageMake(@"cm2_discover_icn_start_bg") forState:UIControlStateNormal];
    [button setImage:UIImageMake(@"cm2_discover_icn_start") forState:UIControlStateNormal];
    [tipView addSubview:button];
    
    QMUILabel *label = [[QMUILabel alloc] init];
    label.text = @"首页内容根据您的口味生成";
    label.textColor = UIColorGray;
    label.font = UIFontMake(12);
    [tipView addSubview:label];
    
    [self.view insertSubview:tipView atIndex:0];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tipView.mas_centerY);
        make.left.mas_equalTo(0);
        make.width.height.mas_equalTo(25);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(button.mas_centerY);
        make.left.mas_equalTo(button.mas_right).offset(10);
    }];
    
    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(55);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(35 + [label.text widthWithStringFont:UIFontMake(12)]);
    }];
}

- (void)updateSections {
    NSMutableArray *mutabArray = @[].mutableCopy;
    NSArray *array =  [[NSUserDefaults standardUserDefaults] objectForKey:kColumnOrder] ? [[NSUserDefaults standardUserDefaults] objectForKey:kColumnOrder] : @[@"0", @"1", @"2", @"3"];
    for (NSString *section in array) {
        [mutabArray addObject:self.componentDict[section]];
    }
    self.components = mutabArray.copy;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    [QMUITips showInfo:[NSString stringWithFormat:@"点击了第%ld张轮播图", (long)index + 1]];
}

- (void)tableComponent:(id<XKTableComponent>)component didTapItemAtIndex:(NSUInteger)index {
    if ([component isKindOfClass:[XKDisMusicSongListRecommendedComponent class]]) {
        XKSongListDetailController *songListDetailController = [[XKSongListDetailController alloc] initWithPersonalizedModel:self.disMusicSongListRecommendedComponent.models[index]];
        songListDetailController.hidesBottomBarWhenPushed = NO;
        [self.navigationController pushViewController:songListDetailController animated:YES];
    }
}

- (UIView *)tableFootView {
    if (!_tableFootView) {
        _tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColorSeparator;
        [_tableFootView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(PixelOne);
        }];
        QMUIGhostButton *button = [[QMUIGhostButton alloc] init];
        button.ghostColor = [XKColorHelper appMainColor];
        [button setTitle:@"调整栏目顺序" forState:UIControlStateNormal];
        button.titleLabel.font = UIFontMake(12);
        [_tableFootView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.tableFootView.mas_centerX);
            make.centerY.mas_equalTo(self.tableFootView.mas_centerY);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(110);
        }];
        
        XKWEAK
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            XKSTRONG
            XKAdjustSectionsController *adjustSectionsController = [[XKAdjustSectionsController alloc] initWithStyle:UITableViewStyleGrouped];
            adjustSectionsController.block = ^{
                [self updateSections];
            };
            QMUINavigationController *nav = [[QMUINavigationController alloc] initWithRootViewController:adjustSectionsController];
            [self presentViewController:nav animated:YES completion:NULL];
        }];
    }
    return _tableFootView;
}

- (NSDictionary *)componentDict {
    if (!_componentDict) {
        _componentDict = @{@"0":self.disMusicSongListRecommendedComponent, @"1":self.disPrivatecontentComponent, @"2":self.newsongComponent, @"3":self.DJProgramComponent};
    }
    return _componentDict;
}

@end
