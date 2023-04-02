//
//  TACardRippleView.m
//  Tarot
//
//  Created by 郭鹏 on 2018/12/20.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import "TACardRippleView.h"

@interface TACardRippleView()

@property (nonatomic, strong) CAShapeLayer *circleShapeLayer;

@end


@implementation TACardRippleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpLayers];
    }
    return self;
}

- (void)setUpLayers{
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;

    self.circleShapeLayer = [CAShapeLayer layer];
    _circleShapeLayer.frame = CGRectMake(0, 0, width, width);
    _circleShapeLayer.position = CGPointMake(width / 2.0, height / 2.0);
    _circleShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, width, width)].CGPath;
    _circleShapeLayer.fillColor = [UIColor colorWithHexString:@"#7d65ac"].CGColor;
    _circleShapeLayer.opacity = 0.0;
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.bounds = CGRectMake(0, 0, width, width);
    replicator.position = CGPointMake(width / 2.0, width / 2.0);
    replicator.instanceDelay = 1;
    replicator.instanceCount = 2;
    
    [replicator addSublayer:_circleShapeLayer];
    [self.layer addSublayer:replicator];
}


- (void)startAnimation{
    
    CABasicAnimation *alphaAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnim.fromValue = [NSNumber numberWithFloat:0.6];
    alphaAnim.toValue = [NSNumber numberWithFloat:0.0];
    
    CABasicAnimation *scaleAnim =[CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D t = CATransform3DIdentity;
    CATransform3D t2 = CATransform3DScale(t, 0.0, 0.0, 0.0);
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:t2];
    CATransform3D t3 = CATransform3DScale(t, 1.0, 1.0, 0.0);
    scaleAnim.toValue = [NSValue valueWithCATransform3D:t3];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[alphaAnim, scaleAnim];
    groupAnimation.duration = 4;
    groupAnimation.autoreverses = NO;
    groupAnimation.repeatCount = HUGE;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    

    
    [_circleShapeLayer addAnimation:groupAnimation forKey:nil];
}

- (void)stopAnimation{
    [_circleShapeLayer removeAllAnimations];
}

@end
