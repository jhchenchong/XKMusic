//
//  XKDisMusicHeaderView.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface XKDisMusicHeaderView : UIView

/// 轮播图
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
/// 私人FM
@property (nonatomic, strong) QMUIButton *fmButton;
/// 每日推荐
@property (nonatomic, strong) QMUIButton *recommendButton;
/// 歌单
@property (nonatomic, strong) QMUIButton *songListButton;
/// 排行榜
@property (nonatomic, strong) QMUIButton *leaderboardsButton;

@end
