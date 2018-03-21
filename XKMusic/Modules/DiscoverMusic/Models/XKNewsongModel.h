//
//  XKNewsongModel.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/14.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"

@interface XKNewsongModel : NSObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *copywriter;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, assign) BOOL isCanDislike;
@property (nonatomic, strong) Song *song;
@property (nonatomic, copy) NSString *alg;

+ (RACSignal *)signalForNewsongModels;

@end

