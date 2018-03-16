//
//  NSString+Count.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "NSString+Count.h"

@implementation NSString (Count)

+ (NSString *)showStringForCount:(NSInteger)count {
    if (count < 100000) {
        return [NSString stringWithFormat:@"%ld", count];
    }else {
        count = count/10000;
        return [NSString stringWithFormat:@"%ld万", count];
    }
}

@end
