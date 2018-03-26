//
//  XKLyricParser.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/24.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKLyricParser.h"

@implementation XKLyricParser

+ (NSArray<XKLyricModel *> *)lyricParserWithlyric:(NSString *)lyric {
    NSArray *linesArray = [lyric componentsSeparatedByString:@"\n"];
    NSMutableArray<XKLyricModel *> *modelArray = @[].mutableCopy;
    for (NSString *line in linesArray) {
        NSString *pattern = @"\\[[0-9][0-9]:[0-9][0-9].[0-9]{1,}\\]";
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *matchesArray = [regular matchesInString:line options:NSMatchingReportProgress range:NSMakeRange(0, line.length)];
        NSString *content = [line componentsSeparatedByString:@"]"].lastObject;
        for (NSTextCheckingResult *match in matchesArray) {
            NSString *timeStr = [line substringWithRange:match.range];
            timeStr = [timeStr substringFromIndex:1];
            timeStr = [timeStr substringToIndex:(timeStr.length - 1)];
            NSString *minStr = [timeStr substringWithRange:NSMakeRange(0, 2)];
            NSString *secStr = [timeStr substringWithRange:NSMakeRange(3, 2)];
            NSString *mseStr = [timeStr substringFromIndex:6];
            NSTimeInterval time = [minStr floatValue] * 60 * 1000 + [secStr floatValue] * 1000 + [mseStr floatValue];
            XKLyricModel *lyricModel = [[XKLyricModel alloc]init];
            lyricModel.content = content;
            lyricModel.msTime = time;
            lyricModel.secTime = time / 1000;
            lyricModel.timeString = [NSString qmui_timeStringWithMinsAndSecsFromSecs:time / 1000];
            [modelArray addObject:lyricModel];
        }
    }
    [modelArray enumerateObjectsUsingBlock:^(XKLyricModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.content || [obj.content isEqualToString:@""]) {
            [modelArray removeObject:obj];
        }
    }];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"msTime" ascending:YES];
    return [modelArray sortedArrayUsingDescriptors:@[descriptor]];
}

@end
