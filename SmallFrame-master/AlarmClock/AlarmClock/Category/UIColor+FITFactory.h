//
//  UIColor+FITFactory.h
//  fitness
//
//  Created by admin on 2018/6/5.
//  Copyright © 2018年 supergeek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FITFactory)

+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithRGB:(int)r g:(int)g b:(int)b;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
//+ (UIColor*)drawInRect:(int)r g:(int)g b:(int)b;


@end
