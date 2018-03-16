//
//  QMUIAlertController+XK.m
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/26.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "QMUIAlertController+XK.h"

@implementation QMUIAlertController (XK)

+ (void)alertControllerShowWithTitle:(NSString *)title
                             message:(NSString *)message
                      preferredStyle:(QMUIAlertControllerStyle)preferredStyle
                   alertActionsBlock:(void (^)(NSMutableArray <QMUIAlertAction *> *alertActions))alertActionsBlock {
    
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:preferredStyle];
    
    NSMutableArray *alertActions = [NSMutableArray array];
    
    if (alertActionsBlock) {
        
        alertActionsBlock(alertActions);
    }
    
    for (QMUIAlertAction *action in alertActions) {
        
        [alertController addAction:action];
    }
    
    [alertController showWithAnimated:YES];
}

+ (void)actionSheetStyleShowWithTitle:(NSString *)title
                              message:(NSString *)message
                    alertActionsBlock:(void (^)(NSMutableArray <QMUIAlertAction *> *alertActions))alertActionsBlock {
    
    [[self class] alertControllerShowWithTitle:title
                                       message:message
                                preferredStyle:QMUIAlertControllerStyleActionSheet
                             alertActionsBlock:alertActionsBlock];
}

+ (void)alertStyleShowWithTitle:(NSString *)title
                        message:(NSString *)message
              alertActionsBlock:(void (^)(NSMutableArray <QMUIAlertAction *> *alertActions))alertActionsBlock {
    
    [[self class] alertControllerShowWithTitle:title
                                       message:message
                                preferredStyle:QMUIAlertControllerStyleAlert
                             alertActionsBlock:alertActionsBlock];
}

@end
