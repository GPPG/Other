//
//  GANetworkMeterManger.m
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GANetworkMeterManger.h"
#import "Reachability.h"


static GANetworkMeterManger *instance;

@interface GANetworkMeterManger()

@property(strong, nonatomic)Reachability *routerReachability;
@property(strong, nonatomic)Reachability *hostReachability;
@property(strong, nonatomic)GANetworkChangeBlock networkChangeBlock;
@end



@implementation GANetworkMeterManger
    
    
+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
    
#pragma mark - public Method
- (void)ga_addNetworkChangeObserver:(GANetworkChangeBlock)block{
    
    self.networkChangeBlock = block;
    
    //监听网络变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange:) name:kReachabilityChangedNotification object:nil];
    
    [self.hostReachability startNotifier];
    [self.routerReachability startNotifier];

}
    
    
- (void)ga_removeNetworkChangeObserver{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    
    [self.hostReachability stopNotifier];
    [self.routerReachability stopNotifier];
}
    
    
#pragma mark - Private Method
    // 网络状态监听
- (void)networkChange:(NSNotification *)notification {
    Reachability *reach = [notification object];
    if([reach isKindOfClass:[Reachability class]]){
        NetworkStatus status = [reach currentReachabilityStatus];
        // 两种检测:路由与服务器是否可达  三种状态:手机流量联网、WiFi联网、没有联网
        if (reach == self.routerReachability || reach == self.hostReachability) {
            if (status == ReachableViaWiFi) {
                if (self.networkChangeBlock != nil) {
                    self.networkChangeBlock(YES);
                }
            } else if (status == ReachableViaWWAN) {
                if (self.networkChangeBlock != nil) {
                    self.networkChangeBlock(YES);
                }
            } else {
                if (self.networkChangeBlock != nil) {
                    self.networkChangeBlock(NO);
                }
            }
        }
    }
}

#pragma mark - lazy
    
- (Reachability *)routerReachability {
    if (_routerReachability == nil) {
        _routerReachability = [Reachability reachabilityWithHostName:@"https://topdata.do4health.com"];
    }
    
    return _routerReachability;
}
    
- (Reachability *)hostReachability {
    if (_hostReachability == nil) {
        _hostReachability = [Reachability reachabilityForInternetConnection];
    }
    
    return _hostReachability;
}

    
    
    
@end
