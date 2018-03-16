//
//  XKBannerModel.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKBannerModel.h"
#import "XKBannerApi.h"

@implementation XKBannerModel

+ (RACSignal *)signalForBanner {
    RACReplaySubject *signal = [RACReplaySubject subject];
    [[[XKBannerApi alloc] init] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendNext:[NSArray yy_modelArrayWithClass:self json:request.responseObject[@"banners"]]];
        [signal sendCompleted];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendError:request.error];
    }];
    return signal;
}

@end
