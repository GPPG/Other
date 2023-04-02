//
//  FITSaveLocalPushModeTool.h
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/8.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FITSaveLocalPushMode.h"

@interface FITSaveLocalPushModeTool : NSObject

+ (void)savePushMode:(FITSaveLocalPushTotalMode *)pushMode;

+ (FITSaveLocalPushTotalMode *)pushMode;

@end
