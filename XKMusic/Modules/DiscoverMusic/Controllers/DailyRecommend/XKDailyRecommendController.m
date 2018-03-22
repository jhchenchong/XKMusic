//
//  XKDailyRecommendController.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDailyRecommendController.h"
#import "XKDailyRecommendModel.h"
#import "XKDailyRecommendCell.h"
#import "XKDailyRecommendHeaderView.h"

@interface XKDailyRecommendController ()

@property (nonatomic, copy) NSArray<XKCellDataAdapter *> *adapters;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSMutableSet<NSNumber *> *selectedItemIndexes;

@end

@implementation XKDailyRecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
}

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.titleView.title = @"每日推荐";
}

- (void)initTableView {
    [super initTableView];
    [XKDailyRecommendCell registerToTableView:self.tableView];
    [XKDailyRecommendHeaderView registerToTableView:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)requestData {
    [[XKDailyRecommendModel signalForDailyRecommendModels] subscribeNext:^(NSArray<XKDailyRecommendModel *> *x) {
        self.adapters = [[x.rac_sequence.signal map:^id _Nullable(XKDailyRecommendModel * _Nullable value) {
            return [XKDailyRecommendCell dataAdapterWithData:value cellHeight:60];
        }] toArray];
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XKDailyRecommendCell *cell = (XKDailyRecommendCell *)[tableView dequeueReusableCellAndLoadDataWithAdapter:self.adapters[indexPath.row] indexPath:indexPath];
    if ([self.selectedItemIndexes containsObject:@(indexPath.row)]) {
        cell.selected = YES;
    } else {
        cell.selected = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.adapters[indexPath.row].cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XKDailyRecommendHeaderView *headerView = (XKDailyRecommendHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"XKDailyRecommendHeaderView"];
    [headerView setHeaderFooterViewBackgroundColor:UIColorWhite];
    XKWEAK
    headerView.playAllBlock = ^{
        NSLog(@"播放全部");
    };
    headerView.SelectedBlock = ^(BOOL isClick) {
        XKSTRONG
        if (isClick) {
            NSArray<NSIndexPath *> *indexPaths = [self.tableView indexPathsForRowsInRect:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.contentSize.height)];
            [self.selectedItemIndexes addObjectsFromArray:[[indexPaths.rac_sequence.signal map:^id _Nullable(NSIndexPath * _Nullable value) {
                return @(value.row);
            }] toArray]];
        } else {
            [self.selectedItemIndexes removeAllObjects];
        }
        [self.tableView reloadData];
    };
    headerView.MultipleButtonBlock = ^(BOOL isClick) {
        XKSTRONG
        self.tableView.editing = isClick;
        if (isClick == NO) {
            [self.selectedItemIndexes removeAllObjects];
        }
    };
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.editing == YES) {
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XKDailyRecommendHeaderView *headerView = (XKDailyRecommendHeaderView *)[tableView headerViewForSection:indexPath.section];
    if ([self.selectedItemIndexes containsObject:@(indexPath.row)]) {
        [self.selectedItemIndexes removeObject:@(indexPath.row)];
         headerView.isSelected = NO;
    } else {
        [self.selectedItemIndexes addObject:@(indexPath.row)];
        if (self.selectedItemIndexes.count == [self.tableView indexPathsForRowsInRect:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.contentSize.height)].count) {
            headerView.isSelected = YES;
        }
    }
    [self.tableView reloadData];
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
        
        NSString *imageName = [NSString stringWithFormat:@"cm2_daily_banner%ld", [XKRandomHelper getRandomNumber:1 to:6]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:UIImageMake(imageName)];
        imageView.frame = _headerView.frame;
        [_headerView addSubview:imageView];
        
        UIImageView *calendarImageView = [[UIImageView alloc] initWithImage:UIImageMake(@"cm2_daily_cal_bg")];
        [_headerView addSubview:calendarImageView];
        
        QMUILabel *label = [[QMUILabel alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd";
        label.text = [dateFormatter stringFromDate:[NSDate date]];
        label.textColor = UIColorWhite;
        label.font = UIFontBoldMake(40);
        [label sizeToFit];
        [calendarImageView addSubview:label];
        label.center = CGPointMake(calendarImageView.center.x, calendarImageView.center.y + 8);
        
        QMUIButton *button = [[QMUIButton alloc] init];
        [button setImagePosition:QMUIButtonImagePositionLeft];
        button.spacingBetweenImageAndTitle = 5;
        [button setTitleColor:UIColorGray forState:UIControlStateNormal];
        button.titleLabel.font = UIFontBoldMake(12);
        [button setImage:UIImageMake(@"cm2_icn_light") forState:UIControlStateNormal];
        [button setTitle:@"根据你的音乐口味生成，每天6:00更新" forState:UIControlStateNormal];
        [_headerView addSubview:button];
        
        FBShimmeringView *shimmmeringView = [[FBShimmeringView alloc] init];
        shimmmeringView.shimmeringPauseDuration = 2;
        shimmmeringView.shimmeringAnimationOpacity = 0.7;
        [_headerView addSubview:shimmmeringView];
        shimmmeringView.contentView = button;
        shimmmeringView.shimmering = YES;
        
        [calendarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_headerView.mas_centerY);
            make.left.mas_equalTo(15);
        }];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-20);
        }];
        [shimmmeringView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-20);
            make.width.mas_equalTo(button);
            make.height.mas_equalTo(button);
        }];
        
    }
    return _headerView;
}

- (NSMutableSet<NSNumber *> *)selectedItemIndexes {
    if (!_selectedItemIndexes) {
        _selectedItemIndexes = [[NSMutableSet alloc] init];
    }
    return _selectedItemIndexes;
}

@end
