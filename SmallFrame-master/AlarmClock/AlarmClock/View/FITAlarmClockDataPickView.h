//
//  FITAlarmClockDataPickView.h
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/20.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGPickerView.h"

typedef void(^SelectTimeBlcok)(NSInteger hour,NSInteger min);

@interface FITAlarmClockDataPickView : UIView


@property (nonatomic, assign) NSInteger selectHour;

@property (nonatomic, assign) NSInteger selecMin;

- (void)sethour:(NSInteger)hourInt min:(NSInteger)minInt;


@property (nonatomic, copy) SelectTimeBlcok selectTimeBlcok;


@end
