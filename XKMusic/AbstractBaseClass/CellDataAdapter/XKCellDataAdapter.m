//
//  XKCellDataAdapter.m
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKCellDataAdapter.h"

@implementation XKCellDataAdapter

+ (instancetype)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers
                                                  data:(id)data
                                            cellHeight:(CGFloat)cellHeight
                                              cellType:(NSInteger)cellType {
    
    XKCellDataAdapter *adapter  = [[[self class] alloc] init];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data                = data;
    adapter.cellHeight          = cellHeight;
    adapter.cellType            = cellType;
    
    return adapter;
}

+ (instancetype)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers
                                                  data:(id)data
                                            cellHeight:(CGFloat)cellHeight
                                             cellWidth:(CGFloat)cellWidth
                                              cellType:(NSInteger)cellType {
    
    XKCellDataAdapter *adapter  = [[[self class] alloc] init];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data                = data;
    adapter.cellHeight          = cellHeight;
    adapter.cellWidth           = cellWidth;
    adapter.cellType            = cellType;
    
    return adapter;
}

+ (instancetype)collectionCellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers
                                                            data:(id)data
                                                        cellType:(NSInteger)cellType {
    
    XKCellDataAdapter *adapter  = [[[self class] alloc] init];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data                = data;
    adapter.cellType            = cellType;
    
    return adapter;
}

@end
