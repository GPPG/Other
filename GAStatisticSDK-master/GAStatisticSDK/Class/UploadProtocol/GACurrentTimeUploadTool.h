//
//  GACurrentTimeUploadTool.h
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/18.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAUploadProtocol.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,UploadType){
    AbUploadType = 104,
    PayUploadType = 59,
    UserBehaviorUploadType = 101
};

@interface GACurrentTimeUploadTool : NSObject<GAUploadProtocol>

- (instancetype)initWithType:(UploadType)uploadType;

/**
 上传入口
 */
- (void)uploadMode;

/**
 保存到数据库
 */
- (void)saveMode;

/**
 从数据库获取保存的数据
 */
- (void)getModeArray;

/**
 上传d数据到服务器
 
 @param modeArray 上传的数据
 */
- (void)uploadModeArray:(NSArray *)modeArray;

/**
 删除数据库保存的数据
 
 @param modeArray 要删除的数据ID数组
 */
- (void)deleteModeArray:(NSArray *)modeArray;

/**
 上传成功后,检查是否还有遗漏的数据
 */
- (void)chekSurplusData;

@end

NS_ASSUME_NONNULL_END
