//
//  XKToolbar.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/22.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKToolbar.h"

@interface XKToolbar ()

@property (nonatomic, strong) UIToolbar *contentView;
@property (nonatomic, strong) QMUIButton *nextButton;
@property (nonatomic, strong) QMUIButton *addButton;
@property (nonatomic, strong) QMUIButton *downloadButton;
@property (nonatomic, strong) QMUIButton *deleteButton;
@property (nonatomic, assign) BOOL flag;

@end

@implementation XKToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.nextButton = [self configButtonWithImageName:@"cm2_btmlay_btn_next" title:@"下一首播放" buttonType:XKToolbarButtonTypeNext];
        self.addButton = [self configButtonWithImageName:@"cm2_btmlay_btn_add" title:@"收藏到歌单" buttonType:XKToolbarButtonTypeAdd];
        self.downloadButton = [self configButtonWithImageName:@"cm2_btmlay_btn_dld" title:@"下载" buttonType:XKToolbarButtonTypeDownload];
        self.deleteButton = [self configButtonWithImageName:@"cm2_btmlay_btn_dlt" title:@"删除下载" buttonType:XKToolbarButtonTypeDelete];
        self.contentView = [[UIToolbar alloc] init];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColorSeparator;
        
        [self insertSubview:self.contentView atIndex:0];
        [self addSubview:self.nextButton];
        [self addSubview:self.addButton];
        [self addSubview:self.downloadButton];
        [self addSubview:self.deleteButton];
        [self addSubview:lineView];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [@[self.nextButton, self.addButton, self.downloadButton, self.deleteButton] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KAUTOSCALE(75) leadSpacing:KAUTOSCALE(20) tailSpacing:KAUTOSCALE(20)];
        [@[self.nextButton, self.addButton, self.downloadButton, self.deleteButton] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self.mas_centerY).offset(-iPhoneX_BOTTOM_HEIGHT / 2);
        }];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(PixelOne);
            make.height.mas_equalTo(PixelOne);
        }];
    }
    return self;
}

- (QMUIButton *)configButtonWithImageName:(NSString *)imageName title:(NSString *)title buttonType:(XKToolbarButtonType)buttonType {
    QMUIButton *button = [[QMUIButton alloc] init];
    NSString *disImageName = [NSString stringWithFormat:@"%@_dis", imageName];
    NSString *prsImageName = [NSString stringWithFormat:@"%@_prs", imageName];
    [button setImagePosition:QMUIButtonImagePositionTop];
    [button setImage:UIImageMake(imageName) forState:UIControlStateNormal];
    [button setImage:UIImageMake(disImageName) forState:UIControlStateDisabled];
    [button setImage:UIImageMake(prsImageName) forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = UIFontMake(12);
    button.enabled = NO;
    XKWEAK
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        XKSTRONG
        XKBLOCK_EXEC(self.ClickButtonBlock, buttonType)
    }];
    return button;
}

- (void)toolbarButtonEnabled:(BOOL)enabled {
    /// 如果连续进来的状态是没有变的 就不要去改变状态
    if (_flag == enabled) {
        return;
    }
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[QMUIButton class]]) {
            QMUIButton *button = (QMUIButton *)view;
            button.enabled = enabled;
        }
    }
    _flag = enabled;
}

@end
