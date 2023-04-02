


//
//  FITLocalPushManger.m
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/7.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import "FITLocalPushManger.h"
#import "FITLocalPushMode.h"
#import "NSDate+JKUtilities.h"

@implementation FITLocalPushManger

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"


// 添加一个本地通知
+ (void)addLocalNotification:(UILocalNotification *)localNotification{
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

// 添加一组本地通知
+ (void)addLocalNotificationS:(NSArray <UILocalNotification *> *)localNotificationArray{
    
    [localNotificationArray enumerateObjectsUsingBlock:^(UILocalNotification * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addLocalNotification:obj];
    }];
}

// 更新一组通知的开关状态
+ (void)updateLocalNotificationSwitchState:(NSArray <UILocalNotification *> *)onNotificationArray switchState:(BOOL)switchState{
    // 打开-->关闭
    if (!switchState) {
        
        [self deleteLocalNotificationS:onNotificationArray];
    }

// 关闭-->打开
    if (switchState) {
        [self addLocalNotificationS:onNotificationArray];
    }
}

// 更新一组星期的选中状态 (废弃接口)
+ (void)updateLocalNotificationWeekState:(UILocalNotification *)localNotification state:(BOOL)selectState{
    
    if (selectState) {
        [self addLocalNotification:localNotification];
        
    }else{
        
        [self deleteLocalNotification:localNotification];
    }
}

// 更新一组触发时间
+ (void)updateLocalOldNotificationTime:(NSArray <UILocalNotification *>*)oldNotificationArray notificationArray:(NSArray <UILocalNotification *>*)notificaTionArray{
    
    [self deleteLocalNotificationS:oldNotificationArray];
    
    [self addLocalNotificationS:notificaTionArray];
}

// 移除一个本地通知
+ (void)deleteLocalNotification:(UILocalNotification *)localNotification{
    
    [[UIApplication sharedApplication]cancelLocalNotification:localNotification];
    
}

// 移除一组本地通知
+ (void)deleteLocalNotificationS:(NSArray<UILocalNotification *> *)localNotificationArray{
    
    [localNotificationArray enumerateObjectsUsingBlock:^(UILocalNotification * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [self deleteLocalNotification:obj];
    }];
}

// 移除全部本地通知
+ (void)deleteLocalNotificationAll{
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

#pragma clang diagnostic pop

@end
