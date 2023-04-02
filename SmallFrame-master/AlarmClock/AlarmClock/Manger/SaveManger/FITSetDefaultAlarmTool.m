//
//  FITSetDefaultAlarmTool.m
//  fitness
//
//  Created by 郭鹏 on 2018/9/4.
//  Copyright © 2018年 supergeek. All rights reserved.
//

#import "FITSetDefaultAlarmTool.h"
#import "FITLocalPushMode.h"
#import "FITAlarmTitleTool.h"
#import "FITLocalNotificationTool.h"
#import "FITSaveLocalPushModeManger.h"
#import "FITLocalPushManger.h"
#import "FITWorkoutReminderViewStatusMode.h"

@interface FITSetDefaultAlarmTool()

@property (nonatomic, strong) FITSaveLocalPushModeManger *savePushManger;

@end

@implementation FITSetDefaultAlarmTool


- (instancetype)init{
    
    if (self = [super init]) {
        
        [self addNotion];
        [self updateUI];
        
    }
    return self;
}

- (void)dealloc{
    NSLog(@"销毁FITSetDefaultAlarmTool");
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)updateUI{
    
    WS(ws);
    self.savePushManger.addNotificationSBlcok = ^(NSArray<UILocalNotification *> *localArray) {
        
        [FITLocalPushManger addLocalNotificationS:localArray];
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:FITFITWorkoutReminderControllerDismiss object:nil];
        
        [[NSNotificationCenter defaultCenter]removeObserver:ws];

    };
}

- (void)addDefaultLocalNotification{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 1; i <= 7; i ++) {
        
        FITLocalPushMode *pushMode = [[FITLocalPushMode alloc]init];
        FITAlarmTitleMode *mode = [FITAlarmTitleTool getLocalTitleMode];
        pushMode.localTitle = mode.localTitle;
        pushMode.localContent = mode.localContent;
        pushMode.localweekday = i;
        pushMode.localHour = 19;
        pushMode.localMin = 0;;
        [tempArray addObject:pushMode];
    }
    NSArray *array =  [FITLocalNotificationTool creationLocalLocalNotifictionS:tempArray];
    [self.savePushManger addLocalNotificationS:array];
}


#pragma mark - public

- (void)requestAuthor{
    
    [FITWorkoutReminderViewStatusMode updateFirstWorkoutReminderStatus:YES];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {

        // 设置通知的类型可以为弹窗提示,声音提示,应用图标数字提示
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        // 授权通知
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}

#pragma mark - 通知
- (void)addNotion{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerUserNotificationSuccessful) name:FITRegisterUserNotificationSettingsSuccessful object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerUserNotificationFailure) name:FITRegisterUserNotificationSettingsFailure object:nil];
}

- (void)registerUserNotificationSuccessful{
    
    [FITWorkoutReminderViewStatusMode updateRminderRedStatus:YES];
    
    [self addDefaultLocalNotification];

}

- (void)registerUserNotificationFailure{
    [self addDefaultLocalNotification];
}

#pragma mark - lazy
- (FITSaveLocalPushModeManger *)savePushManger
{
    if (!_savePushManger) {
        _savePushManger = [[FITSaveLocalPushModeManger alloc]init];
    }
    return _savePushManger;
}



@end
