//
//  XKMusicLyricView.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/24.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKMusicLyricView.h"

@interface XKMusicLyricView ()<QMUITableViewDataSource, QMUITableViewDelegate>

@property (nonatomic, strong) QMUITableView *tableView;
@property (nonatomic, strong) QMUILabel *tipLabel;

@end

@implementation XKMusicLyricView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        [self addSubview:self.tipLabel];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.tableView);
        }];
    }
    return self;
}

- (void)setLyricModels:(NSArray<XKLyricModel *> *)lyricModels {
    _lyricModels = lyricModels;
    if (lyricModels) {
        if (lyricModels.count == 0) {
            self.tipLabel.hidden = NO;
            self.tipLabel.text   = @"纯音乐，无歌词";
            [self.tableView reloadData];
        } else {
            self.tipLabel.hidden = YES;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            [self.tableView reloadData];
        }
    } else {
        self.tipLabel.hidden = NO;
        self.tipLabel.text = @"歌词加载中...";
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lyricModels.count + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XKCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKCustomCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (indexPath.row < 5 || indexPath.row > self.lyricModels.count + 4) {
        cell.textLabel.textColor = [UIColor clearColor];
        cell.textLabel.text = @"";
    } else {
        cell.textLabel.text = [self.lyricModels[indexPath.row - 5] content];
        if (indexPath.row == self.lyricIndex + 5) {
            cell.textLabel.textColor = [UIColor whiteColor];
        } else {
            cell.textLabel.textColor = [UIColor grayColor];
        }
    }
    return cell;
}

- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 30;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [XKCustomCell registerToTableView:_tableView];
    }
    return _tableView;
}

- (QMUILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[QMUILabel alloc] init];
        _tipLabel.textColor = UIColorWhite;
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
}

@end
