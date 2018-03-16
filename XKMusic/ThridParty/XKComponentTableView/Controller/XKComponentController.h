//
//  XKComponentController.h
//  XKComponentTableView
//
//  Created by 浪漫恋星空 on 2018/2/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKTableComponent.h"

@interface XKComponentController : QMUICommonViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <id<XKTableComponent> > *components;

- (instancetype)initTableViewWithStyle:(UITableViewStyle)style;

- (CGRect)tableViewRectForBounds:(CGRect)bounds;

@end
