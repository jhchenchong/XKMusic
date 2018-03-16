//
//  XKDisMusicHeaderView.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDisMusicHeaderView.h"


@interface XKDisMusicHeaderView()



@end

@implementation XKDisMusicHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectZero];
    self.cycleScrollView.backgroundColor = UIColorGray;
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.cycleScrollView.currentPageDotColor = [XKColorHelper appMainColor];
    self.cycleScrollView.pageDotColor = UIColorWhite;
    self.cycleScrollView.autoScrollTimeInterval = 5;
    [self addSubview:self.cycleScrollView];
    
    self.fmButton = [self creatButtonWitnImageName:@"cm4_disc_topbtn_fm" title:@"私人FM"];
    [self addSubview:self.fmButton];
    
    self.recommendButton = [self creatButtonWitnImageName:@"cm4_disc_topbtn_daily" title:@"每日推荐"];
    [self addSubview:self.recommendButton];
    
    self.songListButton = [self creatButtonWitnImageName:@"cm4_disc_topbtn_list" title:@"歌单"];
    [self addSubview:self.songListButton];
    
    self.leaderboardsButton = [self creatButtonWitnImageName:@"cm4_disc_topbtn_rank" title:@"排行榜"];
    [self addSubview:self.leaderboardsButton];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorSeparator;
    [self addSubview:lineView];
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(145);
    }];
    [@[self.fmButton, self.recommendButton, self.songListButton, self.leaderboardsButton] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:60 leadSpacing:20 tailSpacing:20];
    [@[self.fmButton, self.recommendButton, self.songListButton, self.leaderboardsButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom).offset(15);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(PixelOne);
    }];
}

- (QMUIButton *)creatButtonWitnImageName:(NSString *)imageName title:(NSString *)title {
    QMUIButton *button = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [button setImagePosition:QMUIButtonImagePositionTop];
    [button setImage:UIImageMake(@"cm4_disc_topbtn") forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[XKColorHelper textMainColor] forState:UIControlStateNormal];
    button.titleLabel.font = UIFontMake(11);
    button.spacingBetweenImageAndTitle = 10;
    button.adjustsButtonWhenHighlighted = NO;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:UIImageMake(imageName)];
    [button addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(button.mas_centerX);
        make.top.mas_equalTo(0);
    }];
    
    return button;
}

@end
