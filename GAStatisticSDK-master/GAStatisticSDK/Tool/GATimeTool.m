//
//  SPTimeUtil.m
//  StatisticSdk
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.

//

#import "GATimeTool.h"

@implementation GATimeTool

+ (NSString *)ga_getNowTimeTimestamp {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval currentTime=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", currentTime];

    return timeString;
}

+ (NSString *)ga_getNowTimeWithFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8 * 3600]];
    
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];

    return currentTimeString;
}

+ (BOOL)ga_isCurrentTimeLargeThan8Hour:(double)time {
    double currentTime = [[NSDate date] timeIntervalSince1970];
    return (currentTime - time >= 8 * 60 * 60);
}

@end
