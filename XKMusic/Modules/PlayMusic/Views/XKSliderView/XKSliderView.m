//
//  XKSliderView.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKSliderView.h"

/// 滑块的大小
#define kSliderBtnWH 19.0
/// 间距
#define kProgressMargin 2.0
/// 进度的宽度
#define kProgressW self.frame.size.width - kProgressMargin
/// 进度的高度
#define kProgressH 3.0

@interface XKSliderView ()
/// 进度背景
@property (nonatomic, strong) UIImageView *bgProgressView;
/// 缓存进度
@property (nonatomic, strong) UIImageView *bufferProgressView;
/// 滑动进度
@property (nonatomic, strong) UIImageView *sliderProgressView;
/// 滑块
@property (nonatomic, strong) XKSliderButton *sliderBtn;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation XKSliderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.allowTapped = YES;
        [self addSubViews];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgProgressView.xk_centerY = self.xk_height * 0.5;
    self.bufferProgressView.xk_centerY = self.xk_height * 0.5;
    self.sliderProgressView.xk_centerY = self.xk_height * 0.5;
    self.bgProgressView.xk_width = self.xk_width - kProgressMargin * 2;
    self.sliderBtn.xk_centerY = self.xk_height * 0.5;
}

- (void)addSubViews {
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.bgProgressView];
    [self addSubview:self.bufferProgressView];
    [self addSubview:self.sliderProgressView];
    [self addSubview:self.sliderBtn];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:self.tapGesture];
    
    self.bgProgressView.frame = CGRectMake(kProgressMargin, 0, 0, kProgressH);
    self.bufferProgressView.frame = self.bgProgressView.frame;
    self.sliderProgressView.frame = self.bgProgressView.frame;
    self.sliderBtn.frame = CGRectMake(0, 0, kSliderBtnWH, kSliderBtnWH);
    
    [self.sliderBtn hideActivityAnim];
}

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    _maximumTrackTintColor = maximumTrackTintColor;
    self.bgProgressView.backgroundColor = maximumTrackTintColor;
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    _minimumTrackTintColor = minimumTrackTintColor;
    self.sliderProgressView.backgroundColor = minimumTrackTintColor;
}

- (void)setBufferTrackTintColor:(UIColor *)bufferTrackTintColor {
    _bufferTrackTintColor = bufferTrackTintColor;
    self.bufferProgressView.backgroundColor = bufferTrackTintColor;
}

- (void)setMaximumTrackImage:(UIImage *)maximumTrackImage {
    _maximumTrackImage = maximumTrackImage;
    self.bgProgressView.image = maximumTrackImage;
    self.maximumTrackTintColor = [UIColor clearColor];
}

- (void)setMinimumTrackImage:(UIImage *)minimumTrackImage {
    _minimumTrackImage = minimumTrackImage;
    self.sliderProgressView.image = minimumTrackImage;
    self.minimumTrackTintColor = [UIColor clearColor];
}

- (void)setBufferTrackImage:(UIImage *)bufferTrackImage {
    _bufferTrackImage = bufferTrackImage;
    self.bufferProgressView.image = bufferTrackImage;
    self.bufferTrackTintColor = [UIColor clearColor];
}

- (void)setValue:(float)value {
    _value = value;
    
    CGFloat finishValue  = self.bgProgressView.frame.size.width * value;
    self.sliderProgressView.xk_width = finishValue;
    
    CGFloat buttonX = (self.xk_width - self.sliderBtn.xk_width) * value;
    self.sliderBtn.xk_left = buttonX;
    self.lastPoint = self.sliderBtn.center;
}

- (void)setBufferValue:(float)bufferValue {
    _bufferValue = bufferValue;
    CGFloat finishValue = self.bgProgressView.xk_width * bufferValue;
    self.bufferProgressView.xk_width = finishValue;
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [self.sliderBtn setBackgroundImage:image forState:state];
    [self.sliderBtn sizeToFit];
}

- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state {
    [self.sliderBtn setImage:image forState:state];
    [self.sliderBtn sizeToFit];
}

- (void)showLoading {
    [self.sliderBtn showActivityAnim];
}

- (void)hideLoading {
    [self.sliderBtn hideActivityAnim];
}

- (void)setAllowTapped:(BOOL)allowTapped {
    _allowTapped = allowTapped;
    if (!allowTapped) {
        [self removeGestureRecognizer:self.tapGesture];
    }
}

- (void)setSliderHeight:(CGFloat)sliderHeight {
    _sliderHeight = sliderHeight;
    
    self.bgProgressView.xk_height = sliderHeight;
    self.bufferProgressView.xk_height = sliderHeight;
    self.sliderProgressView.xk_height = sliderHeight;
}

#pragma mark -- User Action
- (void)sliderBtnTouchBegin:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(sliderTouchBegin:)]) {
        [self.delegate sliderTouchBegin:self.value];
    }
}

- (void)sliderBtnTouchEnded:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(sliderTouchEnded:)]) {
        [self.delegate sliderTouchEnded:self.value];
    }
}

- (void)sliderBtnDragMoving:(UIButton *)btn event:(UIEvent *)event {
    CGPoint point = [event.allTouches.anyObject locationInView:self];
    float value = (point.x - btn.xk_width * 0.5) / (self.xk_width - btn.xk_width);
    value = value >= 1.0 ? 1.0 : value <= 0.0 ? 0.0 : value;
    [self setValue:value];
    if ([self.delegate respondsToSelector:@selector(sliderValueChanged:)]) {
        [self.delegate sliderValueChanged:value];
    }
}

- (void)tapped:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self];
    float value = (point.x - self.bgProgressView.xk_left) * 1.0 / self.bgProgressView.xk_width;
    value = value >= 1.0 ? 1.0 : value <= 0 ? 0 : value;
    [self setValue:value];
    if ([self.delegate respondsToSelector:@selector(sliderTapped:)]) {
        [self.delegate sliderTapped:value];
    }
}

#pragma mark -- 懒加载
- (UIImageView *)bgProgressView {
    if (!_bgProgressView) {
        _bgProgressView = [[UIImageView alloc] init];
        _bgProgressView.backgroundColor = [UIColor grayColor];
        _bgProgressView.clipsToBounds = YES;
    }
    return _bgProgressView;
}

- (UIImageView *)bufferProgressView {
    if (!_bufferProgressView) {
        _bufferProgressView = [[UIImageView alloc] init];
        _bufferProgressView.backgroundColor = [UIColor whiteColor];
        _bufferProgressView.clipsToBounds = YES;
    }
    return _bufferProgressView;
}

- (UIImageView *)sliderProgressView {
    if (!_sliderProgressView) {
        _sliderProgressView = [[UIImageView alloc] init];
        _sliderProgressView.backgroundColor = [UIColor redColor];
        _sliderProgressView.clipsToBounds = YES;
    }
    return _sliderProgressView;
}

- (XKSliderButton *)sliderBtn {
    if (!_sliderBtn) {
        _sliderBtn = [[XKSliderButton alloc] init];
        [_sliderBtn addTarget:self action:@selector(sliderBtnTouchBegin:) forControlEvents:UIControlEventTouchDown];
        [_sliderBtn addTarget:self action:@selector(sliderBtnTouchEnded:) forControlEvents:UIControlEventTouchCancel];
        [_sliderBtn addTarget:self action:@selector(sliderBtnTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
        [_sliderBtn addTarget:self action:@selector(sliderBtnTouchEnded:) forControlEvents:UIControlEventTouchUpOutside];
        [_sliderBtn addTarget:self action:@selector(sliderBtnDragMoving:event:) forControlEvents:UIControlEventTouchDragInside];
    }
    return _sliderBtn;
}

@end

@interface XKSliderButton()

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation XKSliderButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicatorView.hidesWhenStopped = NO;
        self.indicatorView.userInteractionEnabled = NO;
        self.indicatorView.frame = CGRectMake(0, 0, 20, 20);
        self.indicatorView.transform = CGAffineTransformMakeScale(0.6, 0.6);
        
        [self addSubview:self.indicatorView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.indicatorView.center = CGPointMake(self.xk_width / 2, self.xk_height/2);
    self.indicatorView.transform = CGAffineTransformMakeScale(0.6, 0.6);
}

- (void)showActivityAnim {
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
}

- (void)hideActivityAnim {
    self.indicatorView.hidden = YES;
    [self.indicatorView stopAnimating];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, -20, -20);
    return CGRectContainsPoint(bounds, point);
}

@end

@implementation UIView (XKFrame)

- (void)setXk_left:(CGFloat)xk_left {
    CGRect f = self.frame;
    f.origin.x = xk_left;
    self.frame = f;
}

- (CGFloat)xk_left {
    return self.frame.origin.x;
}

- (void)setXk_top:(CGFloat)xk_top {
    CGRect f = self.frame;
    f.origin.y = xk_top;
    self.frame = f;
}

- (CGFloat)xk_top {
    return self.frame.origin.y;
}

- (void)setXk_right:(CGFloat)xk_right {
    CGRect f = self.frame;
    f.origin.x = xk_right - f.size.width;
    self.frame = f;
}

- (CGFloat)xk_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setXk_bottom:(CGFloat)xk_bottom {
    CGRect f = self.frame;
    f.origin.y = xk_bottom - f.size.height;
    self.frame = f;
}

- (CGFloat)xk_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setXk_width:(CGFloat)xk_width {
    CGRect f = self.frame;
    f.size.width = xk_width;
    self.frame = f;
}

- (CGFloat)xk_width {
    return self.frame.size.width;
}

- (void)setXk_height:(CGFloat)xk_height {
    CGRect f = self.frame;
    f.size.height = xk_height;
    self.frame = f;
}

- (CGFloat)xk_height {
    return self.frame.size.height;
}

- (void)setXk_centerX:(CGFloat)xk_centerX {
    CGPoint c = self.center;
    c.x = xk_centerX;
    self.center = c;
}

- (CGFloat)xk_centerX {
    return self.center.x;
}

- (void)setXk_centerY:(CGFloat)xk_centerY {
    CGPoint c = self.center;
    c.y = xk_centerY;
    self.center = c;
}

- (CGFloat)xk_centerY {
    return self.center.y;
}

@end
