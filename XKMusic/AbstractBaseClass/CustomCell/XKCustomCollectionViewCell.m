//
//  XKCustomCollectionViewCell.m
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/26.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKCustomCollectionViewCell.h"

@implementation XKCustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupCell];
        
        [self buildSubview];
    }
    
    return self;
}

- (void)setupCell {
    
}

- (void)buildSubview {
    
}

- (void)loadContent {
    
}

- (void)contentOffset:(CGPoint)offset {
    
}

- (void)selectedEvent {
    
}

+ (XKCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [XKCellDataAdapter collectionCellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellType:type];
}

+ (XKCellDataAdapter *)dataAdapterWithData:(id)data type:(NSInteger)type {
    
    return [XKCellDataAdapter collectionCellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:data cellType:type];
}

+ (XKCellDataAdapter *)dataAdapterWithData:(id)data {
    
    return [XKCellDataAdapter collectionCellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:data cellType:0];
}

+ (void)registerToCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier {
    
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:reuseIdentifier.length ? reuseIdentifier : NSStringFromClass([self class])];
}

+ (void)registerToCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
}

@end
