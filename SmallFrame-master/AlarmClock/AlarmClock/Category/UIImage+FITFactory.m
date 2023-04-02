//
// Created by DomenCai on 2018/7/5.
// Copyright (c) 2018 supergeek. All rights reserved.
//


@implementation UIImage (FITFactory)

+ (UIImage *)createImageHexColor:(NSString *)color size:(CGSize)size {
    return [self createImageColor:[UIColor colorWithHexString:color] size:size];
}

+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size {
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //绘制颜色区域
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [color setFill];
    [path fill];
    //从图形上下文获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();

    return newImage;
}

+ (UIImage *)horizontalGradientStartHexColor:(NSString *)startColor endHexColor:(NSString *)endColor size:(CGSize)size {
    return [self horizontalGradientStartColor:[UIColor colorWithHexString:startColor] endColor:[UIColor colorWithHexString:endColor] size:size];
}

+ (UIImage *)horizontalGradientStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *colors = @[(id) startColor.CGColor, (id) endColor.CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, NULL);
    CGPoint start = CGPointZero;
    CGPoint end = CGPointMake(size.width, 0);

    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();

    return image;
}
@end