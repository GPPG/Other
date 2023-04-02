//
//  TATarotView.h
//  Tarot
//
//  Created by 李亚洲 on 2018/12/14.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TATarotView : UIView

- (instancetype)initWithFrontImageNamed:(NSString *)frontImageName realImageNamed:(NSString *)rearImageName;

@property (nonatomic, assign, getter=isFront) BOOL front;

@end

NS_ASSUME_NONNULL_END
