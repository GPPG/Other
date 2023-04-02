//
//  GAStatistics.h
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GAStatistics : NSObject
    
+ (instancetype)sharedInstance;

    
/**
 统计SDK初始化方法
 @param productNum 项目名称
 @param productPublicKey 产品公钥
 @param appleId APPID
 @param abtestId ABTest ID
 @param channelId 渠道号ID
 @param afDevkey APPFlyer devkey
 @param isLogEnable 运行日志打印
 */
- (void)initSdk:(NSString *)productNum productPublicKey:(NSString *)productPublicKey appleId:(NSString *)appleId abtestId:(NSString *)abtestId channelId:(int)channelId afDevKey:(nonnull NSString *)afDevkey isLogEnable:(BOOL)isLogEnable;

    
/**
 需要在appdelegate的- (void)applicationDidBecomeActive:(UIApplication *)application里调用一下
*/
- (void)ga_spApplicationDidBecomeActive;
    
    
    


@end

NS_ASSUME_NONNULL_END
