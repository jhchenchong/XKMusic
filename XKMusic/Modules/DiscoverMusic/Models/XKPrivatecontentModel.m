//
//  XKPrivatecontentModel.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/14.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPrivatecontentModel.h"
#import "XKPrivatecontentApi.h"

@implementation XKPrivatecontentModel

+ (RACSignal *)signalForPrivatecontentModels {
    RACReplaySubject *signal = [RACReplaySubject subject];
    [[[XKPrivatecontentApi alloc] init] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
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
