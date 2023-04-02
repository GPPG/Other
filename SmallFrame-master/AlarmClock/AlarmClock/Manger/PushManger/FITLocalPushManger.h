//
//  FITLocalPushManger.h
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/7.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FITLocalPushMode;

@interface FITLocalPushManger : NSObject

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"


// 添加一个本地通知
+ (void)addLocalNotification:(UILocalNotification *)localNotification;

// 添加一组本地通知 
+ (void)addLocalNotificationS:(NSArray <UILocalNotification *> *)localNotificationArray;

// 删除一个本地通知
+ (void)deleteLocalNotification:(UILocalNotification *)localNotification;

// 删除一组本地通知
+ (void)deleteLocalNotificationS:(NSArray <UILocalNotification *> *)localNotificationArray;

// 删除全部本地通知
+ (void)deleteLocalNotificationAll;

// 更新一组开关状态
+ (void)updateLocalNotificationSwitchState:(NSArray <UILocalNotification *> *)onNotificationArray switchState:(BOOL)switchState;

// 更新一组本地推送(时间和循环)
+ (void)updateLocalOldNotificationTime:(NSArray <UILocalNotification *>*)oldNotificationArray notificationArray:(NSArray <UILocalNotification *>*)notificaTionArray;


/***********************************************************************************************************************/
// 更新星期状态 (废弃接口)
+ (void)updateLocalNotificationWeekState:(UILocalNotification *)localNotification state:(BOOL)selectState;


#pragma clang diagnostic pop

@end
