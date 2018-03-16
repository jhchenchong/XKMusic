//
//  QMUITabBarViewController+XKCategory.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2017/9/21.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface QMUITabBarViewController (XKCategory)

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 *  @param imageInsets   图片位移
 *  @param titlePosition 标题位移
 *  @param navControllerClass 包装子控制器的导航控制器
 */
- (void)addChildViewController:(UIViewController *)childVc
                         title:(NSString *)title
                         image:(NSString *)image
                 selectedImage:(NSString *)selectedImage
                   imageInsets:(UIEdgeInsets)imageInsets
                 titlePosition:(UIOffset)titlePosition
            navControllerClass:(Class)navControllerClass;

/**
 *  设置子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 *  @param imageInsets   图片位移
 *  @param titlePosition 标题位移
 */
- (void)configureChildViewController:(UIViewController *)childVc
                               title:(NSString *)title
                               image:(NSString *)image
                       selectedImage:(NSString *)selectedImage
                         imageInsets:(UIEdgeInsets)imageInsets
                       titlePosition:(UIOffset)titlePosition;

@end
