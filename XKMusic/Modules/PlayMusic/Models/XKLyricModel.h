//
//  XKLyricModel.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/24.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKLyricModel : NSObject

/// 毫秒
@property (nonatomic, assign) NSTimeInterval msTime;
/// 秒
@property (nonatomic, assign) NSTimeInterval secTime;
/// 时间字符串
@property (nonatomic, copy) NSString *timeString;
/// 歌词内容
@property (nonatomic, copy) NSString *content;

+ (RACSignal *)signalForLyricModelsWithMusicID:(NSString *)musicID;

@end
