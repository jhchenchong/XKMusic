//
//  Album.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "Album.h"

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
