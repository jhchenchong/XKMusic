//
//  XKHeaderComponent.h
//  XKComponentTableView
//
//  Created by 浪漫恋星空 on 2018/2/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKBaseComponent.h"

@interface XKHeaderComponent : XKBaseComponent

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIView *accessoryView;
@property (nonatomic, strong) UIImageView *leftImageView;

- (CGRect)accessoryRectForBounds:(CGRect)bounds;
- (CGRect)leftImageViewRectForBounds:(CGRect)bounds;
- (void)handleTapHeader;

@end
