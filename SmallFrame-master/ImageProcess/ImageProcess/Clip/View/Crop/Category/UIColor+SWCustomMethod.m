


#import "UIColor+SWCustomMethod.h"

@implementation UIColor (SWCustomMethod)


+(UIColor *)hexStringColor:(NSString *)hexString alpha:(CGFloat)alphaValue
{
    UIColor *color;
    NSString *colorString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] uppercaseString];
    if (colorString.length < 6) {
        color = [UIColor clearColor];
    }
    
    if ([colorString hasPrefix:@"0X"]) {
        colorString = [colorString substringFromIndex:2];
    }
    if ([colorString hasPrefix:@"#"]) {
        colorString = [colorString substringFromIndex:1];
    }
    if (colorString.length != 6) {
        color = [UIColor clearColor];
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [colorString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [colorString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [colorString substringWithRange:range];
    
    unsigned int r , g , b ;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    color = [UIColor colorWithRed:((CGFloat) r / 255.0f) green:((CGFloat) g / 255.0f) blue:((CGFloat)b / 255.0f) alpha:alphaValue];
    return color;
}

+ (UIColor *)hexStringColor:(NSString *)hexString
{
    return [UIColor hexStringColor:hexString alpha:1.f];
}

+ (UIColor *)RGBColorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((CGFloat) r / 255.0f) green:((CGFloat) g / 255.0f) blue:((CGFloat)b / 255.0f) alpha:alphaValue];
}

+ (CAGradientLayer *)gradientColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint :(CGPoint)endPoint rect:(CGRect)rect
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0, @1];
    return gradientLayer;
}

+ (CAGradientLayer *)gradientColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor rect:(CGRect)rect
{
    return [UIColor gradientColorWithStartColor:startColor endColor:endColor startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1) rect:rect];
}


@end
