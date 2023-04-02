//
//  GABasicDataModel.h
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/17.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GABasicDataModel : NSObject

// 项目的代号
@property(strong, nonatomic)NSString *productNum;
// 产品公钥
@property(strong, nonatomic)NSString *productPublicKey;
// AppleId
@property(strong, nonatomic)NSString *appleId;
// ABTest ID
@property(strong, nonatomic)NSString *abtestId;
// 渠道号ID
@property(assign, nonatomic)int channelId;
//appFlyer devKey
@property (nonatomic, copy) NSString *devKey;
// 运行日志打印
@property(assign, nonatomic)BOOL isLogEnable;


+ (instancetype)sharedManager;

#pragma mark - Unavailable Method
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (id)copy NS_UNAVAILABLE;
- (id)mutableCopy NS_UNAVAILABLE;

@end

