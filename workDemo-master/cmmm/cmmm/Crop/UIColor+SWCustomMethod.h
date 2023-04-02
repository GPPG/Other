


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (SWCustomMethod)

+ (UIColor *)hexStringColor:(NSString *)hexString;
+ (UIColor *)hexStringColor:(NSString *)hexString alpha:(CGFloat)alphaValue;
+ (UIColor *)RGBColorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b alpha:(CGFloat)alphaValue;

/* 渐变色  point: 左上点为(0,0), 右下点为(1,1)*/
+(CAGradientLayer *)gradientColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor rect:(CGRect)rect;
+(CAGradientLayer *)gradientColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint rect:(CGRect)rect;


@end

