//
//  QMUIAlertAction+XK.h
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/26.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface QMUIAlertAction (XK)

+ (instancetype)defaultStyleActionWithTitle:(NSString *)title handler:(void (^)(QMUIAlertAction *action))handler;


+ (instancetype)cancelStyleActionWithTitle:(NSString *)title handler:(void (^)(QMUIAlertAction *action))handler;

+ (instancetype)destructiveStyleActionWithTitle:(NSString *)title handler:(void (^)(QMUIAlertAction *action))handler;

@end

NS_INLINE QMUIAlertAction * defaultStyleAction(NSString *title, void (^handler)(QMUIAlertAction *action)) {
    
    return [QMUIAlertAction defaultStyleActionWithTitle:title handler:handler];
}

NS_INLINE QMUIAlertAction * cancelStyleAction(NSString *title, void (^handler)(QMUIAlertAction *action)) {
    
    return [QMUIAlertAction cancelStyleActionWithTitle:title handler:handler];
}

NS_INLINE QMUIAlertAction * destructiveStyleAction(NSString *title, void (^handler)(QMUIAlertAction *action)) {
    
    return [QMUIAlertAction destructiveStyleActionWithTitle:title handler:handler];
}
