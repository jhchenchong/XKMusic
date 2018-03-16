//
//  XKPrivatecontentCell.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/14.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPrivatecontentCell.h"

@interface XKPrivatecontentCell ()

@property (nonatomic, strong) QMUIButton *button;
@property (nonatomic, strong) LKImageView *imageView;
@property (nonatomic, strong) QMUILabel *label;

@end

@implementation XKPrivatecontentCell

- (void)buildSubview {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.button];
    
    /// 布局
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(KAUTOSCALE(125));
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(5);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(5);
    }];
}

- (QMUIButton *)button {
    if (!_button) {
        _button = [[QMUIButton alloc] init];
        [_button setTitleColor:UIColorWhite forState:UIControlStateNormal];
        _button.titleLabel.font = UIFontBoldMake(11);
        _button.userInteractionEnabled = NO;
    }
    return _button;
}

- (LKImageView *)imageView {
    if (!_imageView) {
        _imageView = [[LKImageView alloc] init];
    }
    return _imageView;
}

- (QMUILabel *)label {
    if (!_label) {
        _label = [[QMUILabel alloc] init];
        _label.numberOfLines = 2;
        _label.textColor = [XKColorHelper textMainColor];
        _label.font = UIFontMake(12);
        [_label sizeToFit];
    }
    return _label;
}

- (void)setModel:(XKPrivatecontentModel *)model {
    _model = model;
    self.imageView.URL = model.sPicUrl;
    self.label.text = model.copywriter;
}

@end
