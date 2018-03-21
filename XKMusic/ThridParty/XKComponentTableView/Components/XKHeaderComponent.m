//
//  XKHeaderComponent.m
//  XKComponentTableView
//
//  Created by 浪漫恋星空 on 2018/2/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKHeaderComponent.h"

@interface XKHeaderComponent ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation XKHeaderComponent

- (void)registerWithTableView:(UITableView *)tableView {
    [super registerWithTableView:tableView];
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:self.headerIdentifier];
}

- (CGFloat)heightForComponentHeader {
    return 46.f;
}

- (__kindof UIView *)headerForTableView:(UITableView *)tableView {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headerIdentifier];
    header.contentView.backgroundColor = UIColorWhite;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapHeader)];
    [header addGestureRecognizer:tap];
    self.label.text = self.title;
    self.label.font = self.titleFont ?: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.label.textColor = self.titleColor ?: [UIColor darkGrayColor];
    self.label.frame = [self labelRectForBounds:header.bounds];
    [self.label sizeToFit];
    self.accessoryView.frame = [self accessoryRectForBounds:header.bounds];
    self.leftImageView.frame = [self leftImageViewRectForBounds:header.bounds];
    header.textLabel.qmui_top = self.accessoryView.qmui_top;
    [header.contentView addSubview:self.accessoryView];
    [header.contentView addSubview:self.leftImageView];
    [header.contentView addSubview:self.label];
    return header;
}

- (void)willDisplayHeader:(__kindof UIView *)header {
    self.label.font = self.titleFont ?: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    [self.label sizeToFit];
    self.label.frame = [self labelRectForBounds:header.bounds];
    self.accessoryView.frame = [self accessoryRectForBounds:header.bounds];
    self.leftImageView.frame = [self leftImageViewRectForBounds:header.bounds];
}

- (CGRect)accessoryRectForBounds:(CGRect)bounds {
    CGSize size = [self.accessoryView sizeThatFits:bounds.size];
    return CGRectMake(self.label.qmui_width + 15, (bounds.size.height - size.height) / 2, size.width, size.height);
}

- (CGRect)leftImageViewRectForBounds:(CGRect)bounds {
    CGSize size = [self.leftImageView sizeThatFits:bounds.size];
    return CGRectMake(0, (bounds.size.height - size.height) / 2, size.width, size.height);
}

- (CGRect)labelRectForBounds:(CGRect)bounds {
    CGSize size = [self.label sizeThatFits:bounds.size];
    return CGRectMake(10, (bounds.size.height - size.height) / 2, size.width, size.height);
}

- (void)handleTapHeader {
    // 子类如果需要响应整个头部的点击方法 请实现这个方法用代理或者block将事件回调到控制器
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

@end
