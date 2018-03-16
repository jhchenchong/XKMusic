//
//  XKTableComponent.h
//  XKComponentTableView
//
//  Created by 浪漫恋星空 on 2018/2/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XKTableComponent;

@protocol XKTableComponentDelegate <NSObject>

@optional

- (void)tableComponent:(id<XKTableComponent>)component didTapItemAtIndex:(NSUInteger)index;

@end

@protocol XKTableComponent <NSObject>

@required

- (NSString *)cellIdentifier;
- (NSString *)headerIdentifier;
- (NSString *)footerIdentifier;

- (NSInteger)numberOfItems;
- (CGFloat)heightForComponentHeader;
- (CGFloat)heightForComponentFooter;
- (CGFloat)heightForComponentItemAtIndex:(NSUInteger)index;

- (__kindof UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

- (void)reloadDataWithTableView:(UITableView *)tableView inSection:(NSInteger)section;
- (void)registerWithTableView:(UITableView *)tableView;

@optional
- (__kindof UIView *)headerForTableView:(UITableView *)tableView;
- (__kindof UIView *)footerForTableView:(UITableView *)tableView;

- (void)willDisplayHeader:(__kindof UIView *)header;
- (void)willDisplayFooter:(__kindof UIView *)footer;
- (void)willDisplayCell:(__kindof UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;

- (void)didSelectItemAtIndex:(NSUInteger)index;

@end
