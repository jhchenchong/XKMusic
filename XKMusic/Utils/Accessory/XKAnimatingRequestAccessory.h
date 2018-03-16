//
//  XKAnimatingRequestAccessory.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKAnimatingRequestAccessory : NSObject<YTKRequestAccessory>

@property(nonatomic, weak) UIView *animatingView;
@property(nonatomic, strong) NSString *animatingText;

- (id)initWithAnimatingView:(UIView *)animatingView;
- (id)initWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText;
+ (id)accessoryWithAnimatingView:(UIView *)animatingView;
+ (id)accessoryWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText;

@end
