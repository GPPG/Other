//
//  UIColor+Hex.h
//  TYFoundationDemo
//
//  Created by tanyang on 15/12/23.
//  Copyright © 2015年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(NSUInteger)hexColor;

+ (UIColor *)colorWithHex:(NSUInteger)hexColor alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

//渐变色
+ (CAGradientLayer *)layerWithGradient:(CGRect)frame startColor:(UIColor *)startColor startPoint:(CGPoint)startPoint endColor:(UIColor *)endColor endPoint:(CGPoint)endPoint;
@end
