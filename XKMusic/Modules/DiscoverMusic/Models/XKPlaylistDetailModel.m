//
//  XKPlaylistDetailModel.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPlaylistDetailModel.h"
#import "XKPlaylistDetailApi.h"

@implementation Creator

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end

@implementation Tracks

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"lMusic" : Music.class,
             @"bMusic" : Music.class,
             @"hMusic" : Music.class,
             @"mMusic" : Music.class,
             @"album" : Album.class,
             @"artists" : Artist.class
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id", @"from" : @"copyFrom"};
}

@end

@implementation XKPlaylistDetailModel

+ (RACSignal *)signalForPlaylistDetailModelWithID:(NSString *)ID {
    RACReplaySubject *signal = [RACReplaySubject subject];
    [[[XKPlaylistDetailApi alloc] initWithID:ID] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendNext:[self yy_modelWithDictionary:request.responseObject[@"result"]]];
        [signal sendCompleted];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendError:request.error];
    }];
    return signal;
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"tracks" : Tracks.class,
             @"creator" : Creator.class,
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id", @"desc" : @"description", @"from" : @"copyFrom"};
}

@end
