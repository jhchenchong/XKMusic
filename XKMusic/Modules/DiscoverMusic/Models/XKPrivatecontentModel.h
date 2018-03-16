//
//  XKPrivatecontentModel.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/14.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKPrivatecontentModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *copywriter;
@property (nonatomic, assign) NSInteger eventUserId;
@property (nonatomic, assign) NSInteger eventType;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *sPicUrl;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, copy) NSString *alg;
@property (nonatomic, copy) NSString *name;

+ (RACSignal *)signalForPrivatecontentModels;

@end
