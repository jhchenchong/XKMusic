//
//  XKSongListDetailController.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "XKPersonalizedModel.h"

@interface XKSongListDetailController : QMUICommonTableViewController

- (instancetype)initWithPersonalizedModel:(XKPersonalizedModel *)model;

@end
