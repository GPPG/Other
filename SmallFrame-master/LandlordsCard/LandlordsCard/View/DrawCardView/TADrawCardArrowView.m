


//
//  TADrawCardArrowView.m
//  Tarot
//
//  Created by 郭鹏 on 2018/12/20.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import "TADrawCardArrowView.h"


#define Animationduration 0.25

@interface TADrawCardArrowView()


@property (nonatomic, strong) CAShapeLayer *leftProgressLayer;


@property (nonatomic, strong) CAShapeLayer *rightProgressLayer;


@property (nonatomic, strong) UIImageView *leftArrowimageView;


@property (nonatomic, strong) UIImageView *rightimageView;


@property (nonatomic, strong) UIBezierPath *leftPath;

@property (nonatomic, strong) UIBezierPath *rightPath;

@property (nonatomic, assign) CGPoint centerPoint;

@property (nonatomic, assign) CGFloat radiusValue;


@end



@implementation TADrawCardArrowView


- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radiusValue{
    
    if (self = [super init]) {

        self.centerPoint = center;
        self.radiusValue = radiusValue;
    }
    return self;
    
}


- (void)addView{
    
    [self.layer addSublayer:self.leftProgressLayer];
    [self.layer addSublayer:self.rightProgressLayer];
    
    [self addSubview:self.leftArrowimageView];
    [self addSubview:self.rightimageView];
}

- (void)addPath{
    

    self.leftPath = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radiusValue startAngle:1.499 * M_PI endAngle:1.45 * M_PI clockwise:NO];
    
    self.rightPath = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radiusValue startAngle:1.501 * M_PI endAngle: 1.55 * M_PI clockwise:YES];

    self.rightProgressLayer.path = self.rightPath.CGPath;
    self.leftProgressLayer.path = self.leftPath.CGPath;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.leftProgressLayer.frame = CGRectMake(0, 0, self.width, self.height);
    self.rightProgressLayer.frame = CGRectMake(0, 0, self.width, self.height);
    
    self.leftArrowimageView.size = CGSizeMake(10, 20);
    self.rightimageView.size = CGSizeMake(10, 20);
}

#pragma mark - public
- (void)startLineAnimation{
        
    [self addView];

    [self addPath];

    [self performAnimtion];
    
}

- (void)performAnimtion{
    
    CABasicAnimation *animMove = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animMove.fromValue = @0;
    animMove.toValue = @1;
    animMove.duration = Animationduration;
    animMove.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self startLeftArrowAnimation];
    
    [self startRightArrowAnimation];

    [self.leftProgressLayer addAnimation:animMove forKey:nil];
    [self.rightProgressLayer addAnimation:animMove forKey:nil];
}

- (void)startLeftArrowAnimation{
    
    CAKeyframeAnimation *animLeftArrow = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animLeftArrow.fillMode = kCAFillModeForwards;
    animLeftArrow.removedOnCompletion = NO;
    animLeftArrow.path = self.leftPath.CGPath;
    animLeftArrow.duration = Animationduration;
    animLeftArrow.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *transformLeftAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    transformLeftAnim.toValue = @(angle2Rad(-10));
    transformLeftAnim.cumulative = YES;
    transformLeftAnim.duration = Animationduration;
    transformLeftAnim.repeatCount = 1;
    transformLeftAnim.removedOnCompletion = NO;
    transformLeftAnim.fillMode = kCAFillModeForwards;
    transformLeftAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    //动画组
    CAAnimationGroup *animLeftGroup = [CAAnimationGroup animation];
    animLeftGroup.animations = [NSArray arrayWithObjects:animLeftArrow,transformLeftAnim,nil];
    animLeftGroup.duration = Animationduration;
    animLeftGroup.repeatCount = 1;
    animLeftGroup.removedOnCompletion = NO;
    animLeftGroup.fillMode = kCAFillModeForwards;
    
    [self.leftArrowimageView.layer addAnimation:animLeftGroup forKey:nil];
}

- (void)startRightArrowAnimation{
    
    CAKeyframeAnimation *animRightArrow = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animRightArrow.fillMode = kCAFillModeForwards;
    animRightArrow.removedOnCompletion = NO;
    animRightArrow.path = self.rightPath.CGPath;
    animRightArrow.duration = Animationduration;
    animRightArrow.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    
    CABasicAnimation *transformRightAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    transformRightAnim.toValue = @(angle2Rad(10));
    transformRightAnim.cumulative = YES;
    transformRightAnim.duration = Animationduration;
    transformRightAnim.repeatCount = 1;
    transformRightAnim.removedOnCompletion = NO;
    transformRightAnim.fillMode = kCAFillModeForwards;
    transformRightAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    CAAnimationGroup *animRightGroup = [CAAnimationGroup animation];
    animRightGroup.animations = [NSArray arrayWithObjects:animRightArrow,transformRightAnim,nil];
    
    animRightGroup.duration = Animationduration;
    animRightGroup.repeatCount = 1;
    animRightGroup.removedOnCompletion = NO;
    animRightGroup.fillMode = kCAFillModeForwards;
    
    [self.rightimageView.layer addAnimation:animRightGroup forKey:nil];

}

#pragma mark - laz7
- (CAShapeLayer *)leftProgressLayer
{
    if (!_leftProgressLayer) {
        _leftProgressLayer = [CAShapeLayer layer];
        _leftProgressLayer.fillColor = [UIColor clearColor].CGColor;
        _leftProgressLayer.strokeColor = [UIColor whiteColor].CGColor;
        _leftProgressLayer.lineWidth = 2;
        _leftProgressLayer.fillRule = kCAFillModeForwards;
        _leftProgressLayer.autoreverses = NO;
        [_leftProgressLayer setLineDashPattern:@[@(6),@(6)]];
    }
    return _leftProgressLayer;
}

- (CAShapeLayer *)rightProgressLayer
{
    if (!_rightProgressLayer) {
        _rightProgressLayer = [CAShapeLayer layer];
        _rightProgressLayer.fillColor = [UIColor clearColor].CGColor;
        _rightProgressLayer.strokeColor = [UIColor whiteColor].CGColor;
        _rightProgressLayer.lineWidth = 2;
        _rightProgressLayer.fillRule = kCAFillModeForwards;
        [_rightProgressLayer setLineDashPattern:@[@(6),@(6)]];
    }
    return _rightProgressLayer;
}

- (UIImageView *)leftArrowimageView
{
    if (!_leftArrowimageView) {
        _leftArrowimageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_left"]];
        _leftArrowimageView.layer.shouldRasterize = YES;
    }
    return _leftArrowimageView;
}

- (UIImageView *)rightimageView
{
    if (!_rightimageView) {
        _rightimageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
        _rightimageView.layer.shouldRasterize = YES;
    }
    return _rightimageView;
}

@end
