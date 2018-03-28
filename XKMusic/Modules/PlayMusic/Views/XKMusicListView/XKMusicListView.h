//
//  XKMusicListView.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/28.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XKMusicModel;
@interface XKMusicListView : UIView

@property (nonatomic, copy) NSArray<XKMusicModel *> *musicModels;

@end
