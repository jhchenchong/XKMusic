//
//  XKCustomHeaderFooterView.m
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKCustomHeaderFooterView.h"

@implementation XKCustomHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupHeaderFooterView];
        [self buildSubview];
    }
    
    return self;
}

- (void)setHeaderFooterViewBackgroundColor:(UIColor *)color {
    
    self.contentView.backgroundColor = color;
}

- (void)setupHeaderFooterView {
    
}

- (void)buildSubview {
    
}

- (void)loadContent {
    
}

+ (CGFloat)heightWithData:(id)data {
    
    return 0;
}

+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier {
    
    NSString *identifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:identifier];
}

+ (void)registerToTableView:(UITableView *)tableView {
    
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([self class])];
}

+ (XKCellHeaderFooterDataAdapter *)dataAdapterWithReuseIdentifier:(NSString *)reuseIdentifier
                                                             data:(id)data
                                                           height:(CGFloat)height
                                                             type:(NSInteger)type {
    
    return [XKCellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:reuseIdentifier
                                                                                    data:data
                                                                                  height:height
                                                                                    type:type];
}

+ (XKCellHeaderFooterDataAdapter *)dataAdapterWithData:(id)data
                                                height:(CGFloat)height
                                                  type:(NSInteger)type {
    
    return [XKCellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class])
                                                  data:data
                                                height:height
                                                  type:type];
}

+ (XKCellHeaderFooterDataAdapter *)dataAdapterWithHeight:(CGFloat)height
                                                    type:(NSInteger)type {
    
    return [XKCellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class])
                                                  data:nil
                                                height:height
                                                  type:type];
}

+ (XKCellHeaderFooterDataAdapter *)dataAdapterWithData:(id)data
                                                height:(CGFloat)height {
    
    return [XKCellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class]) data:data height:height type:0];
}

+ (XKCellHeaderFooterDataAdapter *)dataAdapterWithHeight:(CGFloat)height {
    
    return [XKCellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class]) data:nil height:height type:0];
}

+ (XKCellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapterWithReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type {
    
    return [XKCellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:reuseIdentifier data:data height:[[self class] heightWithData:data] type:type];
}

+ (XKCellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data type:(NSInteger)type {
    
    return [XKCellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class]) data:data height:[[self class] heightWithData:data] type:type];
}

+ (XKCellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data {
    
    return [XKCellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class]) data:data height:[[self class] heightWithData:data] type:0];
}

+ (XKCellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapter {
    
    return [XKCellHeaderFooterDataAdapter cellHeaderFooterDataAdapterWithReuseIdentifier:NSStringFromClass([self class]) data:nil height:[[self class] heightWithData:nil] type:0];
}

@end
