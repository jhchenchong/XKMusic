//
//  XKCellHeaderFooterDataAdapter.h
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKCellHeaderFooterDataAdapter : NSObject

/// 头部或者尾部的重用标识符
@property (nonatomic, strong) NSString *reuseIdentifier;

/// 数据源(可以为空)
@property (nonatomic, strong) id data;

/// 头部或者尾部的高度
@property (nonatomic, assign) CGFloat height;

/// section
@property (nonatomic, assign) NSInteger section;

/// 类型  相同的头部或者尾部可能有不一样的类型
@property (nonatomic, assign) NSInteger type;

/**
 *  便利构造方法.
 *
 *  @param reuseIdentifier 重用标识符.
 *  @param data Data,      数据源.
 *  @param height          高度.
 *  @param type            类型
 *
 *  @return XKCellHeaderFooterDataAdapter
 */
+ (instancetype)cellHeaderFooterDataAdapterWithReuseIdentifier:(NSString *)reuseIdentifier
                                                          data:(id)data
                                                        height:(CGFloat)height
                                                          type:(NSInteger)type;

@end
