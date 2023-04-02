//
//  FITReminderSubData.h
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/10.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FITReminderSubData : NSObject

@property (nonatomic, copy) NSString *timeStr;

@property (nonatomic, copy) NSString *timeUnitStr;

@property (nonatomic, assign) BOOL switchState;

// 显示星期内容 @[@"su",@"Mo"];
@property (nonatomic, strong) NSArray *weekdayArray;

// 所有星期循环 @[@"1",@"1","1",@"1","1",@"1","1"]
@property (nonatomic, strong) NSArray *allWeekdayStateArray;

@property (nonatomic, strong) NSDate *strikeDate;

@property (nonatomic, assign) NSInteger rowInt;

@end
