//
//  UITabBarController+Animation.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/2.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "UITabBarController+Animation.h"

@implementation UITabBarController (Animation)

- (void)hideTabBar:(BOOL)hide animated:(BOOL)animated {
    if (hide == YES) {
        if (self.tabBar.frame.origin.y == self.view.frame.size.height) return;
    } else {
        if (self.tabBar.frame.origin.y == self.view.frame.size.height - TabBarHeight) return;
    }
    if (animated == YES) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        if (hide == YES) {
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + TabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            self.tabBar.alpha = 0.0;
        } else {
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - TabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            self.tabBar.alpha = 1.0;
        }
        [UIView commitAnimations];
    } else {
        if (hide == YES) {
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + TabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            self.tabBar.alpha = 0.0;
        } else {
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - TabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            self.tabBar.alpha = 1.0;
        }
    }
}

@end
