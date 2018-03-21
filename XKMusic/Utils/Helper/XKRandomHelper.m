//
//  XKRandomHelper.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKRandomHelper.h"

@implementation XKRandomHelper

+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to {
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

@end
