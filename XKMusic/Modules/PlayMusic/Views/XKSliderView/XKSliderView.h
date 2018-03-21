//
//  XKSliderView.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XKSliderViewDelegate <NSObject>

@optional

- (void)sliderTouchBegin:(float)value;
- (void)sliderValueChanged:(float)value;
- (void)sliderTouchEnded:(float)value;
- (void)sliderTapped:(float)value;

@end

@interface XKSliderView : UIView

@property (nonatomic, weak) id<XKSliderViewDelegate> delegate;

/// 默认滑杆的颜色
@property (nonatomic, strong) UIColor *maximumTrackTintColor;
/// 滑杆进度颜色
@property (nonatomic, strong) UIColor *minimumTrackTintColor;
/// 缓存进度颜色
@property (nonatomic, strong) UIColor *bufferTrackTintColor;
/// 默认滑杆的图片
@property (nonatomic, strong) UIImage *maximumTrackImage;
/// 滑杆进度的图片
@property (nonatomic, strong) UIImage *minimumTrackImage;
/// 缓存进度的图片
@property (nonatomic, strong) UIImage *bufferTrackImage;
/// 滑杆进度
@property (nonatomic, assign) float value;
/// 缓存进度
@property (nonatomic, assign) float bufferValue;
/// 是否允许点击，默认是yes
@property (nonatomic, assign) BOOL allowTapped;
@property (nonatomic, assign) CGFloat sliderHeight;

// 滑块背景
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;
// 滑块图片
- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state;

- (void)showLoading;
- (void)hideLoading;

@end

@interface XKSliderButton : UIButton

- (void)showActivityAnim;
- (void)hideActivityAnim;

@end

@interface UIView (XKFrame)

@property (nonatomic, assign) CGFloat xk_top;
@property (nonatomic, assign) CGFloat xk_left;
@property (nonatomic, assign) CGFloat xk_right;
@property (nonatomic, assign) CGFloat xk_bottom;
@property (nonatomic, assign) CGFloat xk_width;
@property (nonatomic, assign) CGFloat xk_height;
@property (nonatomic, assign) CGFloat xk_centerX;
@property (nonatomic, assign) CGFloat xk_centerY;

@end
