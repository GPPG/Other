//
//  FITSaveLocalPushModeManger.h
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/8.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FITSaveLocalPushModeTool.h"
#import <UIKit/UIKit.h>


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"



typedef void(^AddNotificationSBlcok)(NSArray <UILocalNotification *> *localArray);

typedef void(^DeleteNotificationSBlcok)(NSArray <UILocalNotification *> *localArray);

typedef void(^DeleteNotificationAllBlcok)(void);


typedef void(^UpdateLocalNotificationSectionSwitchBlock)(NSArray <UILocalNotification *> *onLocalArray,BOOL switchState);

typedef void(^UpdateLocalNotificationWeekdaySelectBlock)(UILocalNotification *localNotification,BOOL selectState);

typedef void(^UpdateLocalNotificationStrikeTimeBlock)(NSArray <UILocalNotification *> *oldLocalArray,NSArray <UILocalNotification *> *localArray);



@interface FITSaveLocalPushModeManger : NSObject


#pragma mark - 操作
// 添加一组本地通知 (默认周一  周天开启)
- (void)addLocalNotificationS:(NSArray <UILocalNotification *>*)localArray;

// 添加一组本地通知 (自定义开启循环天数)
- (void)addLocalNotificationS:(NSArray <UILocalNotification *>*)localArray selectWeekday:(NSArray *)selectArray;

// 删除一组本地通知
- (void)deleteLocalNotificationS:(NSInteger)section;

// 删除本地全部通知
- (void)deleteLocalNotificationAll;

// 更新一组的开关状态
- (void)updateLocalNotificationSwitchStateSection:(NSInteger )index switchState:(BOOL)switchState;

// 更新一组触发时间和选择循环
- (void)updateLocalNotificationStrikeTime:(NSInteger)section hour:(NSInteger)hour min:(NSInteger)min selectStateArray:(NSArray *)selectArray;

// 返回本地全部的通知
- (NSArray <UILocalNotification *>*)getSaveTotalLocalNOtification;



/***********************************************************************************************************************/
// 更新一组星期选中的状态 (废弃接口)
- (void)updateLocalNotificationWeekdaySwitchState:(NSIndexPath *)indexPath localNotificationState:(BOOL)localNotificationState;

#pragma mark - 回调

/**
 保存一组通知回调
 */
@property (nonatomic, copy) AddNotificationSBlcok addNotificationSBlcok;

/**
 删除一组通知的回调
 */
@property (nonatomic, copy) DeleteNotificationSBlcok deleteNotificationSBlcok;

/**
 删除全部通知
 */
@property (nonatomic, copy) DeleteNotificationAllBlcok deleteNotificationAllBlcok;

/**
 更新一组开关状态回调
 */
@property (nonatomic, copy) UpdateLocalNotificationSectionSwitchBlock updateLocalNotificationSectionSwitchBlock;

/**
 更新选中星期状态回调
 */
@property (nonatomic, copy) UpdateLocalNotificationWeekdaySelectBlock updateLocalNotificationWeekdaySelectBlock;

/**
 更新一组触发时间和循环
 */
@property (nonatomic, copy) UpdateLocalNotificationStrikeTimeBlock updateLocalNotificationStrikeTimeBlock;


#pragma clang diagnostic pop

@end
