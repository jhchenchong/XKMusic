//
//  XKAppDelegateHelper.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/20.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKAppDelegateHelper.h"

@implementation XKAppDelegateHelper

+ (void)showAnimationButton {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate showAnimationButton];
}

+ (void)hideAnimationButton {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate hideAnimationButton];
}

+ (UIViewController *)visibleViewController {
    UIViewController *rootViewController = keyWindow.rootViewController;
    return [rootViewController qmui_visibleViewControllerIfExist];
}

@end
