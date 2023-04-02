//
//  SPDeviceInfo.h
//  StatisticSdk
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.

//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GADeviceInfoTool : NSObject


/**
 获取uuid值

 @return uuid
 */
+ (NSString *)ga_UUIDStr;

/**
 获取idfa

 @return idfa
 */
+ (NSString *)ga_IDFAStr;

/**
 系统类型和版本号

 @return 系统类型和版本号
 */
+ (NSString *)ga_systemVersion;

/**
 @return 手机rom信息
 */
+ (NSString *)ga_romInfo;

/**
 获取SIM卡里的国家代码，无SIM卡时，取手机系统语言里的国家代码，如:CN(全部小写)

 @return 国家代码
 */
+ (NSString *)ga_countryCode;

/**
 @return 语言代码
 */
+ (NSString *)ga_language;

/**
 @return app的build值
 */
+ (NSString *)ga_versionCode;

/**
 @return app的版本号
 */
+ (NSString *)ga_versionName;

/**
 设备类型。1:手机,2:平板

 @return 设备类型值
 */
+ (int)ga_phoneType;

/**
 获取手机对应的具体型号

 @return 手机型号字符串
 */
+ (NSString *)ga_deviceTypeStr;
@end

NS_ASSUME_NONNULL_END
