
//
//  FITRemindViewStatus.m
//  fitness
//
//  Created by 郭鹏 on 2018/10/10.
//  Copyright © 2018 supergeek. All rights reserved.
//

#import "FITRemindViewStatus.h"

static NSString * const ReminderSwitchStatusID = @"ReminderSwitchStatusID";
static NSString * const ReminderShowStatusID = @"ReminderShowStatusID";


@implementation FITRemindViewStatus

+ (BOOL)getReminderSwitchStatus{
    
    return  (BOOL) [[NSUserDefaults standardUserDefaults] boolForKey:ReminderSwitchStatusID];
}

+ (void)updateRminderSwitchStatus:(BOOL)switchStatus{
    [[NSUserDefaults standardUserDefaults] setBool:switchStatus forKey:ReminderSwitchStatusID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (BOOL)getReminderShowStatus{
    return  (BOOL) [[NSUserDefaults standardUserDefaults] boolForKey:ReminderShowStatusID];
}

+ (void)updateRminderShowStatus:(BOOL)showStatus{
    [[NSUserDefaults standardUserDefaults] setBool:showStatus forKey:ReminderShowStatusID];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

@end
