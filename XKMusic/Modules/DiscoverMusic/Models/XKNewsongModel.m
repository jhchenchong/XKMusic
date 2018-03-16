//
//  XKNewsongModel.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/14.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKNewsongModel.h"
#import "XKNewsongApi.h"

@implementation Artist

@end

@implementation Privilege

@end

@implementation Music

@end

@implementation Album

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"artist" : Artist.class,
             @"artists" : Artist.class
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"identifier" : @"id"};
}

@end

@implementation Song

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"privilege" : Privilege.class,
             @"hMusic" : Music.class,
             @"mMusic" : Music.class,
             @"lMusic" : Music.class,
             @"bMusic" : Music.class,
             @"album" : Album.class,
             @"artists" : Artist.class
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"identifier" : @"id"};
}

@end

@implementation XKNewsongModel

+ (RACSignal *)signalForNewsongModels {
    RACReplaySubject *signal = [RACReplaySubject subject];
    [[[XKNewsongApi alloc] init] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendNext:[NSArray yy_modelArrayWithClass:self json:request.responseObject[@"result"]]];
        [signal sendCompleted];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendError:request.error];
    }];
    return signal;
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"song" : Song.class};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"identifier" : @"id"};
}

@end
