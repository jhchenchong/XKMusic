//
//  XKMusicListView.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/28.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKMusicListView.h"

@interface XKMusicListView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) QMUIButton *styleButton;
@property (nonatomic, strong) QMUIButton *collectionAllButton;
@property (nonatomic, strong) QMUIButton *deleteButton;
@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, strong) QMUIButton *closeBtn;
@property (nonatomic, strong) UIView *closeLine;

@property (nonatomic, strong) QMUITableView *tableView;

@end

@implementation XKMusicListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEfView.alpha = 1;
        [self insertSubview:visualEfView atIndex:0];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColorSeparator;
        
        [self.topView addSubview:lineView];
        [self.topView addSubview:self.styleButton];
        [self.topView addSubview:self.collectionAllButton];
        [self.topView addSubview:self.deleteButton];
        [self addSubview:self.topView];
        [self addSubview:self.topLine];
        [self addSubview:self.tableView];
        [self addSubview:self.closeBtn];
        [self addSubview:self.closeLine];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.topView);
            make.width.mas_equalTo(PixelOne);
            make.right.mas_equalTo(self.deleteButton.mas_left).offset(-15);
            make.height.mas_equalTo(20);
        }];
        [self.styleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.topView);
        }];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.topView);
        }];
        [self.collectionAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.deleteButton.mas_left).offset(-30);
            make.centerY.mas_equalTo(self.topView);
        }];
        [visualEfView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(50);
        }];
        [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(PixelOne);
            make.top.mas_equalTo(self.topView.mas_bottom);
        }];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.topView.mas_bottom);
            make.bottom.equalTo(self.closeBtn.mas_top);
        }];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(55);
        }];
        [self.closeLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.closeBtn);
            make.height.mas_equalTo(PixelOne);
        }];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.musicModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XKMusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKMusicListCell"];
    cell.backgroundColor = UIColorClear;
    cell.model = self.musicModels[indexPath.row];
    XKWEAK
    cell.linkButtonBlock = ^{
        XKSTRONG
        XKBLOCK_EXEC(self.linkButtonBlock)
    };
    cell.deleteButtonBlock = ^(XKMusicModel *model) {
        XKSTRONG
        XKBLOCK_EXEC(self.listDeleteButtonBlock, model)
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    XKBLOCK_EXEC(self.didSelectRowAtIndexPathBlock,indexPath)
}

- (void)setPlayStyle:(XKPlayerPlayStyle)playStyle {
    switch (playStyle) {
        case XKPlayerPlayStyleLoop:
        {
            [self.styleButton setImage:[UIImage imageNamed:@"cm2_playlist_icn_loop"] forState:UIControlStateNormal];
            [self.styleButton setImage:[UIImage imageNamed:@"cm2_playlist_icn_loop_prs"] forState:UIControlStateHighlighted];
            [self.styleButton setTitle:[NSString stringWithFormat:@"列表循环(%ld)",self.musicModels.count] forState:UIControlStateNormal];
        }
            break;
        case XKPlayerPlayStyleSingleCycle:
        {
            [self.styleButton setImage:[UIImage imageNamed:@"cm2_playlist_icn_one"] forState:UIControlStateNormal];
            [self.styleButton setImage:[UIImage imageNamed:@"cm2_playlist_icn_one_prs"] forState:UIControlStateHighlighted];
            [self.styleButton setTitle:@"单曲循环" forState:UIControlStateNormal];
        }
            break;
        case XKPlayerPlayStyleRandom:
        {
            [self.styleButton setImage:[UIImage imageNamed:@"cm2_playlist_icn_shuffle"] forState:UIControlStateNormal];
            [self.styleButton setImage:[UIImage imageNamed:@"cm2_playlist_icn_shuffle_prs"] forState:UIControlStateHighlighted];
            [self.styleButton setTitle:[NSString stringWithFormat:@"随机播放(%ld)",self.musicModels.count] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (void)setMusicModels:(NSArray<XKMusicModel *> *)musicModels {
    if (musicModels.count == 0) {
        return;
    }
    _musicModels = musicModels;
    [self.tableView reloadData];
    if (self.shouldScroll) {
        __block NSInteger playIndex = 0;
        [musicModels enumerateObjectsUsingBlock:^(XKMusicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isPlaying) {
                playIndex = idx;
                *stop = YES;
            }
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:playIndex inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        });
    }
}

- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [XKMusicListCell registerToTableView:_tableView];
    }
    return _tableView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
    }
    return _topView;
}

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = UIColorSeparator;
    }
    return _topLine;
}

- (QMUIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[QMUIButton alloc] init];
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[XKColorHelper textMainColor] forState:UIControlStateNormal];
        [_closeBtn setBackgroundColor:UIColorClear];
        XKWEAK
        [[_closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            XKSTRONG
            XKBLOCK_EXEC(self.closeButtonBlock)
        }];
    }
    return _closeBtn;
}

- (UIView *)closeLine {
    if (!_closeLine) {
        _closeLine = [[UIView alloc] init];
        _closeLine.backgroundColor = UIColorSeparator;
    }
    return _closeLine;
}

- (QMUIButton *)styleButton {
    if (!_styleButton) {
        _styleButton = [[QMUIButton alloc] init];
        [_styleButton setImagePosition:QMUIButtonImagePositionLeft];
        [_styleButton setImage:UIImageMake(@"cm2_playlist_icn_loop") forState:UIControlStateNormal];
        [_styleButton setImage:UIImageMake(@"cm2_playlist_icn_loop_prs") forState:UIControlStateHighlighted];
        [_styleButton setTitle:@"列表循环" forState:UIControlStateNormal];
        [_styleButton setTitleColor:[XKColorHelper textMainColor] forState:UIControlStateNormal];
        _styleButton.spacingBetweenImageAndTitle = 5;
        _styleButton.titleLabel.font = UIFontMake(15);
        XKWEAK
        [[_styleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            XKSTRONG
            XKBLOCK_EXEC(self.styleButtonBlock)
        }];
    }
    return _styleButton;
}

- (QMUIButton *)collectionAllButton {
    if (!_collectionAllButton) {
        _collectionAllButton = [[QMUIButton alloc] init];
        [_collectionAllButton setImagePosition:QMUIButtonImagePositionLeft];
        [_collectionAllButton setImage:UIImageMake(@"cm2_playlist_icn_fav_dis") forState:UIControlStateNormal];
        [_collectionAllButton setImage:UIImageMake(@"cm2_playlist_icn_fav_dis_prs") forState:UIControlStateHighlighted];
        [_collectionAllButton setTitle:@"收藏全部" forState:UIControlStateNormal];
        [_collectionAllButton setTitleColor:[XKColorHelper textMainColor] forState:UIControlStateNormal];
        _collectionAllButton.spacingBetweenImageAndTitle = 5;
        _collectionAllButton.titleLabel.font = UIFontMake(15);
        XKWEAK
        [[_collectionAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            XKSTRONG
            XKBLOCK_EXEC(self.allButtonBlock)
        }];
    }
    return _collectionAllButton;
}

- (QMUIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[QMUIButton alloc] init];
        [_deleteButton setImage:UIImageMake(@"cm2_playlist_icn_delete") forState:UIControlStateNormal];
        [_deleteButton setImage:UIImageMake(@"cm2_playlist_icn_delete_prs") forState:UIControlStateHighlighted];
        XKWEAK
        [[_deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            XKSTRONG
            XKBLOCK_EXEC(self.deleteButtonBlock)
        }];
    }
    return _deleteButton;
}

@end


@interface XKMusicListCell ()

@property (nonatomic, strong) UIImageView *vImageView;
@property (nonatomic, strong) QMUILabel *label;
@property (nonatomic, strong) QMUIButton *linkButton;
@property (nonatomic, strong) QMUIButton *deleteButton;

@end

@implementation XKMusicListCell

- (void)buildSubview {
    [self.contentView addSubview:self.vImageView];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.linkButton];
    [self.contentView addSubview:self.deleteButton];
    
    [self.vImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(16);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.linkButton.mas_left).offset(-10);
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.linkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.deleteButton.mas_left).offset(-20);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

- (void)setModel:(XKMusicModel *)model {
    _model = model;
    self.label.text = [NSString stringWithFormat:@"%@ - %@", model.music_name, model.music_artist];
    if (model.isPlaying && XKPlayerVC.isPlaying) {
        self.vImageView.hidden = NO;
        self.linkButton.hidden = NO;
        [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.vImageView.mas_right).offset(10);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.linkButton.mas_left).offset(-10);
        }];
        self.label.attributedText = [self handleStringWithString:self.label.text attributes:@{NSForegroundColorAttributeName:[XKColorHelper appMainColor], NSFontAttributeName:UIFontMake(15)} rang:NSMakeRange(0, self.label.text.length)];
    } else {
        self.vImageView.hidden = YES;
        self.linkButton.hidden = YES;
        [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.linkButton.mas_left).offset(-10);
        }];
        self.label.font = UIFontMake(12);
        self.label.textColor = UIColorGray;
        self.label.attributedText = [self handleStringWithString:self.label.text attributes:@{NSForegroundColorAttributeName:[XKColorHelper textMainColor], NSFontAttributeName:UIFontMake(15)} rang:[self.label.text rangeOfString:model.music_name]];
    }
}

- (UIImageView *)vImageView {
    if (!_vImageView) {
        _vImageView = [[UIImageView alloc] initWithImage:UIImageMake(@"cm2_icn_volume")];
        _vImageView.hidden = YES;
    }
    return _vImageView;
}

- (QMUILabel *)label {
    if (!_label) {
        _label = [[QMUILabel alloc] init];
        _label.font = UIFontMake(15);
        _label.textColor = [XKColorHelper textMainColor];
    }
    return _label;
}

- (QMUIButton *)linkButton {
    if (!_linkButton) {
        _linkButton = [[QMUIButton alloc] init];
        [_linkButton setImage:UIImageMake(@"cm2_playlist_icn_link") forState:UIControlStateNormal];
        _linkButton.hidden = YES;
        XKWEAK
        [[_linkButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            XKSTRONG
            XKBLOCK_EXEC(self.linkButtonBlock)
        }];
    }
    return _linkButton;
}

- (QMUIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[QMUIButton alloc] init];
        [_deleteButton setImage:UIImageMake(@"cm2_playlist_icn_dlt") forState:UIControlStateNormal];
        [_deleteButton setImage:UIImageMake(@"cm2_playlist_icn_dlt_prs") forState:UIControlStateHighlighted];
        XKWEAK
        [[_deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            XKSTRONG
            XKBLOCK_EXEC(self.deleteButtonBlock,self.model)
        }];
    }
    return _deleteButton;
}

@end

