//
//  XKSongListHeaderCell.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/6.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKSongListHeaderCell.h"

@interface XKSongListHeaderCell ()

@property (nonatomic, strong) LKImageView *coverImageView;
@property (nonatomic, strong) QMUIButton *playCountButton;
@property (nonatomic, strong) UIImageView *infoIconImageView;
@property (nonatomic, strong) QMUILabel *songListNameLabel;
@property (nonatomic, strong) QMUIButton *creatorButton;
@property (nonatomic, strong) LKImageView *userIconImageView;
@property (nonatomic, strong) QMUIButton *collectionButton;
@property (nonatomic, strong) QMUIButton *commentButton;
@property (nonatomic, strong) QMUIButton *shareButton;
@property (nonatomic, strong) QMUIButton *downloadButton;

@end

@implementation XKSongListHeaderCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}

- (void)buildSubview {
    [self.coverImageView addSubview:self.playCountButton];
    [self.coverImageView addSubview:self.infoIconImageView];
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.songListNameLabel];
    [self.contentView addSubview:self.userIconImageView];
    [self.contentView addSubview:self.creatorButton];
    [self.contentView addSubview:self.collectionButton];
    [self.contentView addSubview:self.commentButton];
    [self.contentView addSubview:self.shareButton];
    [self.contentView addSubview:self.downloadButton];
    
    /// 布局
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.width.height.mas_equalTo(KAUTOSCALE(150));
    }];
    [self.playCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-8);
        make.top.mas_equalTo(4);
    }];
    [self.infoIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-4);
        make.right.mas_equalTo(-8);
    }];
    [self.songListNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KAUTOSCALE(30));
        make.left.mas_equalTo(self.coverImageView.mas_right).offset(15);
        make.right.mas_equalTo(-15);
    }];
    [self.userIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.songListNameLabel);
        make.top.mas_equalTo(self.songListNameLabel.mas_bottom).offset(KAUTOSCALE(20));
        make.width.height.mas_equalTo(KAUTOSCALE(30));
    }];
    [self.creatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userIconImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(self.userIconImageView);
    }];
    [@[self.collectionButton, self.commentButton, self.shareButton, self.downloadButton] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KAUTOSCALE(60) leadSpacing:20 tailSpacing:20];
    [@[self.collectionButton, self.commentButton, self.shareButton, self.downloadButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAUTOSCALE(64));
        make.bottom.mas_equalTo(KAUTOSCALE(-12));
    }];
}

- (QMUIButton *)configButtonWithImageName:(NSString *)imageName title:(NSString *)title buttonType:(XKSonglistHeaderButtonType)buttonType {
    QMUIButton *button = [[QMUIButton alloc] init];
    NSString *prsImageName = [NSString stringWithFormat:@"%@_prs", imageName];
    [button setImagePosition:QMUIButtonImagePositionTop];
    [button setImage:UIImageMake(imageName) forState:UIControlStateNormal];
    [button setImage:UIImageMake(prsImageName) forState:UIControlStateHighlighted];
    button.titleLabel.font = UIFontMake(12);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    XKWEAK
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        XKSTRONG
        XKBLOCK_EXEC(self.DidClickHeaderCellButtonBlock, buttonType)
    }];
    return button;
}

- (void)setModel:(XKSongListInfoModel *)model {
    _model = model;
    self.coverImageView.URL = model.cover;
    [self.playCountButton setTitle:[NSString showStringForCount:model.playcount] forState:UIControlStateNormal];
    self.songListNameLabel.text = model.name;
    self.userIconImageView.URL = model.creatorIcon;
    [self.creatorButton setTitle:model.creatorname forState:UIControlStateNormal];
    [self.collectionButton setTitle:[NSString showStringForCount:model.subscribedCount] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString showStringForCount:model.commentCount] forState:UIControlStateNormal];
    [self.shareButton setTitle:[NSString showStringForCount:model.shareCount] forState:UIControlStateNormal];
    
}

- (LKImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[LKImageView alloc] init];
    }
    return _coverImageView;
}

- (QMUIButton *)playCountButton {
    if (!_playCountButton) {
        _playCountButton = [[QMUIButton alloc] init];
        _playCountButton.userInteractionEnabled = NO;
        _playCountButton.imagePosition = QMUIButtonImagePositionLeft;
        [_playCountButton setTitle:@"0" forState:UIControlStateNormal];
        _playCountButton.titleLabel.font = UIFontMake(12);
        [_playCountButton setTitleColor:UIColorWhite forState:UIControlStateNormal];
        
    }
    return _playCountButton;
}

- (UIImageView *)infoIconImageView {
    if (!_infoIconImageView) {
        _infoIconImageView = [[UIImageView alloc] initWithImage:UIImageMake(@"cm2_list_detail_icn_infor")];
    }
    return _infoIconImageView;
}

- (QMUILabel *)songListNameLabel {
    if (!_songListNameLabel) {
        _songListNameLabel = [[QMUILabel alloc] init];
        _songListNameLabel.textColor = UIColorWhite;
        _songListNameLabel.font = UIFontBoldMake(17);
        _songListNameLabel.numberOfLines = 2;
    }
    return _songListNameLabel;
}

- (LKImageView *)userIconImageView {
    if (!_userIconImageView) {
        _userIconImageView = [[LKImageView alloc] init];
        _userIconImageView.image = [UIImage qmui_imageWithColor:UIColorGray];
        _userIconImageView.layer.cornerRadius = KAUTOSCALE(15);
    }
    return _userIconImageView;
}

- (QMUIButton *)creatorButton {
    if (!_creatorButton) {
        _creatorButton = [[QMUIButton alloc] init];
        _creatorButton.imagePosition = QMUIButtonImagePositionRight;
        _creatorButton.spacingBetweenImageAndTitle = 10;
        [_creatorButton setTitleColor:UIColorWhite forState:UIControlStateNormal];
        [_creatorButton setImage:UIImageMake(@"cm2_list_detail_icn_arr") forState:UIControlStateNormal];
        _creatorButton.titleLabel.font = UIFontMake(14);
        
    }
    return _creatorButton;
}

- (QMUIButton *)collectionButton {
    if (!_collectionButton) {
        _collectionButton = [self configButtonWithImageName:@"cm2_list_detail_icn_fav_new" title:@"0" buttonType:XKSonglistHeaderButtonTypeCollection];
    }
    return _collectionButton;
}

- (QMUIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [self configButtonWithImageName:@"cm2_list_detail_icn_cmt" title:@"0" buttonType:XKSonglistHeaderButtonTypeComment];
    }
    return _commentButton;
}

- (QMUIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [self configButtonWithImageName:@"cm2_list_detail_icn_share" title:@"0" buttonType:XKSonglistHeaderButtonTypeShare];
    }
    return _shareButton;
}

- (QMUIButton *)downloadButton {
    if (!_downloadButton) {
        _downloadButton = [self configButtonWithImageName:@"cm2_list_detail_icn_dld" title:@"下载" buttonType:XKSonglistHeaderButtonTypeDownload];
    }
    return _downloadButton;
}

@end
