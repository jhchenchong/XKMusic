//
//  XKBannerModel.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKBannerModel : NSObject

@property (nonatomic, copy) NSString *monitorType;
@property (nonatomic, copy) NSString *extMonitorInfo;
@property (nonatomic, assign) BOOL exclusive;
@property (nonatomic, copy) NSString *monitorBlackList;
@property (nonatomic, copy) NSString *adLocation;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *typeTitle;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *adSource;
@property (nonatomic, copy) NSString *titleColor;
@property (nonatomic, copy) NSString *encodeId;
@property (nonatomic, copy) NSString *monitorImpress;
@property (nonatomic, copy) NSString *extMonitor;
@property (nonatomic, copy) NSString *monitorClick;
@property (nonatomic, assign) NSInteger targetType;
@property (nonatomic, copy) NSString *adid;
@property (nonatomic, assign) NSInteger targetId;

+ (RACSignal *)signalForBanner;

@end
