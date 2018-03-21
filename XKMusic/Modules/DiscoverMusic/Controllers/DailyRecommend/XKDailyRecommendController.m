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

@interface XKDailyRecommendController ()

@property (nonatomic, copy) NSArray<XKCellDataAdapter *> *adapters;
@property (nonatomic, strong) UIView *headerView;

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
    return (XKDailyRecommendCell *)[tableView dequeueReusableCellAndLoadDataWithAdapter:self.adapters[indexPath.row] indexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.adapters[indexPath.row].cellHeight;
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
        label.text = @"21";
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

@end
