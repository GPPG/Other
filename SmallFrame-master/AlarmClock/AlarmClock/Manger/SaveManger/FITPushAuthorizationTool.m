
//
//  FITPushAuthorizationTool.m
//  fitness
//
//  Created by 郭鹏 on 2018/9/5.
//  Copyright © 2018年 supergeek. All rights reserved.
//

#import "FITPushAuthorizationTool.h"
#import "FITWorkoutReminderViewStatusMode.h"
#import "FITSetDefaultAlarmTool.h"

@interface FITPushAuthorizationTool()

@property (nonatomic, copy) RegisterPushSuccessfulBlock registerPushSuccessfulBlock;

@property (nonatomic, copy) RegisterPushFailureBlock registerPushFailureBlock;

@property (nonatomic, copy) RegisterPushBlock registerPushBlock;

@property (nonatomic, strong) FITSetDefaultAlarmTool *alarmTool;

@end




@implementation FITPushAuthorizationTool

- (instancetype)init{
    if (self = [super init]) {
        
        [self addNotion];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)acquirePushAuthorizationStatus:(RegisterPushBlock)registerPushBlock{
    
    self.registerPushBlock = registerPushBlock;
    [self acquirePushAuthorizationStatus];

    
}

-(void)acquirePushAuthorizationStatus:(RegisterPushSuccessfulBlock)registerPushSuccessfulBlock registerPushFailureBlock:(RegisterPushFailureBlock)registerPushFailureBlock{
    
    self.registerPushFailureBlock = registerPushFailureBlock;
    self.registerPushSuccessfulBlock = registerPushSuccessfulBlock;
    [self acquirePushAuthorizationStatus];
    
}

- (void)acquirePushAuthorizationStatus{
    
    [self requestAuthor];
}

- (void)addNotion{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerUserNotificationSuccessful) name:FITRegisterUserNotificationSettingsSuccessful object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerUserNotificationFailure) name:FITRegisterUserNotificationSettingsFailure object:nil];
}

- (void)registerUserNotificationSuccessful{
    
    dispatch_async(dispatch_get_main_queue(), ^{

        if (self.registerPushBlock) {
            self.registerPushBlock();
        }
        
        if (self.registerPushSuccessfulBlock) {
            self.registerPushSuccessfulBlock();
        }
        
    });
}

- (void)registerUserNotificationFailure{
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        if (self.registerPushBlock) {
            self.registerPushBlock();
        }
        
        if (self.registerPushFailureBlock) {
            self.registerPushFailureBlock();
        }
        
    });
}

- (void)requestAuthor{
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        // 设置通知的类型可以为弹窗提示,声音提示,应用图标数字提示
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        // 授权通知
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}


- (void)showAlterAuthorizaView:(AlterBlock)AlterBlock{
    
    RIButtonItem *openlItem = [RIButtonItem itemWithLabel:NSLocalizedString(@"Open Settings",nil) action:^{
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
            AlterBlock();
        }
    }];
    
    RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:NSLocalizedString(@"Cancel",nil) action:^{
        AlterBlock();
    }];

    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:NSLocalizedString(@"KeepFit does not have access to your notifications.Please go to Settings -> Notifications and enable access to KeepFit.",nil)
                                               cancelButtonItem:cancelItem
                                               otherButtonItems:openlItem,nil];
    [alertView show];

}


- (FITSetDefaultAlarmTool *)alarmTool
{
    if (!_alarmTool) {
        _alarmTool = [[FITSetDefaultAlarmTool alloc]init];
    }
    return _alarmTool;
}



@end
