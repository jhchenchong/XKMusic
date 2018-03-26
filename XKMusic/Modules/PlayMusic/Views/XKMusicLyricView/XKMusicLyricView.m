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
            self.tipLabel.text = @"纯音乐，无歌词";
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isWillDraging = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.isScrolling = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        self.isWillDraging = NO;
        [self performSelector:@selector(endedScroll) withObject:nil afterDelay:1.0];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    self.isScrolling = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.isWillDraging = NO;
    [self performSelector:@selector(endedScroll) withObject:nil afterDelay:1.0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isScrolling) return;
    CGFloat offsetY  = scrollView.contentOffset.y;
    NSInteger index = (offsetY + self.tableView.frame.size.height * 0.5) / 44 - 5 + 1;
    XKLyricModel *model = nil;
    if (index < 0) {
        model = self.lyricModels.firstObject;
    } else if (index > self.lyricModels.count - 1) {
        model = nil;
    } else {
        model = self.lyricModels[index];
    }
    
    if(model){
        
    } else {

    }
}

- (void)endedScroll {
    if (self.isWillDraging) return;
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
            [self.tableView reloadData];
            if (!self.isScrolling) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.lyricIndex + 5) inSection:0];
                [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
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
