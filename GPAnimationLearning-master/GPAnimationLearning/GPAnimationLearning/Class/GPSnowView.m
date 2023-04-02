//
//  GPSnowView.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/4/5.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "GPSnowView.h"

@implementation GPSnowView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self getSnowView];
    }
    return self;
}
- (void)getSnowView
{
 
    CAEmitterLayer *emitter = [[CAEmitterLayer alloc]init];
    emitter.emitterPosition = CGPointMake(SCREEN_WIDTH * 0.5, 0);
    emitter.emitterSize = self.bounds.size;
    emitter.emitterShape = kCAEmitterLayerRectangle;

    CAEmitterCell *emitterCell = [[CAEmitterCell alloc]init];
    emitterCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"flake.png"].CGImage);
    emitterCell.birthRate = 200;
    emitterCell.lifetime = 3.5;
    emitterCell.color = [UIColor whiteColor].CGColor;
    emitterCell.redRange = 0.0;
    emitterCell.blueRange = 0.1;
    emitterCell.greenRange = 0.0;
    emitterCell.velocity = 10;
    emitterCell.velocityRange = 350;
    emitterCell.emissionRange = M_PI_2;
    emitterCell.emissionLongitude = -M_PI;
    emitterCell.yAcceleration = 70;
    emitterCell.xAcceleration = 0;
    emitterCell.scale = 0.33;
    emitterCell.scaleRange = 1.25;
    emitterCell.scaleSpeed = -0.25;
    emitterCell.alphaRange = 0.5;
    emitterCell.alphaSpeed = -0.15;
    emitter.emitterCells = @[emitterCell];

    [self.layer addSublayer:emitter];
}
@end
