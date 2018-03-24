//
//  XKLyricModel.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/24.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKLyricModel.h"
#import "XKLyricApi.h"
#import "XKLyricParser.h"

@implementation XKLyricModel

+ (RACSignal *)signalForLyricModelsWithMusicID:(NSString *)musicID {
    RACReplaySubject *signal = [RACReplaySubject subject];
    [[[XKLyricApi alloc] initWithMusicID:musicID] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendNext:[XKLyricParser lyricParserWithlyric:request.responseObject[@"lrc"][@"lyric"]]];
        [signal sendCompleted];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendError:request.error];
    }];
    return signal;
}

@end
