//
//  XKPersonalizedModel.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPersonalizedModel.h"
#import "XKPersonalizedApi.h"

@implementation XKPersonalizedModel

+ (RACSignal *)signalForPersonalizedModels {
    RACReplaySubject *signal = [RACReplaySubject subject];
    [[[XKPersonalizedApi alloc] init] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendNext:[NSArray yy_modelArrayWithClass:self json:request.responseObject[@"result"]]];
        [signal sendCompleted];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendError:request.error];
    }];
    return signal;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end
