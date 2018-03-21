//
//  NSString+LabelWidthAndHeight.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "NSString+LabelWidthAndHeight.h"

@implementation NSString (LabelWidthAndHeight)

- (CGFloat)heightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute fixedWidth:(CGFloat)width {
    NSParameterAssert(attribute);
    CGFloat height = 0;
    if (self.length) {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                      attributes:attribute
                                         context:nil];
        height = rect.size.height;
    }
    return height;
}

- (CGFloat)widthWithStringAttribute:(NSDictionary <NSString *, id> *)attribute {
    NSParameterAssert(attribute);
    CGFloat width = 0;
    if (self.length) {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                      attributes:attribute
                                         context:nil];
        width = rect.size.width;
    }
    return width;
}

+ (CGFloat)oneLineOfTextHeightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute {
    NSParameterAssert(attribute);
    CGFloat height = 0;
    CGRect rect = [@"One" boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                          options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil];
    height = rect.size.height;
    return height;
}

- (CGFloat)heightWithStringFont:(UIFont *)font fixedWidth:(CGFloat)width {
    NSParameterAssert(font);
    CGFloat height = 0;
    if (self.length) {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName: font}
                                         context:nil];
        height = rect.size.height;
    }
    return height;
}

- (CGFloat)widthWithStringFont:(UIFont *)font {
    NSParameterAssert(font);
    CGFloat width = 0;
    if (self.length) {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName: font}
                                         context:nil];
        width = rect.size.width;
    }
    return width;
}

+ (CGFloat)oneLineOfTextHeightWithStringFont:(UIFont *)font {
    NSParameterAssert(font);
    CGFloat height = 0;
    CGRect rect    = [@"One" boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                          options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName: font}
                                          context:nil];
    height = rect.size.height;
    return height;
}

@end
