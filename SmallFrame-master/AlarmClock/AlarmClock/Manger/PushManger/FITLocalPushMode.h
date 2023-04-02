//
//  LocalLocalPushMode.h
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/7.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,Localweekday){
    LocalSunday = 1,
    LocalMonday,
    LocalTuesday,
    LocalWednesday,
    LocalThursday,
    LocalFriday,
    LocalSaturday,
};

@interface FITLocalPushMode : NSObject

@property (nonatomic, copy) NSString *localTitle;


@property (nonatomic, copy) NSString *localContent;

// 24小时制---时
@property (nonatomic, assign) NSInteger localHour;

// 24小时制---分
@property (nonatomic, assign) NSInteger localMin;

// 周一 ~~ 周日
@property (nonatomic, assign) Localweekday localweekday;

@end
