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
        
        [self addSubview:self.topView];
        [self addSubview:self.topLine];
        [self addSubview:self.tableView];
        [self addSubview:self.closeBtn];
        [self addSubview:self.closeLine];
        
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
    XKCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKCustomCell"];
    cell.backgroundColor = UIColorClear;
    cell.textLabel.text = self.musicModels[indexPath.row].music_name;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [XKCustomCell registerToTableView:_tableView];
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

@end
