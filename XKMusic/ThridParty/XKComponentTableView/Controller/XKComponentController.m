//
//  XKComponentController.m
//  XKComponentTableView
//
//  Created by 浪漫恋星空 on 2018/2/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKComponentController.h"

@interface XKComponentController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) UITableViewStyle style;

@end

@implementation XKComponentController

- (instancetype)initTableViewWithStyle:(UITableViewStyle)style {
    if (self = [super init]) {
        _style = style;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = [self tableViewRectForBounds:self.view.bounds];
}

#pragma mark - UITableView Datasource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.components.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.components[section].numberOfItems;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.components[section].heightForComponentHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.components[section].heightForComponentFooter;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return self.components[section].heightForComponentHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.components[indexPath.section] heightForComponentItemAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.components[indexPath.section] heightForComponentItemAtIndex:indexPath.row];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.components[section] respondsToSelector:@selector(headerForTableView:)]) {
        return [self.components[section] headerForTableView:tableView];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self.components[section] respondsToSelector:@selector(footerForTableView:)]) {
        return [self.components[section] footerForTableView:tableView];
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.components[indexPath.section] cellForTableView:tableView atIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self.components[section] respondsToSelector:@selector(willDisplayHeader:)]) {
        [self.components[section] willDisplayHeader:view];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self.components[section] respondsToSelector:@selector(willDisplayFooter:)]) {
        [self.components[section] willDisplayFooter:view];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.components[indexPath.section] respondsToSelector:@selector(willDisplayCell:forIndexPath:)]) {
        [self.components[indexPath.section] willDisplayCell:cell forIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.components[indexPath.section] respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [self.components[indexPath.section] didSelectItemAtIndex:indexPath.row];
    }
}

- (CGRect)tableViewRectForBounds:(CGRect)bounds {
    return bounds;
}

- (void)setComponents:(NSArray<id<XKTableComponent>> *)components {
    if (_components != components) {
        _components = components;
        [self.tableView reloadData];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[self tableViewRectForBounds:self.view.bounds] style:self.style];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

@end
