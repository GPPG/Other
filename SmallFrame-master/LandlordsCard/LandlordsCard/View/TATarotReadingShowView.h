//
//  TATarotReadingShowView.h
//  Tarot
//
//  Created by 郭鹏 on 2018/12/29.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TATarotReadingDrawMode.h"
#import "TATarotReadingCardView.h"

@class TATarReadingDrawContentMode;
NS_ASSUME_NONNULL_BEGIN

@interface TATarotReadingShowView : UIView

@property (nonatomic, strong) TATarotReadingDrawMode *readingDrawMode;

@property (nonatomic, strong) UIBezierPath *drawPath;

- (void)updateReadingViewStatus:(NSArray *)cardStatusArray;

- (void)overturnShowCard;

- (void)ShowCard;


@property (nonatomic, strong) TATarReadingDrawContentMode *cardContentMode;


@end

NS_ASSUME_NONNULL_END
