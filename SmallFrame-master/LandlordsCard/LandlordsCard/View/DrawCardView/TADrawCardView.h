//
//  TADrawCardView.h
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/19.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TADrawLocationMode.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^DrawCardSucceedBlock)(NSInteger moveLocationIndex,BOOL finishDraw);

typedef void(^DrawCardFinishBlock)(NSArray *finishSelectArray);

typedef void(^DrawCardStartBlock)(NSInteger moveLocationIndex,NSInteger drawCardIndex);

@interface TADrawCardView : UIView

// 移动指定位置回调
@property (nonatomic, copy) DrawCardSucceedBlock drawCardSucceedBlock;

@property (nonatomic, copy) DrawCardFinishBlock drawCardFinishBlock;

// 选牌开始回调
@property (nonatomic, copy) DrawCardStartBlock drawCardStartBlock;

@property (nonatomic, strong) NSArray <TADrawLocationMode *> *goalLocationArray;
// 放大缩小倍数
@property (nonatomic, assign) CGFloat scaleValue;

@property (nonatomic, strong) UIColor *bgColor;

@end

NS_ASSUME_NONNULL_END
