//
//  Privilege.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Privilege : NSObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger fee;
@property (nonatomic, assign) NSInteger payed;
@property (nonatomic, assign) NSInteger st;
@property (nonatomic, assign) NSInteger pl;
@property (nonatomic, assign) NSInteger dl;
@property (nonatomic, assign) NSInteger sp;
@property (nonatomic, assign) NSInteger cp;
@property (nonatomic, assign) NSInteger subp;
@property (nonatomic, assign) BOOL cs;
@property (nonatomic, assign) NSInteger maxbr;
@property (nonatomic, assign) NSInteger fl;
@property (nonatomic, assign) BOOL isToast;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, assign) BOOL isPreSell;

@end
