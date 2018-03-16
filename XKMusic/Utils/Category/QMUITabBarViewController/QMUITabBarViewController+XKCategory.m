//
//  QMUITabBarViewController+XKCategory.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2017/9/21.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "QMUITabBarViewController+XKCategory.h"

@implementation QMUITabBarViewController (XKCategory)

- (void)addChildViewController:(UIViewController *)childVc
                         title:(NSString *)title
                         image:(NSString *)image
                 selectedImage:(NSString *)selectedImage
                   imageInsets:(UIEdgeInsets)imageInsets
                 titlePosition:(UIOffset)titlePosition
            navControllerClass:(Class)navControllerClass {
    
    [self configureChildViewController:childVc title:title image:image selectedImage:selectedImage imageInsets:imageInsets titlePosition:titlePosition];
    
    id nav = nil;
    
    if (navControllerClass == nil) {
        
        nav = [[UINavigationController alloc] initWithRootViewController:childVc];
        
    } else {
        
        nav = [[navControllerClass alloc] initWithRootViewController:childVc];
    }
    
    [self addChildViewController:nav];
}

- (void)configureChildViewController:(UIViewController *)childVc
                               title:(NSString *)title
                               image:(NSString *)image
                       selectedImage:(NSString *)selectedImage
                         imageInsets:(UIEdgeInsets)imageInsets
                       titlePosition:(UIOffset)titlePosition {
    
    childVc.title = title;
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.imageInsets = imageInsets;
    childVc.tabBarItem.titlePositionAdjustment = titlePosition;
}

@end
