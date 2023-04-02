//
//  FITLocalNotificationTool.h
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/8.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class FITLocalPushMode;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"


@interface FITLocalNotificationTool : NSObject

+ (NSArray <UILocalNotification *> *)creationLocalLocalNotifictionS:(NSArray <FITLocalPushMode *> *)pushmodeArray;

+ (UILocalNotification *)creationLocalLocalNotifiction:(FITLocalPushMode *)localPushMode;

#pragma clang diagnostic pop


@end
