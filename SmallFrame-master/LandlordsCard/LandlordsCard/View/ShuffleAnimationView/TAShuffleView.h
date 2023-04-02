//
//  TAShuffleView.h
//  Tarot
//
//  Created by 李亚洲 on 2018/12/14.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TAShuffleViewExpansionAlignment) {
    TAShuffleViewExpansionAlignmentCenter,
    TAShuffleViewExpansionAlignmentLeft,
};

@interface TAShuffleView : UIView

@property (nonatomic, assign) NSInteger tarotCount;

/**
 扇形展开时的中心一张牌的居中方式
 */
@property (nonatomic, assign) TAShuffleViewExpansionAlignment expansionAlignment;

/**
 扇形展开时，扇形的圆弧半径
 */
@property (nonatomic, assign) CGFloat fanRadio;

/**
 每张牌之间的间隔角度
 */
@property (nonatomic, assign) CGFloat intervalAngle;

/**
 切牌时上下的移动距离
 */
@property (nonatomic, assign) CGFloat cutPadding;

/**
 牌落到底部时，牌顶距离底部的距离
 */
@property (nonatomic, assign) CGFloat bottomPadding;

@property (nonatomic, copy, nullable) void(^animationFinishedBlock)(void);

- (void)startAnimation;

@end

NS_ASSUME_NONNULL_END
