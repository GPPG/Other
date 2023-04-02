//
//  GPFlighData.h
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/4/5.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPFlighData : NSObject
@property (nonatomic, copy) NSString *summaryStr;
@property (nonatomic, copy) NSString *flightNrStr;
@property (nonatomic, copy) NSString *gateNrStr;
@property (nonatomic, copy) NSString *departingFromStr;
@property (nonatomic, copy) NSString *arrivingToStr;
@property (nonatomic, copy) NSString *weatherImageNameStr;

@property (nonatomic, assign,getter = isShowWeatherEffects) BOOL showWeatherEffects;
@property (nonatomic, assign,getter = isTakingOff) BOOL TakingOff;
@property (nonatomic, copy) NSString *flightStatusStr;

- (instancetype)initWithIsBeiJing:(BOOL)IsBeiJing;
@end
