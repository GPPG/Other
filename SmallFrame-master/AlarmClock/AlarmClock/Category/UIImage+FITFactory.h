//
// Created by DomenCai on 2018/7/5.
// Copyright (c) 2018 supergeek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (FITFactory)
+ (UIImage *)createImageHexColor:(NSString *)color size:(CGSize)size;

+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)horizontalGradientStartHexColor:(NSString *)startColor endHexColor:(NSString *)endColor size:(CGSize)size;

+ (UIImage *)horizontalGradientStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size;
@end