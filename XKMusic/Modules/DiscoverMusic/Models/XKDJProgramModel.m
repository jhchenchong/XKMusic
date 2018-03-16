//
//  XKDJProgramModel.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/15.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDJProgramModel.h"
#import "XKDJProgramApi.h"

@implementation Dj

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc" : @"description"};
}

@end

@implementation H5Links

@end

@implementation DJAlias

@end

@implementation LMusic

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end

@implementation BMusic

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end

@implementation RtUrls

@end

@implementation DJSongs

@end

@implementation DJArtist

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"alias" : DJAlias.class};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end

@implementation DJArtists

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"alias" : DJAlias.class};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end

@implementation DJAlbum

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"songs" : DJSongs.class,
             @"alias" : DJAlias.class,
             @"artist" : DJArtist.class,
             @"artists" : DJArtists.class
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id", @"desc" : @"description"};
}

@end

@implementation MainSong

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"alias" : DJAlias.class,
             @"lMusic" : LMusic.class,
             @"bMusic" : BMusic.class,
             @"rtUrls" : RtUrls.class,
             @"album" : DJAlbum.class,
             @"artists" : DJArtists.class
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id", @"desc" : @"description", @"from" : @"copyFrom"};
}

@end

@implementation Radio

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id", @"desc" : @"description"};
}

@end

@implementation Channels

@end

@implementation Program

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"dj" : Dj.class,
             @"h5Links" : H5Links.class,
             @"MainSong" : MainSong.class,
             @"radio" : Radio.class,
             @"channels" : Channels.class
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id", @"desc" : @"description"};
}

@end

@implementation XKDJProgramModel

+ (RACSignal *)signalForDJProgramModels {
    RACReplaySubject *signal = [RACReplaySubject subject];
    [[[XKDJProgramApi alloc] init] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendNext:[NSArray yy_modelArrayWithClass:self json:request.responseObject[@"result"]]];
        [signal sendCompleted];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [signal sendError:request.error];
    }];
    return signal;
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"program" : Program.class};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end
