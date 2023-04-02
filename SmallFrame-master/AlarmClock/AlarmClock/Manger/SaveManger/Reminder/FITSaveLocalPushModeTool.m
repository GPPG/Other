//
//  FITSaveLocalPushModeTool.m
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/8.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import "FITSaveLocalPushModeTool.h"


#define FITPushFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"FITSaveLocalPushTotalMode.data"]


@implementation FITSaveLocalPushModeTool

+ (void)savePushMode:(FITSaveLocalPushTotalMode *)pushMode{
    
    [NSKeyedArchiver archiveRootObject:pushMode toFile:FITPushFilepath];
    
}

+ (FITSaveLocalPushTotalMode *)pushMode{
    
    FITSaveLocalPushTotalMode *pushMode = [NSKeyedUnarchiver unarchiveObjectWithFile:FITPushFilepath];
    
    return pushMode;
}



@end
