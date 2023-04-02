//
//  UIFont+FITFactory.m
//  fitness
//
//  Created by admin on 2018/6/5.
//  Copyright © 2018年 supergeek. All rights reserved.
//


@implementation UIFont (FITFactory)

+ (UIFont *)sfProDisplayBoldFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"FiraSans-Bold" size:size];
    return font;
}

+ (UIFont *)sfProDisplayMediumFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"FiraSans-Medium" size:size];
    return font;
}

+ (UIFont *)sfProDisplayRegularFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"FiraSans-Regular" size:size];
    return font;
}

+ (UIFont *)sfProDisplayBoldItalicFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"FiraSans-BoldItalic" size:size];
    return font;
}

+ (UIFont *)sfProDisplaySemiBoldItalicFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"FiraSans-SemiBoldItalic" size:size];
    return font;
}

+ (UIFont *)sfProDisplayExtraBoldItalicFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"FiraSans-ExtraBoldItalic" size:size];
    return font;
}

@end
