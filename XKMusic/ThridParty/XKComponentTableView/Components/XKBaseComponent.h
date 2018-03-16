//
//  XKBaseComponent.h
//  XKComponentTableView
//
//  Created by 浪漫恋星空 on 2018/2/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XKTableComponent.h"

@interface XKBaseComponent : NSObject<XKTableComponent>

@property (nonatomic, weak) id<XKTableComponentDelegate> delegate;
@property (nonatomic, weak, readonly) UITableView *tableView;

@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) NSString *headerIdentifier, *footerIdentifier;

+ (instancetype)componentWithTableView:(UITableView *)tableView;
+ (instancetype)componentWithTableView:(UITableView *)tableView delegate:(id<XKTableComponentDelegate>)delegate;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<XKTableComponentDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (void)registerWithTableView:(UITableView *)tableView NS_REQUIRES_SUPER;
- (void)setNeedUpdateHeightForSection:(NSInteger)section;

@end
