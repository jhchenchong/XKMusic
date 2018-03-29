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
@property (nonatomic, strong) UIView *timeLineView;
@property (nonatomic, strong) QMUILabel *timeLabel;
@property (nonatomic, strong) QMUIButton *timeLineButton;

@property (nonatomic, assign) NSTimeInterval time;

@end

@implementation XKMusicLyricView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        [self addSubview:self.tipLabel];
        [self addSubview:self.timeLineView];
        [self addSubview:self.timeLabel];
        [self addSubview:self.timeLineButton];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.tableView);
        }];
        [self.timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.right.equalTo(self).offset(-50);
            make.centerY.equalTo(self.tableView);
            make.height.mas_equalTo(0.5);
        }];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.timeLineView.mas_right).offset(25);
            make.centerY.equalTo(self.timeLineView.mas_centerY);
        }];
        [self.timeLineButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.timeLineView.mas_left);
            make.centerY.equalTo(self.timeLineView.mas_centerY);
        }];
    }
    return self;
}

- (void)setLyricModels:(NSArray<XKLyricModel *> *)lyricModels {
    _lyricModels = lyricModels;
    if (lyricModels) {
        if (lyricModels.count == 0) {
            self.tipLabel.hidden = NO;
            self.tipLabel.text = @"纯音乐，无歌词";
        } else {
            self.tipLabel.hidden = YES;
            self.lyricIndex = 0;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        }
    } else {
        self.tipLabel.hidden = NO;
        self.tipLabel.text = @"歌词加载中...";
    }
    [UIView performWithoutAnimation:^{
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lyricModels.count + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XKCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKCustomCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = UIFontMake(16);
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isWillDraging = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.isScrolling = YES;
    self.timeLineView.hidden = NO;
    self.timeLabel.hidden = NO;
    self.timeLineButton.hidden = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        self.isWillDraging = NO;
        [self adjustTheCellPosition];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    self.isScrolling = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.isWillDraging = NO;
    [self adjustTheCellPosition];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isScrolling) return;
    CGFloat offsetY  = scrollView.contentOffset.y;
    NSInteger index = (offsetY + self.tableView.frame.size.height * 0.5) / 44 - 5;
    XKLyricModel *model = nil;
    if (index < 0) {
        model = self.lyricModels.firstObject;
    } else if (index > self.lyricModels.count - 1) {
        model = nil;
    } else {
        model = self.lyricModels[index];
    }
    if(model){
        self.timeLabel.text = [NSString qmui_timeStringWithMinsAndSecsFromSecs:model.secTime];
        self.time = model.secTime;
        self.timeLabel.hidden = NO;
    } else {
        self.timeLabel.text = @"";
        self.timeLabel.hidden = YES;
    }
}

- (void)adjustTheCellPosition {
    CGFloat offsetY  = self.tableView.contentOffset.y;
    NSInteger index = (offsetY + self.tableView.frame.size.height * 0.5) / 44 - 5;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(index + 5) inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    [self performSelector:@selector(endedScroll) withObject:nil afterDelay:2.0];
}

- (void)endedScroll {
    if (self.isWillDraging) return;
    self.timeLineView.hidden = YES;
    self.timeLabel.hidden = YES;
    self.timeLineButton.hidden = YES;
    [self performSelector:@selector(endScrolling) withObject:nil afterDelay:4.0];
}

- (void)endScrolling {
    if (self.isWillDraging) return;
    self.isScrolling = NO;
}

- (void)scrollLyricWithCurrentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime {
    if (self.lyricModels.count == 0) self.lyricIndex = 0;
    for (NSInteger i = 0; i < self.lyricModels.count; i++) {
        XKLyricModel *currentLyric = self.lyricModels[i];
        XKLyricModel *nextLyric = nil;
        if (i < self.lyricModels.count - 1) {
            nextLyric = self.lyricModels[i + 1];
        }
        if ((self.lyricIndex != i && currentTime * 1000 > currentLyric.msTime) && (!nextLyric || currentTime * 1000 < nextLyric.msTime)) {
            self.lyricIndex = i;
            [UIView performWithoutAnimation:^{
                [self.tableView reloadData];
            }];
            if (!self.isScrolling) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.lyricIndex + 5) inSection:0];
                [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            }
        }
    }
}

- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (UIView *)timeLineView {
    if (!_timeLineView) {
        _timeLineView = [[UIView alloc] init];
        _timeLineView.backgroundColor = [UIColor grayColor];
        _timeLineView.hidden = YES;
    }
    return _timeLineView;
}

- (QMUILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[QMUILabel alloc] init];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:13.0];
        _timeLabel.hidden = YES;
    }
    return _timeLabel;
}

- (QMUIButton *)timeLineButton {
    if (!_timeLineButton) {
        _timeLineButton = [[QMUIButton alloc] init];
        [_timeLineButton setImage:UIImageMake(@"cm2_lrc_time_btn_play") forState:UIControlStateNormal];
        [_timeLineButton setImage:UIImageMake(@"cm2_lrc_time_btn_play_prs") forState:UIControlStateHighlighted];
        XKWEAK
        [[_timeLineButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            XKSTRONG
            self.timeLineView.hidden = YES;
            self.timeLabel.hidden = YES;
            self.timeLineButton.hidden = YES;
            XKBLOCK_EXEC(self.PlaySelectedLineBlock, self.time)
        }];
        _timeLineButton.hidden = YES;
    }
    return _timeLineButton;
}

@end
