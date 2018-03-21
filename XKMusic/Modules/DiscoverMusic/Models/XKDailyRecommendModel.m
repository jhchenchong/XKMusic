//
//  XKDailyRecommendModel.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDailyRecommendModel.h"
#import "XKDailyRecommendApi.h"

@implementation XKDailyRecommendModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id", @"from" : @"copyFrom"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"mMusic" : Music.class,
             @"artists" : Artist.class,
             @"album" : Album.class,
             @"hMusic" : Music.class,
             @"privilege" : Privilege.class,
             @"bMusic" : Music.class,
             @"lMusic" : Music.class
             };
}

+ (RACSignal *)signalForDailyRecommendModels {
    RACReplaySubject *signal = [RACReplaySubject subject];
    [[[XKDailyRecommendApi alloc] init] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendNext:[NSArray yy_modelArrayWithClass:self json:request.responseObject[@"recommend"]]];
        [signal sendCompleted];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendError:request.error];
    }];
    return signal;
}

@end

