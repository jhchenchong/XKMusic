//
//  XKLoadingView.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/7.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKLoadingView.h"

@interface XKLoadingView ()

@property (nonatomic, strong) UIImageView *animationImageView;
@property (nonatomic, strong) QMUILabel *titleLabel;

@end

@implementation XKLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.animationImageView];
    [self addSubview:self.titleLabel];
    [self.animationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
        make.width.height.mas_equalTo(KAUTOSCALE(20));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
    }];
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    [self.animationImageView startAnimating];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (UIImageView *)animationImageView {
    if (!_animationImageView) {
        NSMutableArray *images = @[].mutableCopy;
        for (int i = 0; i < 4; i ++) {
            NSString *imageName = [NSString stringWithFormat:@"cm2_list_loading%d", i + 1];
            [images addObject:UIImageMake(imageName)];
        }
        _animationImageView = [[UIImageView alloc] init];
        _animationImageView.animationImages = images;
        _animationImageView.animationDuration = 0.6;
    }
    return _animationImageView;
}

- (QMUILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(14) textColor:UIColorGray];
        _titleLabel.text = @"正在加载...";
    }
    return _titleLabel;
}

@end
