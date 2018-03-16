//
//  XKPersonalizedModel.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKPersonalizedModel : NSObject

@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *copywriter;
@property (nonatomic, assign) NSInteger trackCount;
@property (nonatomic, assign) BOOL highQuality;
@property (nonatomic, assign) BOOL canDislike;
@property (nonatomic, assign) CGFloat playCount;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *alg;
@property (nonatomic, copy) NSString *name;

+ (RACSignal *)signalForPersonalizedModels;

@end
