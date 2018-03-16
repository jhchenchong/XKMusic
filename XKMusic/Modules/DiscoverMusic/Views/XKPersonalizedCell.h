//
//  XKPersonalizedCell.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKPersonalizedModel.h"

/// 推荐歌单自定义CollectionViewCell
@interface XKPersonalizedCell : XKCustomCollectionViewCell

@property (nonatomic, strong) XKPersonalizedModel *model;

@end
