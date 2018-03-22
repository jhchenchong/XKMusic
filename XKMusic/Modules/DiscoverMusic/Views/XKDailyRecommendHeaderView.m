//
//  XKDailyRecommendHeaderView.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/22.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDailyRecommendHeaderView.h"

@interface XKDailyRecommendHeaderView ()

/// 多选按钮
@property (nonatomic, strong) QMUIButton *multipleButton;
/// 播放全部按钮
@property (nonatomic, strong) QMUIButton *playAllButton;
/// 全选按钮
@property (nonatomic, strong) QMUIButton *selectedAllButton;

@end

@implementation XKDailyRecommendHeaderView

- (void)buildSubview {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorSeparator;
    
    [self.contentView addSubview:self.multipleButton];
    [self.contentView addSubview:self.playAllButton];
    [self.contentView addSubview:self.selectedAllButton];
    [self.contentView addSubview:lineView];
    
    /// 布局
    [self.playAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(15);
    }];
    [self.multipleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(-15);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-PixelOne);
        make.height.mas_equalTo(PixelOne);
    }];
    [self.selectedAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(15);
    }];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.selectedAllButton.selected = isSelected;
}

- (QMUIButton *)multipleButton {
    if (!_multipleButton) {
        _multipleButton = [[QMUIButton alloc] init];
        [_multipleButton setImagePosition:QMUIButtonImagePositionLeft];
        _multipleButton.spacingBetweenImageAndTitle = 5;
        [_multipleButton setTitle:@"多选" forState:UIControlStateNormal];
        [_multipleButton setTitle:@"完成" forState:UIControlStateSelected];
        [_multipleButton setTitleColor:[XKColorHelper appMainColor] forState:UIControlStateSelected];
        [_multipleButton setTitleColor:[XKColorHelper textMainColor] forState:UIControlStateNormal];
        [_multipleButton setImage:UIImageMake(@"cm2_list_icn_multi") forState:UIControlStateNormal];
        [_multipleButton setImage:[[UIImage alloc] init] forState:UIControlStateSelected];
        XKWEAK
        [[_multipleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            XKSTRONG
            x.selected = !x.selected;
            self.playAllButton.hidden = x.selected;
            self.selectedAllButton.hidden = !x.selected;
            if (x.selected == YES) {
                self.selectedAllButton.selected = NO;
            }
            XKBLOCK_EXEC(self.MultipleButtonBlock, x.selected)
        }];
    }
    return _multipleButton;
}

- (QMUIButton *)playAllButton {
    if (!_playAllButton) {
        _playAllButton = [[QMUIButton alloc] init];
        [_playAllButton setImagePosition:QMUIButtonImagePositionLeft];
        _playAllButton.spacingBetweenImageAndTitle = 15;
        [_playAllButton setTitleColor:[XKColorHelper textMainColor] forState:UIControlStateNormal];
        [_playAllButton setTitle:@"播放全部" forState:UIControlStateNormal];
        [_playAllButton setImage:UIImageMake(@"cm2_list_icn_play") forState:UIControlStateNormal];
        XKWEAK
        [[_playAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            XKSTRONG
            XKBLOCK_EXEC(self.playAllBlock)
        }];
    }
    return _playAllButton;
}

- (QMUIButton *)selectedAllButton {
    if (!_selectedAllButton) {
        _selectedAllButton = [[QMUIButton alloc] init];
        _selectedAllButton.hidden = YES;
        [_selectedAllButton setImagePosition:QMUIButtonImagePositionLeft];
        _selectedAllButton.spacingBetweenImageAndTitle = 15;
        [_selectedAllButton setTitleColor:[XKColorHelper textMainColor] forState:UIControlStateNormal];
        [_selectedAllButton setTitle:@"全选" forState:UIControlStateNormal];
        [_selectedAllButton setImage:UIImageMake(@"cm4_list_checkbox") forState:UIControlStateNormal];
        [_selectedAllButton setImage:UIImageMake(@"cm4_list_checkbox_ok") forState:UIControlStateSelected];
        XKWEAK
        [[_selectedAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            XKSTRONG
            x.selected = !x.selected;
            XKBLOCK_EXEC(self.SelectedBlock,x.selected)
        }];
    }
    return _selectedAllButton;
}

@end
