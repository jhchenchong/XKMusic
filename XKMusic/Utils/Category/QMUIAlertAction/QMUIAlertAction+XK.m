//
//  QMUIAlertAction+XK.m
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/26.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "QMUIAlertAction+XK.h"

@implementation QMUIAlertAction (XK)

+ (instancetype)defaultStyleActionWithTitle:(NSString *)title handler:(void (^)(QMUIAlertAction *action))handler {
    
    return [QMUIAlertAction actionWithTitle:title style:QMUIAlertActionStyleDefault handler:handler];
}

+ (instancetype)cancelStyleActionWithTitle:(NSString *)title handler:(void (^)(QMUIAlertAction *action))handler {
    
    return [QMUIAlertAction actionWithTitle:title style:QMUIAlertActionStyleCancel handler:handler];
}

+ (instancetype)destructiveStyleActionWithTitle:(NSString *)title handler:(void (^)(QMUIAlertAction *action))handler {
    
    return [QMUIAlertAction actionWithTitle:title style:QMUIAlertActionStyleDestructive handler:handler];
}

@end
