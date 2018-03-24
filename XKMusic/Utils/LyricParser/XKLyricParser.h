//
//  XKLyricParser.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/24.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKLyricModel.h"

@interface XKLyricParser : NSObject

+ (NSArray<XKLyricModel *> *)lyricParserWithlyric:(NSString *)lyric;

@end
