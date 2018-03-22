//
//  AppDelegate.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/3.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "AppDelegate.h"
#import "XKRootViewController.h"
#import "XKLoginModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[XKRootViewController alloc] init];
    [self.window makeKeyAndVisible];
    [self configAnimationButton];
    [YTKNetworkConfig sharedConfig].baseUrl = @"http://192.168.3.5:3000";
//    [[XKLoginModel signalForLoginWithPhone:@"18780269064" password:@"chenchong921209"] subscribeNext:^(XKLoginModel *x) {
//        if (x.code == 200) {
//            [QMUITips showInfo:@"登录成功"];
//        }
//    }];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
