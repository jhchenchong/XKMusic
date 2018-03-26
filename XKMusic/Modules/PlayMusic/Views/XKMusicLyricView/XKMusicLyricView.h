//
//  XKMusicLyricView.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/24.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKLyricModel.h"

@interface XKMusicLyricView : UIView

@property (nonatomic, copy) NSArray<XKLyricModel *> *lyricModels;
@property (nonatomic, assign) NSInteger lyricIndex;

@end
