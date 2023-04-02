//
//  GAInitDataMode.h
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GAInitDataMode : NSObject
    
@property(strong, nonatomic)NSString *productNum; // 项目的代号
    
@property(strong, nonatomic)NSString *productPublicKey; // 产品公钥
    
@property(strong, nonatomic)NSString *appleId; // AppleId
    
@property(strong, nonatomic)NSString *abtestId; // ABTest ID
    
@property(assign, nonatomic)int channelId; // 渠道号ID
    
@property (nonatomic, copy) NSString *devKey; //appFlyer devKey
    
@property(assign, nonatomic)BOOL isLogEnable; // 运行日志打印
    
+ (instancetype)sharedManager;
    
@end

NS_ASSUME_NONNULL_END
