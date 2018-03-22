//
//  XKDailyRecommendCell.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKCustomCell.h"

@interface XKDailyRecommendCell : XKCustomCell

@property (nonatomic, copy) void(^ClickMoreButtonBlock)(XKDailyRecommendCell *dailyRecommendCell);

@end
