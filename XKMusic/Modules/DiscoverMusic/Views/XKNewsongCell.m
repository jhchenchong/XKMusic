//
//  XKNewsongCell.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/14.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKNewsongCell.h"

@interface XKNewsongCell ()

@property (nonatomic, strong) LKImageView *imageView;
@property (nonatomic, strong) QMUILabel *label;
@property (nonatomic, strong) QMUILabel *detailLabel;

@end

@implementation XKNewsongCell

- (void)buildSubview {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.detailLabel];
    
    /// 布局
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(self.contentView.mas_width);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(5);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label.mas_bottom).offset(0);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
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
        _label.textColor = [XKColorHelper textMainColor];
        _label.font = UIFontMake(12);
        [_label sizeToFit];
    }
    return _label;
}

- (QMUILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[QMUILabel alloc] init];
        _detailLabel.textColor = UIColorGray;
        _detailLabel.font = UIFontMake(11);
        [_detailLabel sizeToFit];
    }
    return _detailLabel;
}

- (void)setModel:(XKNewsongModel *)model {
    _model = model;
    self.label.text = model.name;
    self.detailLabel.text = model.song.artists[0].name;
    self.imageView.URL = model.song.album.blurPicUrl;
    
}

@end
