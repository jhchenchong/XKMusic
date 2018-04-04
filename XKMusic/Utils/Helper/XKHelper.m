//
//  XKHelper.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/4.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKHelper.h"
#import <notify.h>

@implementation XKHelper

+ (BOOL)isShowLockScreenMediaInfo {
    uint64_t locked;
    __block int token = 0;
    notify_register_dispatch("com.apple.springboard.lockstate",&token,dispatch_get_main_queue(),^(int t){
    });
    notify_get_state(token, &locked);
    
    uint64_t screenLight;
    __block int lightToken = 0;
    notify_register_dispatch("com.apple.springboard.hasBlankedScreen",&lightToken,dispatch_get_main_queue(),^(int t){
    });
    notify_get_state(lightToken, &screenLight);
    
    return screenLight == 0 && locked == 1;
}

@end
