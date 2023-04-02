//
//  FITReminderData.m
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/10.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import "FITReminderData.h"
#import "FITSaveLocalPushModeTool.h"

@interface FITReminderData()

@property (nonatomic, strong) NSDictionary *weekdayStrDic;

//@[
//  @[@"12:30",@"PM",@"星期",@"开关"],
//  @[@"12:30",@"PM",@"星期",@"开关"],
//  @[@"12:30",@"PM",@"星期",@"开关"],
//  @[@"12:30",@"PM",@"星期",@"开关"],
//]

@end


@implementation FITReminderData


- (NSArray *)totalArray{
    
  FITSaveLocalPushTotalMode *pushMode = [FITSaveLocalPushModeTool pushMode];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [pushMode.alarmTotalArray enumerateObjectsUsingBlock:^(FITSaveLocalPushSubTotalMode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        FITReminderSubData *subData = [[FITReminderSubData alloc]init];
        subData.switchState = obj.switchState;
        subData.strikeDate =  obj.alarmSubArray.firstObject.localNotification.fireDate;
        subData.rowInt = idx;
        
        NSInteger hourInt = obj.alarmSubArray.firstObject.localNotification.fireDate.jk_hour;
        NSInteger minInt = obj.alarmSubArray.firstObject.localNotification.fireDate.jk_minute;

        if (hourInt > 12 || hourInt == 0) {
            subData.timeUnitStr = NSLocalizedString(@"PM", nil);
        }else{
            subData.timeUnitStr = NSLocalizedString(@"AM", nil);
        }

        if (hourInt > 12) {
            hourInt = hourInt - 12;
        }
        
        if (hourInt == 0) {
            hourInt = hourInt + 12;
        }
        
        
        NSString *timeStr;
        if (minInt < 10) {
            timeStr = [NSString stringWithFormat:@"%ld:0%ld",(long)hourInt,(long)minInt];
        }else{
            timeStr = [NSString stringWithFormat:@"%ld:%ld",(long)hourInt,(long)minInt];
        }
        subData.timeStr = timeStr;
        
        
        NSMutableArray *weekdayStrArray = [NSMutableArray array];
        
        NSMutableArray *weekdayStateArray = [NSMutableArray array];

        [obj.alarmSubArray enumerateObjectsUsingBlock:^(FITSaveLocalPushMode * _Nonnull localPushMode, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if (localPushMode.localNotificationState) {
                NSString *keyStr = [NSString stringWithFormat:@"%ld",localPushMode.localNotification.fireDate.jk_weekday];
                [weekdayStrArray addObject:self.weekdayStrDic[keyStr]];
                [weekdayStateArray addObject:@"1"];
            }else{
                [weekdayStateArray addObject:@"0"];
            }
        }];
        
        subData.weekdayArray = [weekdayStrArray copy];
        subData.allWeekdayStateArray = [weekdayStateArray copy];
        
        [tempArray addObject:subData];
    }];
    return [tempArray copy];
}

- (NSDictionary *)weekdayStrDic
{
    if (!_weekdayStrDic) {
        _weekdayStrDic =  @{
                            @"1" : NSLocalizedString(@"Su",nil),
                            @"2" : NSLocalizedString(@"Mo",nil),
                            @"3" : NSLocalizedString(@"Tu",nil),
                            @"4" : NSLocalizedString(@"We",nil),
                            @"5" : NSLocalizedString(@"Th",nil),
                            @"6" : NSLocalizedString(@"Fr",nil),
                            @"7" : NSLocalizedString(@"Sa",nil),
                            };
    }
    return _weekdayStrDic;
}





@end
