//
//  XKToolbar.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/22.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKToolbar : UIView

@property (nonatomic, copy) void(^ClickButtonBlock)(XKToolbarButtonType type);

- (void)toolbarButtonEnabled:(BOOL)enabled;

@end
