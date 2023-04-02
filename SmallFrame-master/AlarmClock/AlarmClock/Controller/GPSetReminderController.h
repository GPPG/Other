//
//  GPSetReminderController.h
//  AlarmClock
//
//  Created by 郭鹏 on 2019/12/23.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FITSaveLocalPushModeManger.h"
#import "FITReminderSubData.h"


NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,SetReminderType){
    setRemindAddType = 0,
    setRemindUpdateType
};

typedef void(^CancelActionBlock)(void);

typedef void(^SaveActionBlock)(void);


@interface GPSetReminderController : UIViewController

@property (nonatomic, assign) SetReminderType setReminderType;

@property (nonatomic, copy) SaveActionBlock saveActionBlock;

@property (nonatomic, copy) CancelActionBlock cancelActionBlock;

@property (nonatomic, strong) FITSaveLocalPushModeManger *savePushManger;

@property (nonatomic, strong) FITReminderSubData *reminderSubData;


@end

NS_ASSUME_NONNULL_END
