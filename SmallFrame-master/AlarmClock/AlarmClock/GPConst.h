//
//  GPConst.h
//  AlarmClock
//
//  Created by 郭鹏 on 2019/12/24.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPConst : NSObject
//通知的key
UIKIT_EXTERN NSString *const kTrainGoalCardDismissNotification;
UIKIT_EXTERN NSString *const kNeedRefreshRecommendNotification;
UIKIT_EXTERN NSString *const kNeedRefreshAllDataNotification;
UIKIT_EXTERN NSString *const kCourseFinishNotification;
UIKIT_EXTERN NSString *const kCourseDownloadNotification;
UIKIT_EXTERN NSString *const kFITPayGuideControllerClose;
UIKIT_EXTERN NSString *const FITRegisterUserNotificationSettingsSuccessful;
UIKIT_EXTERN NSString *const FITRegisterUserNotificationSettingsFailure;

UIKIT_EXTERN NSString *const FITFITWorkoutReminderControllerDismiss;

@end

NS_ASSUME_NONNULL_END
