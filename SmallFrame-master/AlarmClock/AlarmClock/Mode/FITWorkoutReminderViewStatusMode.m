

//
//  FITWorkoutReminderViewStatusMode.m
//  fitness
//
//  Created by 郭鹏 on 2018/8/31.
//  Copyright © 2018年 supergeek. All rights reserved.
//

#import "FITWorkoutReminderViewStatusMode.h"

static NSString * const ReminderRedStatusID = @"ReminderRedStatusID";
static NSString * const FirstWorkoutReminderStatusID = @"FirstWorkoutReminderStatusID";


@implementation FITWorkoutReminderViewStatusMode

+ (BOOL)getReminderRedStatus{
    
    return  (BOOL) [[NSUserDefaults standardUserDefaults] boolForKey:ReminderRedStatusID];
}
+ (void)updateRminderRedStatus:(BOOL)redStatusrstScore{
    
    [[NSUserDefaults standardUserDefaults] setBool:redStatusrstScore forKey:ReminderRedStatusID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (BOOL)getFirstWorkoutReminderStatus{
    
    return  (BOOL) [[NSUserDefaults standardUserDefaults] boolForKey:FirstWorkoutReminderStatusID];
    
}

+ (void)updateFirstWorkoutReminderStatus:(BOOL)workoutReminderStatus{
    
    [[NSUserDefaults standardUserDefaults] setBool:workoutReminderStatus forKey:FirstWorkoutReminderStatusID];
    [[NSUserDefaults standardUserDefaults] synchronize];    
}

@end
