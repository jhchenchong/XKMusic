//
//  XKSongListDetailCell.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/6.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKSongListDetailCell.h"

@interface XKSongListDetailCell ()

@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) QMUILabel *detailLabel;
@property (nonatomic, strong) QMUIButton *moreButton;

@property (nonatomic, strong) QMUIButton *numberButton;

@end

@implementation XKSongListDetailCell

- (void)layoutSubviews {
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews) {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"cm4_list_checkbox_ok"];
                    } else {
                        img.image=[UIImage imageNamed:@"cm4_list_checkbox"];
                    }
                }
            }
        }
    }
    [super layoutSubviews];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews) {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img = (UIImageView *)v;
                    if (!self.selected) {
                        img.image = [UIImage imageNamed:@"cm4_list_checkbox"];
                    }
                }
            }
        }
    }
}

- (void)buildSubview {
    [self.contentView addSubview:self.numberButton];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.moreButton];
    
    /// 布局
    [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.width.mas_equalTo(20);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(self.numberButton.mas_right).offset(20);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.left.mas_equalTo(self.numberButton.mas_right).offset(20);
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
}

- (QMUIButton *)numberButton {
    if (!_numberButton) {
        _numberButton = [[QMUIButton alloc] init];
        [_numberButton setTitle:@"12" forState:UIControlStateNormal];
        [_numberButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _numberButton.titleLabel.font = UIFontMake(15);
    }
    return _numberButton;
}

- (QMUILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] init];
        _titleLabel.font = UIFontMake(15);
        _titleLabel.textColor = [XKColorHelper textMainColor];
        _titleLabel.text = @"浪漫恋星空";
    }
    return _titleLabel;
}

- (QMUILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[QMUILabel alloc] init];
        _detailLabel.font = UIFontMake(12);
        _detailLabel.textColor = UIColorGray;
        _detailLabel.text = @"测试小标题";
    }
    return _detailLabel;
}

- (QMUIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [[QMUIButton alloc] init];
        [_moreButton setImage:UIImageMake(@"cm4_act_icn_more") forState:UIControlStateNormal];
        [_moreButton setImage:UIImageMake(@"cm4_act_icn_more_prs") forState:UIControlStateHighlighted];
//        XKWEAK
//        [[_moreButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            XKSTRONG
//        }];
    }
    return _moreButton;
}

@end
