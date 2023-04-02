//
//  FITReminderCell.h
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/10.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FITReminderSubData.h"

typedef void(^SwitchActionBlock)(BOOL switchState);

@interface FITReminderCell : UITableViewCell

@property (nonatomic, strong) FITReminderSubData *reminderSubData;

@property (nonatomic, copy) SwitchActionBlock switchActionBlock;


@end
