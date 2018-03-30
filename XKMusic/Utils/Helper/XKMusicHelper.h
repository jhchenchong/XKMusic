//
//  XKMusicTool.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/28.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XKMusicModel;
@interface XKMusicHelper : NSObject

/**
 保存当前的播放列表到本地

 @param musicModels 当前播放列表的音乐模型数组
 */
+ (void)saveCurrentMusicModels:(NSArray<XKMusicModel *> *)musicModels;

/**
 返回当前保存的音乐模型数组

 @return 音乐模型数组
 */
+ (NSArray<XKMusicModel *> *)musicModels;

/**
 根据音乐ID移除音乐模型

 @param musicID 音乐ID
 */
+ (void)removeMusicModelWithMusicID:(NSString *)musicID;

/**
 移除当前所有的音乐模型
 */
+ (void)removeAllMusicModel;

/**
 返回指定id的音乐在当前列表中的索引

 @param musicID 音乐ID
 @return 索引
 */
+ (NSInteger)indexFromMusicID:(NSString *)musicID;

/**
 保存喜爱音乐的ID

 @param musicID 音乐ID
 */
+ (void)saveLikeMusicID:(NSString *)musicID;

/**
 移除喜欢音乐ID

 @param musicID 音乐ID
 */
+ (void)removeLikeMusicID:(NSString *)musicID;

@end
