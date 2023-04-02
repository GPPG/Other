
//
//  FITLocalNotificationTool.m
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/8.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import "FITLocalNotificationTool.h"
#import "FITLocalPushMode.h"
#import "NSDate+JKUtilities.h"

@implementation FITLocalNotificationTool

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

+ (UILocalNotification *)creationLocalLocalNotifiction:(FITLocalPushMode *)localPushMode{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *componentsForFireDate = [calendar components:(NSYearCalendarUnit | NSWeekCalendarUnit|  NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit | NSWeekdayCalendarUnit) fromDate: now];
    
    [componentsForFireDate setWeekday: localPushMode.localweekday];
    [componentsForFireDate setHour: localPushMode.localHour];
    [componentsForFireDate setMinute: localPushMode.localMin];
    [componentsForFireDate setSecond: 0];
    
    NSDate *fireDateOfNotification = [calendar dateFromComponents: componentsForFireDate];
    
    UILocalNotification *notification = [[UILocalNotification alloc]  init] ;
    notification.fireDate = fireDateOfNotification ;
    notification.timeZone = [NSTimeZone localTimeZone] ;
    notification.alertBody = localPushMode.localContent;
    if (@available(iOS 8.2, *)) {
        notification.alertTitle = localPushMode.localTitle;
    }
    notification.repeatInterval= NSWeekCalendarUnit ;
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = 1;
    
    return notification;
}

+ (NSArray <UILocalNotification *> *)creationLocalLocalNotifictionS:(NSArray <FITLocalPushMode *> *)pushmodeArray{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    
    [pushmodeArray enumerateObjectsUsingBlock:^(FITLocalPushMode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILocalNotification *localNotification = [self creationLocalLocalNotifiction:obj];
        
        [tempArray addObject:localNotification];
    }];
    
    return [tempArray copy];
}


#pragma clang diagnostic pop

@end
