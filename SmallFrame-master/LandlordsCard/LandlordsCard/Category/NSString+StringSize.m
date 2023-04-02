//
//  NSString+StringSize.m
//  最简单的动态行高
//
//  Created by 9188 on 16/7/22.
//  Copyright © 2016年 朱同海. All rights reserved.
//

#import "NSString+StringSize.h"

@implementation NSString (StringSize)
- (CGSize)sizeWithpreferHeight:(CGFloat)height font:(UIFont *)font{
    if (!font) {
        return CGSizeZero;
    }
    NSDictionary *dict=@{NSFontAttributeName : font};
    return [self sizeWithpreferHeight:height attribute:dict];
}

- (CGSize)sizeWithpreferHeight:(CGFloat)height attribute:(NSDictionary *)attr{
    CGRect rect=[self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attr context:nil];
    CGFloat sizeWidth=ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght=ceilf(CGRectGetHeight(rect));
    return CGSizeMake(sizeWidth, sizeHieght);
}

- (CGSize)sizeWithPreferWidth:(CGFloat)width font:(UIFont *)font{
    if (!font) {
        return CGSizeZero;
    }
 
    NSMutableParagraphStyle *style1 = [[NSMutableParagraphStyle alloc] init];
    style1.lineSpacing = 3;
    style1.paragraphSpacing = 16;

    NSDictionary *dict=@{NSFontAttributeName : font,
                         NSParagraphStyleAttributeName : style1,
                         };
    return [self sizeWithPreferWidth:width attribute:dict];
}

- (CGSize)sizeWithPreferWidth:(CGFloat)width attribute:(NSDictionary *)attr{
    CGRect rect=[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attr context:nil];
    CGFloat sizeWidth=ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght=ceilf(CGRectGetHeight(rect));
    return CGSizeMake(sizeWidth, sizeHieght);
}

@end
