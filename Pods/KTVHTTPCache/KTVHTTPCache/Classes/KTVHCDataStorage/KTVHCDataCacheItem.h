//
//  KTVHCDataCacheItem.h
//  KTVHTTPCache
//
//  Created by Single on 2017/8/13.
//  Copyright © 2017年 Single. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KTVHCDataCacheItemZone;


@interface KTVHCDataCacheItem : NSObject


+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) NSString * URLString;
@property (nonatomic, assign, readonly) long long totalLength;
@property (nonatomic, assign, readonly) long long cacheLength;
@property (nonatomic, copy, readonly) NSArray <KTVHCDataCacheItemZone *> * zones;


@end
