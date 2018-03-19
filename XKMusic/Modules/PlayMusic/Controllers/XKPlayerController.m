//
//  XKPlayerController.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPlayerController.h"

@interface XKPlayerController ()

@end

@implementation XKPlayerController

+ (instancetype)sharedInstance {
    static XKPlayerController *playerVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerVC = [[XKPlayerController alloc] init];
    });
    return playerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
