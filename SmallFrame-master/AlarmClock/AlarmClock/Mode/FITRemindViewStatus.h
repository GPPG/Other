//
//  FITRemindViewStatus.h
//  fitness
//
//  Created by 郭鹏 on 2018/10/10.
//  Copyright © 2018 supergeek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FITRemindViewStatus : NSObject

+ (BOOL)getReminderSwitchStatus;


+ (void)updateRminderSwitchStatus:(BOOL)switchStatus;


+ (BOOL)getReminderShowStatus;


+ (void)updateRminderShowStatus:(BOOL)showStatus;

@end
