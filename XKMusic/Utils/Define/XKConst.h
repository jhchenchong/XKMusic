//
//  XKConst.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#ifndef XKConst_h
#define XKConst_h

#pragma mark -- 通知

typedef NS_ENUM(NSUInteger, XKPlayerPlayStyle) {
    XKPlayerPlayStyleLoop,        // 循环播放
    XKPlayerPlayStyleSingleCycle, // 单曲循环
    XKPlayerPlayStyleRandom       // 随机播放
};

typedef NS_ENUM(NSUInteger, XKToolbarButtonType) {
    XKToolbarButtonTypeNext,      // 下一首播放
    XKToolbarButtonTypeAdd,       // 收藏到歌单
    XKToolbarButtonTypeDownload,  // 下载
    XKToolbarButtonTypeDelete     // 删除
};

static NSString *const kAnimationButtnStateChanged = @"kAnimationButtnStateChanged";
static NSString *const kColumnOrder = @"ColumnOrder";

#endif
