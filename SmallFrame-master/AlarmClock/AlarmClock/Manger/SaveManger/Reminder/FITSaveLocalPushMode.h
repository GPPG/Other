//
//  FITSaveLocalPushMode.h
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/8.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@class FITSaveLocalPushSubTotalMode,FITSaveLocalPushMode;

@interface FITSaveLocalPushTotalMode : NSObject<NSCoding>

@property (nonatomic, strong) NSMutableArray <FITSaveLocalPushSubTotalMode *> *alarmTotalArray;

@end

@interface FITSaveLocalPushSubTotalMode : NSObject<NSCoding>

@property (nonatomic, strong) NSMutableArray <FITSaveLocalPushMode *> *alarmSubArray;


@property (nonatomic, assign) BOOL switchState;


@end

@interface FITSaveLocalPushMode : NSObject<NSCoding>

@property (nonatomic, strong) UILocalNotification *localNotification;

@property (nonatomic, assign) BOOL localNotificationState;


@end

#pragma clang diagnostic pop
