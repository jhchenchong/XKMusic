//
//  XKCollectionComponent.h
//  XKComponentTableView
//
//  Created by 浪漫恋星空 on 2018/2/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKActionHeaderComponent.h"

@interface XKCollectionComponent : XKActionHeaderComponent<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, readonly, strong) UICollectionView *collectionView;

- (void)configureCollectionView:(UICollectionView *)collectionView NS_REQUIRES_SUPER;

- (CGRect)collectionViewRectForBounds:(CGRect)bounds;

@end
