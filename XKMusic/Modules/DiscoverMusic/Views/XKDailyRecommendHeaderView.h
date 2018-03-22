//
//  XKDailyRecommendHeaderView.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/22.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKCustomHeaderFooterView.h"

@interface XKDailyRecommendHeaderView : XKCustomHeaderFooterView

@property (nonatomic, copy) void (^SelectedBlock)(BOOL isClick);
@property (nonatomic, copy) void (^MultipleButtonBlock)(BOOL isClick);
@property (nonatomic, copy) dispatch_block_t playAllBlock;
@property (nonatomic, assign) BOOL isSelected;

- (void)resetHeaderView;

@end
