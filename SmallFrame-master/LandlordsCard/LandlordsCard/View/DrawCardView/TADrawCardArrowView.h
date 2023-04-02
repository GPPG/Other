//
//  TADrawCardArrowView.h
//  Tarot
//
//  Created by 郭鹏 on 2018/12/20.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TADrawCardArrowView : UIView

- (void)startLineAnimation;

- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radiusValue;


@end

NS_ASSUME_NONNULL_END
