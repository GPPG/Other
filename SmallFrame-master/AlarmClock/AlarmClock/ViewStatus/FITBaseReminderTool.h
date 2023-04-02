//
//  FITBaseReminderTool.h
//  fitness
//
//  Created by 郭鹏 on 2018/10/22.
//  Copyright © 2018 supergeek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FITBaseReminderTool : NSObject

@property (nonatomic, copy) NSString *trainingReminderStatus;

@property (nonatomic, assign) BOOL selectTraingSwitch;

+ (instancetype)baseReminderTool;

@end
