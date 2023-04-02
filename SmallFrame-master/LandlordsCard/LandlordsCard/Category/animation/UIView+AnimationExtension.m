

//
//  UIView+AnimationExtension.m
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/14.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import "UIView+AnimationExtension.h"
#import <Foundation/Foundation.h>

# define TImeDuration 0.25
@implementation UIView (AnimationExtension)

// 实现流星效果
+ (void)TA_startRainEmitterAnimations:(UIView *)animationView
{
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    //展示的图片
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"star"].CGImage);
    
    //每秒粒子产生个数的乘数因子，会和layer的birthRate相乘，然后确定每秒产生的粒子个数
    cell.birthRate = 1;
    //每个粒子存活时长
    cell.lifetime = 5;
    //粒子生命周期范围
    cell.lifetimeRange = 0.3;
    //粒子透明度变化，设置为－0.4，就是每过一秒透明度就减少0.4，这样就有消失的效果,一般设置为负数。
    cell.alphaSpeed = -0.25;
    cell.alphaRange = 1.0;
    //粒子的速度
    cell.velocity = 40;
    //粒子的速度范围
    cell.velocityRange = 20;
    
    //缩放比例
    cell.scale = 0.5;
    //缩放比例范围
    cell.scaleRange = 0.2;
    
    //粒子的初始发射方向
    cell.emissionLongitude = M_PI * -0.8;
    //Y方向的加速度
    cell.yAcceleration = 20.0;
    //X方向加速度
    cell.xAcceleration = -20.0;
    
    CAEmitterLayer *rainEmitter = [CAEmitterLayer layer];
    //发射位置
    //    _rainEmitter.emitterPosition = CGPointMake(kScreenWidth / 1.5, kScreenWidth / 3);
    rainEmitter.emitterPosition = CGPointMake(SCREEN_WIDTH + 100, -100);
    //粒子产生系数，默认为1
    rainEmitter.birthRate = 1;
    //发射器的尺寸
    rainEmitter.emitterSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    //发射的形状
    rainEmitter.emitterShape = kCAEmitterLayerLine;
    //发射的模式
    rainEmitter.emitterMode = kCAEmitterLayerOutline;
    //渲染模式
    rainEmitter.renderMode = kCAEmitterLayerOldestFirst;
    rainEmitter.masksToBounds = NO;
    rainEmitter.emitterCells = @[cell];
    [animationView.layer addSublayer:rainEmitter];
}

- (void)TA_tipAnimation:(UIView *)tipView toPoint:(CGPoint)toPoint angle:(CGFloat)angle scale:(CGFloat)scaleValue animationDelegate:(id)animationDelegate{
    //平移
    CGPoint fromPoint = tipView.center;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    [movePath addLineToPoint:toPoint];
    tipView.center = toPoint;
    
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.duration = TImeDuration;
    moveAnim.repeatCount = 1;
    moveAnim.removedOnCompletion = NO;
    moveAnim.fillMode = kCAFillModeForwards;
    moveAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    //旋转
    CABasicAnimation *TransformAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //沿Z轴旋转
    TransformAnim.toValue = @(angle);
    TransformAnim.cumulative = YES;
    TransformAnim.duration = TImeDuration;
    TransformAnim.repeatCount = 1;
    TransformAnim.removedOnCompletion = NO;
    TransformAnim.fillMode = kCAFillModeForwards;
    TransformAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    // 放大
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.toValue = @(scaleValue);
    scaleAnimation.cumulative = YES;
    scaleAnimation.duration = TImeDuration;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    //动画组
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim,TransformAnim,scaleAnimation,nil];
    animGroup.duration = TImeDuration;
    animGroup.repeatCount = 1;
    animGroup.removedOnCompletion = NO;
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.delegate = animationDelegate;
    [tipView.layer addAnimation:animGroup forKey:nil];
}

- (void)TA_CardAnimation:(UIView *)tipView toPoint:(CGPoint)toPoint scaleValue:(CGFloat)scaleValue ZValue:(CGFloat)ZValue{
    
    
    [UIView animateWithDuration:1 animations:^{
        
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1 / 400.0;
        transform = CATransform3DTranslate(transform, toPoint.x, toPoint.y, ZValue);
        transform = CATransform3DScale(transform, scaleValue, scaleValue, scaleValue);
        tipView.layer.transform = transform;
    }];
}

@end
