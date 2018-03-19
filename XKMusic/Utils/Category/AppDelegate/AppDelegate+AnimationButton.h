//
//  AppDelegate+AnimationButton.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AnimationButton)

@property (nonatomic, strong) QMUIButton *animationButton;

- (void)configAnimationButton;
- (void)showAnimationButton;
- (void)hideAnimationButton;

@end
