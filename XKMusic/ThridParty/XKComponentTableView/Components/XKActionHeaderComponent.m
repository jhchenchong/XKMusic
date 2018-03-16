//
//  XKActionHeaderComponent.m
//  XKComponentTableView
//
//  Created by 浪漫恋星空 on 2018/2/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKActionHeaderComponent.h"

@interface XKActionHeaderComponent ()

@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XKActionHeaderComponent

@dynamic delegate;

- (void)setActionButton:(UIButton *)actionButton {
    self.accessoryView = actionButton;
}

- (void)setImageView:(UIImageView *)imageView {
    self.leftImageView = imageView;
}

- (UIButton *)actionButton {
    if (!self.accessoryView) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:button.tintColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onActionButton:) forControlEvents:UIControlEventTouchUpInside];
        self.actionButton = button;
    }
    return (UIButton *)self.accessoryView;
}

- (UIImageView *)imageView {
    if (!self.leftImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        self.imageView = imageView;
    }
    return self.leftImageView;
}

- (void)setActionTitle:(NSString *)actionTitle {
    if (_actionTitle != actionTitle) {
        _actionTitle = actionTitle;
        [self.actionButton setTitle:_actionTitle forState:UIControlStateNormal];
        [self.actionButton sizeToFit];
    }
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:imageName];
    [self.imageView sizeToFit];
}

- (void)setActionImageName:(NSString *)actionImageName {
    _actionImageName = actionImageName;
    [self.actionButton setImage:[UIImage imageNamed:actionImageName] forState:UIControlStateNormal];
    [self.actionButton sizeToFit];
}

- (void)onActionButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tableComponent:didTapActionButton:)]) {
        [self.delegate tableComponent:self didTapActionButton:self.actionButton];
    }
}

- (void)handleTapHeader {
    if ([self.delegate respondsToSelector:@selector(tableComponentDidTapHeaderView:)]) {
        [self.delegate tableComponentDidTapHeaderView:self];
    }
}

@end
