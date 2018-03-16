//
//  QMUIAlertController+XK.h
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/26.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "QMUIAlertAction+XK.h"

@interface QMUIAlertController (XK)

+ (void)alertStyleShowWithTitle:(NSString *)title
                        message:(NSString *)message
              alertActionsBlock:(void (^)(NSMutableArray <QMUIAlertAction *> *alertActions))alertActionsBlock;


+ (void)actionSheetStyleShowWithTitle:(NSString *)title
                              message:(NSString *)message
                    alertActionsBlock:(void (^)(NSMutableArray <QMUIAlertAction *> *alertActions))alertActionsBlock;

@end
