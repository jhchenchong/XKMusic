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

typedef NS_ENUM(NSUInteger, XKPlayerChangeStyle) {
    XKPlayerChangeStyleNext, // 下一曲
    XKPlayerChangeStylePrev // 上一曲
};

typedef NS_ENUM(NSUInteger, XKToolbarButtonType) {
    XKToolbarButtonTypeNext,     // 下一首播放
    XKToolbarButtonTypeAdd,      // 收藏到歌单
    XKToolbarButtonTypeDownload, // 下载
    XKToolbarButtonTypeDelete    // 删除
};

typedef NS_ENUM(NSUInteger, XKSonglistHeaderButtonType) {
    XKSonglistHeaderButtonTypeCollection, // 收藏
    XKSonglistHeaderButtonTypeComment,    // 评论
    XKSonglistHeaderButtonTypeShare,      // 分享
    XKSonglistHeaderButtonTypeDownload    // 下载
};

static NSString *const kAnimationButtnStateChanged = @"kAnimationButtnStateChanged";
static NSString *const kColumnOrder = @"ColumnOrder";

static NSString *const kLikeMusicIDKey = @"kLikeMusicIDKey";
static NSString *const kCurrentMusicID = @"kCurrentMusicID";
static NSString *const kXKPlayStyle = @"kXKPlayStyleKey";

#endif
