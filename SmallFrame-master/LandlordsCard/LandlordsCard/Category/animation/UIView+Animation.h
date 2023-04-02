//
//  UIView+Animation.h
//  UIDynamicDemo
//
//  Created by 李亚洲 on 2018/12/18.
//  Copyright © 2018 李亚洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animation.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Animation)

- (void)flipAnimationWithAnimation:(void(^ __nullable)(Animation *animation))animationBlock flipBlock:(void(^ __nullable)(BOOL rear, UIView *view))flipBlock;
- (void)flipAnimationY:(BOOL)isY animation:(void(^)(Animation *animation))animationBlock flipBlock:(void(^)(BOOL rear, UIView *view))flipBlock;

+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration repeatCount:(NSInteger)repeatCount options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL))completion;

-(void)loadingAnimation;
-(void)stopLoadingAnimation;
@end

NS_ASSUME_NONNULL_END
