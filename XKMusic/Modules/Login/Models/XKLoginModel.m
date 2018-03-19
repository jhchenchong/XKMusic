//
//  XKLoginModel.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKLoginModel.h"
#import "XKLoginApi.h"

@implementation Account

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end

@implementation Bindings

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end

@implementation Experts

@end

@implementation Profile

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"experts" : Experts.class};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc" : @"description"};
}

@end

@implementation XKLoginModel

+ (RACSignal *)signalForLoginWithPhone:(NSString *)phone password:(NSString *)password {
    RACReplaySubject *signal = [RACReplaySubject subject];
    [[[XKLoginApi alloc] initWithPhone:phone password:password] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendNext:[self yy_modelWithDictionary:request.responseObject]];
        [signal sendCompleted];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendError:request.error];
    }];
    return signal;
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"account" : Account.class,
             @"bindings" : Bindings.class,
             @"profile" : Profile.class
             };
}

@end
