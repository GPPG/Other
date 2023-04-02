//
//  SPTimeUtil.h
//  StatisticSdk
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GATimeTool : NSObject

+ (NSString *)ga_getNowTimeTimestamp;
+ (NSString *)ga_getNowTimeWithFormat;

+ (BOOL)ga_isCurrentTimeLargeThan8Hour:(double)time;

@end

NS_ASSUME_NONNULL_END
