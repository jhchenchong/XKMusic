//
//  Song.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "Song.h"

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
