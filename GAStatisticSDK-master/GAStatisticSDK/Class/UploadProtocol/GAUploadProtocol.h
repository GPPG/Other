//
//  GAUploadProtocol.h
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/18.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#ifndef GAUploadProtocol_h
#define GAUploadProtocol_h

#import <Foundation/Foundation.h>


@protocol GAUploadProtocol <NSObject>
@optional

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

#endif /* GAUploadProtocol_h */
