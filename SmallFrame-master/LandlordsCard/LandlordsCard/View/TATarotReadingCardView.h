//
//  TATarotReadingCardView.h
//  Tarot
//
//  Created by 郭鹏 on 2019/1/2.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TATarotReading.h"


NS_ASSUME_NONNULL_BEGIN


@interface TATarotReadingCardView : UIView


@property (nonatomic, assign) CGSize tempSize;

@property (nonatomic, strong) UIImageView *bgImageView;

- (instancetype)initWithCardStatus:(CardStatus)cardStatus;

- (void)updateCardStatus:(CardStatus)cardStatus;

- (void)setup;





@end

NS_ASSUME_NONNULL_END
