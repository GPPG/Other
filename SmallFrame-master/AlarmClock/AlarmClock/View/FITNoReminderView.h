//
//  FITNoReminderView.h
//  fitness
//
//  Created by 郭鹏 on 2018/8/13.
//  Copyright © 2018年 supergeek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SetReminderBlock)(void);

@interface FITNoReminderView : UIView

@property (nonatomic, copy) SetReminderBlock setReminderBlock;

@end
