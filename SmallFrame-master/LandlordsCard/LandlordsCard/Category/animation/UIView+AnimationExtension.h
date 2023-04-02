//
//  UIView+AnimationExtension.h
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/14.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AnimationExtension)

- (void)TA_tipAnimation:(UIView *)tipView toPoint:(CGPoint)toPoint angle:(CGFloat)angle scale:(CGFloat)scaleValue animationDelegate:(id)animationDelegate;

- (void)TA_CardAnimation:(UIView *)tipView toPoint:(CGPoint)toPoint scaleValue:(CGFloat)scaleValue ZValue:(CGFloat)ZValue;

+ (void)TA_startRainEmitterAnimations:(UIView *)animationView;

@end

NS_ASSUME_NONNULL_END
