//
//  GPAvatarView.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/4/18.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "GPAvatarView.h"


#define LineWidth 6
#define AnimationDuration 1


@interface GPAvatarView()
@property (nonatomic, strong) CALayer *photoLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation GPAvatarView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self addView];
    }
    return self;
}
- (void)addView
{
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor blackColor];
    self.nameLabel = nameLabel;
    
    self.photoLayer = [CALayer layer];
    self.circleLayer = [CAShapeLayer layer];
    self.maskLayer = [CAShapeLayer layer];
}
- (void)didMoveToWindow
{
    [self.layer addSublayer:self.photoLayer];
    self.photoLayer.mask = self.maskLayer;
    [self.layer addSublayer:self.circleLayer];
    [self addSubview:self.nameLabel];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.photoLayer.frame = CGRectMake((self.bounds.size.width - self.image.size.width + LineWidth) * 0.5 , (self.bounds.size.height - self.image.size.height - LineWidth) * 0.5, self.image.size.width, self.image.size.height);
    
    self.circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    self.circleLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.circleLayer.lineWidth = LineWidth;
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    
    self.maskLayer.path = self.circleLayer.path;
    self.maskLayer.position = CGPointMake(0, 10);

    self.nameLabel.frame = CGRectMake(0, self.bounds.size.height + 10, self.bounds.size.width, 24);
}
- (void)bounceOff:(CGPoint)point morphSize:(CGSize)morphSize
{
    CGPoint originalCenter = self.center;
    
    [UIView animateWithDuration:AnimationDuration delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.center = point;
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:AnimationDuration delay:AnimationDuration usingSpringWithDamping:0.7 initialSpringVelocity:1.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        self.center = originalCenter;
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self bounceOff:point morphSize:morphSize];
        });
        
    }];
    
    CGRect morphedFrame;
    if (originalCenter.x > point.x) {
        morphedFrame = CGRectMake(0.0, self.bounds.size.height - morphSize.height, morphSize.width, morphSize.height);
    }else{
        morphedFrame = CGRectMake(self.bounds.size.width - morphSize.width, self.bounds.size.height - morphSize.height, morphSize.width, morphSize.height);
    }
    
    CABasicAnimation *morphAnimation = [CABasicAnimation animationWithKeyPath:animationPath];
    morphAnimation.duration = AnimationDuration;
    morphAnimation.toValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithOvalInRect:morphedFrame].CGPath);
    morphAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.circleLayer addAnimation:morphAnimation forKey:nil];
    [self.maskLayer addAnimation:morphAnimation forKey:nil];
}
#pragma mark - set
- (void)setName:(NSString *)name
{
    _name = name;
    self.nameLabel.text = name;
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.photoLayer.contents = CFBridgingRelease(image.CGImage);
}
@end
