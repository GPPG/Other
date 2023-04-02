//
//  UIView+Animation.m
//  UIDynamicDemo
//
//  Created by 李亚洲 on 2018/12/18.
//  Copyright © 2018 李亚洲. All rights reserved.
//

#import "UIView+Animation.h"
#import <objc/runtime.h>

static NSString *const isLoadingViewKey = @"isLoadingView";
static NSString *const disallowChangeImageKey = @"disallowChangeImage";
static NSString *const animationKey = @"animation";
static NSString *const flipBlockKey = @"flipBlock";

@interface UIView ()<CAAnimationDelegate>

@property (nonatomic, assign) BOOL isLoadingView;
@property (nonatomic, assign) BOOL disallowChangeImage;
@property (nonatomic, copy) void(^flipBlock)(BOOL rear, UIView *view);
@property (nonatomic ,strong) Animation *animation;
@end

@implementation UIView (Animation)

//可以使用系统的这个UIView动画块，不过翻转时会有alpha变化
+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration repeatCount:(NSInteger)repeatCount options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion {
    static NSInteger currentRepeatCount = 0;
    currentRepeatCount ++;
    [UIView transitionWithView:view duration:duration options:options animations:animations completion:^(BOOL finished) {
        if (currentRepeatCount < repeatCount) {
            [self transitionWithView:view duration:duration repeatCount:repeatCount options:options animations:animations completion:completion];
        } else {
            if (completion) {
                completion(finished);
            }
        }
    }];
}

- (void)flipAnimationWithAnimation:(void(^)(Animation *animation))animationBlock flipBlock:(void(^)(BOOL rear, UIView *view))flipBlock {
    [self flipAnimationY:YES animation:animationBlock flipBlock:flipBlock];
}

- (void)flipAnimationY:(BOOL)isY animation:(void(^)(Animation *animation))animationBlock flipBlock:(void(^)(BOOL rear, UIView *view))flipBlock {
    
    self.flipBlock = flipBlock;
    Animation *animation = [Animation new];
    if (animationBlock) {
        animationBlock(animation);
    }
    self.animation = animation;
    
    CAKeyframeAnimation *flipAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform3D = CATransform3DMakeTranslation(0, 0, self.bounds.size.width / 2 + 1);
    flipAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DRotate(transform3D, 0, isY?0:1, isY?1:0, 0)],
                             [NSValue valueWithCATransform3D:CATransform3DRotate(transform3D, M_PI_2, isY?0:1, isY?1:0, 0)],
                             [NSValue valueWithCATransform3D:CATransform3DRotate(transform3D, 0, isY?0:1, isY?1:0, 0)]];
    flipAnimation.duration = animation.duration;
    flipAnimation.repeatCount = animation.repeatCount;
    flipAnimation.removedOnCompletion = NO;
    flipAnimation.fillMode = kCAFillModeBackwards;
    flipAnimation.cumulative = NO;
    flipAnimation.delegate = self;
    flipAnimation.beginTime = CACurrentMediaTime() + animation.begainTime;
    
    [self.layer addAnimation:flipAnimation forKey:@"flipAnimationKey"];
    
    CGFloat delay = animation.duration / 2.0;
    [self performSelector:@selector(changeImage) withObject:nil afterDelay:delay];
}

- (void)loadingAnimation {
    self.disallowChangeImage = YES;
    self.isLoadingView = YES;
    [self loadingFlipAnimation];
}

- (void)stopLoadingAnimation
{
     self.isLoadingView = NO;
    [self.layer removeAllAnimations];
}

- (void)loadingFlipAnimation {
    static NSInteger currentRepeatCount = 0;
    [self flipAnimationWithAnimation:^(Animation * _Nonnull animation) {
        animation.duration = 0.5;
        animation.repeatCount = 1;
        if(currentRepeatCount != 0 && currentRepeatCount % 2 == 0){
            animation.begainTime = 0.5;
        }
        currentRepeatCount ++;
    } flipBlock:^(BOOL rear, UIView * _Nonnull view) {
        
    }];
}

- (void)changeImage {
    if (self.disallowChangeImage) {
        return;
    }
    [self performSelector:@selector(changeImage) withObject:nil afterDelay:self.animation.duration];
    
    //更改图片
    if (self.flipBlock) {
        self.animation.isRear = !self.animation.isRear;
        self.flipBlock(self.animation.isRear, self);
    }
}

#pragma mark ---CAAnimationDelegate---

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (anim == [self.layer animationForKey:@"flipAnimationKey"]) {
        self.disallowChangeImage = YES;
        
        [self.layer removeAnimationForKey:@"flipAnimationKey"];
        if (self.isLoadingView) {
            [self loadingFlipAnimation];
        }
    }
}

- (BOOL)isLoadingView {
    NSNumber *number = objc_getAssociatedObject(self, &isLoadingViewKey);
    return [number boolValue];
}

- (void)setIsLoadingView:(BOOL)isLoadingView {
    NSNumber *number = [NSNumber numberWithBool: isLoadingView];
    objc_setAssociatedObject(self, &isLoadingViewKey, number , OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)disallowChangeImage {
    return objc_getAssociatedObject(self, &disallowChangeImageKey);
}

- (void)setDisallowChangeImage:(BOOL)disallowChangeImage {
    objc_setAssociatedObject(self, &disallowChangeImageKey, @(disallowChangeImage), OBJC_ASSOCIATION_ASSIGN);
}

- (Animation *)animation {
    return objc_getAssociatedObject(self, &animationKey);
}

- (void)setAnimation:(Animation *)animation {
    objc_setAssociatedObject(self, &animationKey, animation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(BOOL, UIView *))flipBlock {
    return objc_getAssociatedObject(self, &flipBlockKey);
}

-(void)setFlipBlock:(void (^)(BOOL, UIView *))flipBlock {
    objc_setAssociatedObject(self, &flipBlockKey, flipBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
