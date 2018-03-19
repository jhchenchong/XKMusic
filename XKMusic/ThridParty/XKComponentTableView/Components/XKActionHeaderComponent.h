//
//  XKActionHeaderComponent.h
//  XKComponentTableView
//
//  Created by 浪漫恋星空 on 2018/2/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKHeaderComponent.h"

@protocol XKActionHeaderComponentDelegate <XKTableComponentDelegate>

@optional

- (void)tableComponent:(id<XKTableComponent>)component didTapActionButton:(UIButton *)actionButton;

@end


@interface XKActionHeaderComponent : XKHeaderComponent

@property (nonatomic, weak) id<XKActionHeaderComponentDelegate> delegate;
@property (nonatomic, readonly, strong) UIButton *actionButton;
@property (nonatomic, strong) NSString *actionTitle;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *actionImageName;

@end
