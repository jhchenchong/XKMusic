//
//  XKVideoController.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKVideoController.h"

@interface XKVideoController ()

@property (nonatomic, strong) UIVisualEffectView *visualEfView;

@end

@implementation XKVideoController

- (BOOL)shouldCustomNavigationBarTransitionWhenPushDisappearing {
    return YES;
}

- (BOOL)shouldCustomNavigationBarTransitionWhenPopDisappearing {
    return YES;
}

- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [XKAppDelegateHelper showAnimationButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 7;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor qmui_randomColor];
    return controller;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return @[@"推荐", @"音乐", @"MV", @"舞蹈", @"二次元", @"翻唱", @"游戏"][index];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    menuView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    if (![menuView.subviews containsObject:self.visualEfView]) {
        [menuView insertSubview:self.visualEfView atIndex:0];
    }
    return CGRectMake(0, kTopHeight, SCREEN_WIDTH,40);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, kTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTopHeight);
}

- (UIVisualEffectView *)visualEfView {
    if (!_visualEfView) {
        _visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _visualEfView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        _visualEfView.alpha = 1;
    }
    return _visualEfView;
}

@end
