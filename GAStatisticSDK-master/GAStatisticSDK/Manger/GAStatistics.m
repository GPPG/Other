//
//  GAStatistics.m
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//
#import "GAStatistics.h"
#import "GAInitDataMode.h"
#import "GAStatisticsUploadManger.h"
#import <UIKit/UIKit.h>
#import "GANetworkMeterManger.h"
#import "GAStatisticsUploadManger.h"

static GAStatistics *instance;

@interface GAStatistics()

@property(nonatomic, assign)BOOL isFirstTime;

    
@end


@implementation GAStatistics
    
#pragma mark - init
    
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)initSdk:(NSString *)productNum productPublicKey:(NSString *)productPublicKey appleId:(NSString *)appleId abtestId:(NSString *)abtestId channelId:(int)channelId afDevKey:(NSString *)afDevkey isLogEnable:(BOOL)isLogEnable{
    
    GAInitDataMode *model = [GAInitDataMode sharedManager];
    model.productNum = productNum;
    model.productPublicKey = productPublicKey;
    model.appleId = appleId;
    model.abtestId = abtestId;
    model.channelId = channelId;
    model.devKey = afDevkey;
    model.isLogEnable = isLogEnable;
    
    [self setupSDK];
}
    
#pragma mark - set up
- (void)setupSDK{
    self.isFirstTime = YES;
    [self addObserver];
}


- (void)chekSurplusData{
    
    [[GAStatisticsUploadManger sharedInstance] check101];
    
    [[GAStatisticsUploadManger sharedInstance] check104];

}
    
#pragma mark - Notification
- (void)addObserver {
    //监听是否重新进入程序程序.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnter) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    //监听是否触发home键挂起程序.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appOut) name:UIApplicationWillResignActiveNotification object:nil];
    
    //监听应用被杀死
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
    
    //监听网络变化
    [[GANetworkMeterManger sharedManager] ga_addNetworkChangeObserver:^(BOOL canUse) {
        GALog(@"网络变化");
        if (canUse && !self.isFirstTime) {
            [self chekSurplusData];
        }
    }];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
     
    [[GANetworkMeterManger sharedManager] ga_removeNetworkChangeObserver];
}



#pragma mark - Notification Action

- (void)appEnter {
    GALog(@"程序进入");
    if (!self.isFirstTime) {
        [self chekSurplusData];
    }
    self.isFirstTime = NO;
}

- (void)appOut {

    GALog(@"程序退出");
}

// 应用被杀死的回调
- (void)appWillTerminate:(UIApplication *)application {
    [self removeObserver];
    GALog(@"程序被杀死");
}


#pragma mark - Public Method
- (void)ga_spApplicationDidBecomeActive {
    
    
}

    
    
    
@end
