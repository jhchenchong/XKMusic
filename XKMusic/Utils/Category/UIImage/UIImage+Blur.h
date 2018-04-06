//
//  UIImage+Blur.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/6.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;

@end
