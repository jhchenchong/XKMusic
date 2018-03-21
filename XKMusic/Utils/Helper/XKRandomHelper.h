//
//  XKRandomHelper.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKRandomHelper : NSObject

/// 获取一个随机整数，范围在[from,to]，包括from，包括to
+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to;

@end
