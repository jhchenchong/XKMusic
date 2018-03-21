//
//  NSString+LabelWidthAndHeight.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LabelWidthAndHeight)

- (CGFloat)heightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute fixedWidth:(CGFloat)width;
- (CGFloat)widthWithStringAttribute:(NSDictionary <NSString *, id> *)attribute;
+ (CGFloat)oneLineOfTextHeightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute;

#pragma mark - Font.

- (CGFloat)heightWithStringFont:(UIFont *)font fixedWidth:(CGFloat)width;
- (CGFloat)widthWithStringFont:(UIFont *)font;
+ (CGFloat)oneLineOfTextHeightWithStringFont:(UIFont *)font;

@end
