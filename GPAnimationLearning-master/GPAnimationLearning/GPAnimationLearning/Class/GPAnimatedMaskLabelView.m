//
//  GPAnimatedMaskLabelView.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/5/16.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "GPAnimatedMaskLabelView.h"


@interface GPAnimatedMaskLabelView()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) NSDictionary *textAttributesDic;

@end

@implementation GPAnimatedMaskLabelView

#pragma mark - 生命周期
- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:animationLocations];
    gradientAnimation.fromValue = @[@(0.0),@(0.0),@(0.0),@(0.0),@(0.0),@(0.25)];;
    gradientAnimation.toValue = @[@(0.65),@(0.8),@(0.85),@(0.9),@(0.95),@(1.0)];;
    gradientAnimation.duration = 3.0;
    gradientAnimation.repeatCount = CGFLOAT_MAX;
    [self.gradientLayer addAnimation:gradientAnimation forKey:nil];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = [UIColor greenColor].CGColor;
    self.gradientLayer.frame = CGRectMake(-self.width, 0, self.width *3, self.height);
    [self.layer addSublayer:self.gradientLayer];
}

#pragma mark - set
- (void)setTextStr:(NSString *)textStr
{
    _textStr = textStr;
    
    [self setNeedsDisplay];
    UIGraphicsImageRenderer *imageRender = [[UIGraphicsImageRenderer alloc]initWithSize:self.bounds.size];
    UIImage *image = [imageRender imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [textStr drawInRect:self.bounds withAttributes:self.textAttributesDic];
    }];
    CALayer *maskLayer = [[CALayer alloc]init];
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    maskLayer.frame = CGRectMake(self.width + 25, 10, self.width, self.height);
    maskLayer.contents = (__bridge id _Nullable)(image.CGImage);
    self.gradientLayer.mask = maskLayer;
}
#pragma mark - 懒加载
- (NSDictionary *)textAttributesDic
{
    if (!_textAttributesDic) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        style.alignment = NSTextAlignmentCenter;
        _textAttributesDic = @{
                               NSFontAttributeName: [UIFont systemFontOfSize:28],
                               NSParagraphStyleAttributeName : style,
                               };
    }
    return _textAttributesDic;
}
- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        
        _gradientLayer = [[CAGradientLayer alloc]init];
        _gradientLayer.startPoint = CGPointMake(0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        
        NSArray *colors = @[(__bridge id)[UIColor yellowColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor cyanColor].CGColor,(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor];
        _gradientLayer.colors = colors;
        
        NSArray *locations = @[@(0.0),@(0.0),@(0.0),@(0.0),@(0.0),@(0.25)];
        _gradientLayer.locations = locations;
    }
    return _gradientLayer;
}

@end
