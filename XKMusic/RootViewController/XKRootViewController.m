//
//  XKRootViewController.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKRootViewController.h"
#import "QMUITabBarViewController+XKCategory.h"
#import "XKDiscoverController.h"
#import "XKVideoController.h"
#import "XKMyMusicController.h"
#import "XKFriendsController.h"
#import "XKAccountController.h"

@interface XKRootViewController ()

@end

@implementation XKRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configChildviewControllers];
    [self configTabBar];
}

- (void)configTabBar {
    UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    visualEfView.frame = CGRectMake(0, -1, CGRectGetWidth(self.tabBar.frame), CGRectGetHeight(self.tabBar.frame)+1);
    visualEfView.alpha = 1;
    [self.tabBar insertSubview:visualEfView atIndex:0];
}

- (void)configChildviewControllers {
    UIOffset titlePosition = UIOffsetMake(0, -2);
    
    /// 发现音乐
    XKDiscoverController *discoverController = [[XKDiscoverController alloc] init];
    discoverController.hidesBottomBarWhenPushed = NO;
    discoverController.automaticallyCalculatesItemWidths = YES;
    discoverController.titleSizeSelected = 15;;
    discoverController.titleSizeNormal = 15;
    discoverController.titleColorSelected = [XKColorHelper appMainColor];
    discoverController.titleColorNormal = [XKColorHelper textMainColor];
    discoverController.menuViewStyle = WMMenuViewStyleLine;
    [self addChildViewController:discoverController title:@"发现" image:@"cm2_btm_icn_discovery" selectedImage:@"cm2_btm_icn_discovery_prs" imageInsets:UIEdgeInsetsZero titlePosition:titlePosition navControllerClass:NSClassFromString(@"QMUINavigationController")];
    
    /// 视频
    XKVideoController *videoController = [[XKVideoController alloc] init];
    videoController.hidesBottomBarWhenPushed = NO;
    videoController.automaticallyCalculatesItemWidths = YES;
    videoController.titleSizeSelected = 15;
    videoController.itemsMargins = @[@15,@30,@30,@30,@30,@30,@30,@15];
    videoController.titleSizeNormal = 15;
    videoController.titleColorSelected = [XKColorHelper appMainColor];
    videoController.titleColorNormal = [XKColorHelper textMainColor];
    videoController.menuViewStyle = WMMenuViewStyleLine;
    [self addChildViewController:videoController title:@"视频" image:@"cm4_btm_icn_video" selectedImage:@"cm4_btm_icn_video_prs" imageInsets:UIEdgeInsetsZero titlePosition:titlePosition navControllerClass:NSClassFromString(@"QMUINavigationController")];
    
    /// 我的音乐
    XKMyMusicController *myMusicController = [[XKMyMusicController alloc] init];
    myMusicController.hidesBottomBarWhenPushed = NO;
    [self addChildViewController:myMusicController title:@"我的" image:@"cm2_btm_icn_music" selectedImage:@"cm2_btm_icn_music_prs" imageInsets:UIEdgeInsetsZero titlePosition:titlePosition navControllerClass:NSClassFromString(@"QMUINavigationController")];
    
    /// 朋友
    XKFriendsController *friendsController = [[XKFriendsController alloc] init];
    friendsController.hidesBottomBarWhenPushed = NO;
    friendsController.menuViewStyle = WMMenuViewStyleSegmented;
    friendsController.showOnNavigationBar = YES;
    friendsController.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    friendsController.titleColorSelected = [XKColorHelper appMainColor];
    friendsController.titleColorNormal = UIColorWhite;
    friendsController.progressColor = UIColorWhite;
    friendsController.titleSizeSelected = 15;
    friendsController.titleSizeNormal = 15;
    [self addChildViewController:friendsController title:@"朋友" image:@"cm2_btm_icn_friend" selectedImage:@"cm2_btm_icn_friend_prs" imageInsets:UIEdgeInsetsZero titlePosition:titlePosition navControllerClass:NSClassFromString(@"QMUINavigationController")];
    
    /// 账号
    XKAccountController *accountController = [[XKAccountController alloc] init];
    accountController.hidesBottomBarWhenPushed = NO;
    [self addChildViewController:accountController title:@"账号" image:@"cm2_btm_icn_account" selectedImage:@"cm2_btm_icn_account_prs" imageInsets:UIEdgeInsetsZero titlePosition:titlePosition navControllerClass:NSClassFromString(@"QMUINavigationController")];
}

@end
