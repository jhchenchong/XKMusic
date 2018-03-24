//
//  XKPlayerController+KTVHTTPCache.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/24.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPlayerController+KTVHTTPCache.h"

@implementation XKPlayerController (KTVHTTPCache)

- (void)setupHTTPCache {
    [KTVHTTPCache logSetConsoleLogEnable:NO];
    [self startHTTPServer];
    [self configurationFilters];
}

- (void)startHTTPServer {
    NSError * error;
    [KTVHTTPCache proxyStart:&error];
    if (error) {
        NSLog(@"Proxy Start Failure, %@", error);
    } else {
        NSLog(@"Proxy Start Success");
    }
}

- (void)configurationFilters {
#if 0
    [KTVHTTPCache cacheSetURLFilterForArchive:^NSString *(NSString * originalURLString) {
        NSLog(@"URL Filter reviced URL, %@", originalURLString);
        return originalURLString;
    }];
#endif
    
#if 0
    [KTVHTTPCache cacheSetContentTypeFilterForResponseVerify:^BOOL(NSString * URLString,
                                                                   NSString * contentType,
                                                                   NSArray<NSString *> * defaultAcceptContentTypes) {
        NSLog(@"Content-Type Filter reviced Content-Type, %@", contentType);
        if ([defaultAcceptContentTypes containsObject:contentType]) {
            return YES;
        }
        return NO;
    }];
#endif
}

@end
