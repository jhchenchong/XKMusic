//
//  XKDiscoverController.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDiscoverController.h"
#import "XKDisMusicController.h"
#import "XKDisRadioController.h"
#import "XKCustomSearchBar.h"
#import "XKSearchHeaderView.h"

@interface XKDiscoverController ()<XKCustomSearchBarDelegate, QMUITableViewDataSource, QMUITableViewDelegate>

@property (nonatomic, strong) XKCustomSearchBar *searchBar;
@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) QMUITableView *searchSuggestionTableView;
@property (nonatomic, strong) XKSearchHeaderView *headerView;
@property (nonatomic, strong) UIVisualEffectView *visualEfView;

@property (nonatomic, assign) BOOL isScrolling;

@end

@implementation XKDiscoverController

- (BOOL)shouldCustomNavigationBarTransitionWhenPushDisappearing {
    return YES;
}

- (BOOL)shouldCustomNavigationBarTransitionWhenPopDisappearing {
    return YES;
}

- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.titleView.title = nil;
    [self configLeftButtonItem];
    [self configRightButtonItem];
    self.navigationItem.titleView = self.searchBar;
}

- (void)configLeftButtonItem {
    self.navigationItem.leftBarButtonItem = [QMUINavigationButton barButtonItemWithImage:UIImageMake(@"cm2_topbar_icn_mic") tintColor:[UIColor whiteColor] position:QMUINavigationButtonPositionLeft target:self action:@selector(handleLeftBarButtonItemEvent)];
}

- (void)configRightButtonItem {
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithImage:[UIImage qmui_imageWithColor:[UIColor clearColor] size:CGSizeMake(28, 28) cornerRadius:0] tintColor:[XKColorHelper appMainColor] position:QMUINavigationButtonPositionRight target:self action:@selector(handleRightBarButtonItemEvent)];
}

- (void)handleCancel {
    [self.tableView removeFromSuperview];
    self.isScrolling = NO;
    [self configLeftButtonItem];
    [self configRightButtonItem];
    self.searchBar.text = nil;
    [self.searchBar setIconAlign:XKCustomSearchBarIconAlignCenter];
    [self.searchBar resignFirstResponder];
}

- (void)handleLeftBarButtonItemEvent {
    
}

- (void)handleRightBarButtonItemEvent {
    
}

- (void)initSubviews {
    [super initSubviews];
    [XKCustomCell registerToTableView:self.tableView];
    self.headerView.mj_h = [self.headerView headerViewHeight];
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark -- WMPageControllerDelegate WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 2;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    UIViewController *controller = nil;
    switch (index) {
        case 0:
            controller = [[XKDisMusicController alloc] initTableViewWithStyle:UITableViewStyleGrouped];
            break;
        case 1:
            controller = [[XKDisRadioController alloc] init];
            break;
    }
    return controller;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return @[@"发现音乐", @"主播电台"][index];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    menuView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    if (![menuView.subviews containsObject:self.visualEfView]) {
        [menuView insertSubview:self.visualEfView atIndex:0];
    }
    return CGRectMake(0, kTopHeight, SCREEN_WIDTH, 40);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, kTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTopHeight);
}

- (void)searchBarTextDidBeginEditing:(XKCustomSearchBar *)searchBar {
    if (![self.view.subviews containsObject:self.tableView]) {
        [self.view addSubview:self.tableView];
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
        [self.navigationItem setRightBarButtonItem:[QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"取消" position:QMUINavigationButtonPositionRight target:self action:@selector(handleCancel)] animated:YES];
        self.searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    }
}

- (BOOL)searchBarShouldBeginEditing:(XKCustomSearchBar *)searchBar {
    return !self.isScrolling;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XKCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKCustomCell"];
    cell.textLabel.text = @"浪漫恋星空";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    if (scrollView == self.tableView) {
        self.isScrolling = YES;
        [self.searchBar setIconAlign:XKCustomSearchBarIconAlignLeft];
        if (QMUIKeyboardManager.isKeyboardVisible) {
            [self.searchBar resignFirstResponder];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [super scrollViewDidEndScrollingAnimation:scrollView];
    if (scrollView == self.tableView) {
        self.isScrolling = NO;
    }
}

- (XKCustomSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[XKCustomSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.iconImage = UIImageMake(@"cm2_topbar_icn_search");
        _searchBar.iconAlign = XKCustomSearchBarIconAlignCenter;
        _searchBar.isHiddenCancelButton = YES;
        _searchBar.delegate = self;
        _searchBar.textColor = [XKColorHelper textMainColor];
        [_searchBar setPlaceholder:@"浪漫恋星空"];
        [_searchBar sizeToFit];
    }
    return _searchBar;
}

- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorWhite;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (XKSearchHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[XKSearchHeaderView alloc] initWithFrame:CGRectZero];
    }
    return _headerView;
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
