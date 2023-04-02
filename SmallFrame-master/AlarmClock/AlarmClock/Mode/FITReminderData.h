//
//  FITReminderData.h
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/10.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FITReminderSubData.h"

@interface FITReminderData : NSObject

@property (nonatomic, copy) NSArray <FITReminderSubData *> *totalArray;

//@[
//  @[@"12:30",@"PM",@"星期",@"开关"],
//  @[@"12:30",@"PM",@"星期",@"开关"],
//  @[@"12:30",@"PM",@"星期",@"开关"],
//  @[@"12:30",@"PM",@"星期",@"开关"],
//]

@end
