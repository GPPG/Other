//
//  FITWorkoutReminderViewStatusMode.h
//  fitness
//
//  Created by 郭鹏 on 2018/8/31.
//  Copyright © 2018年 supergeek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FITWorkoutReminderViewStatusMode : NSObject

+ (BOOL)getReminderRedStatus;
+ (void)updateRminderRedStatus:(BOOL)firstScore;


+ (BOOL)getFirstWorkoutReminderStatus;
+ (void)updateFirstWorkoutReminderStatus:(BOOL)firstTrainFinish;

@end
