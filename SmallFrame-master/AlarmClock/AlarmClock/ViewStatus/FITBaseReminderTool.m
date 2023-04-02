

//
//  FITBaseReminderTool.m
//  fitness
//
//  Created by 郭鹏 on 2018/10/22.
//  Copyright © 2018 supergeek. All rights reserved.
//

#import "FITBaseReminderTool.h"

@implementation FITBaseReminderTool

+ (instancetype)baseReminderTool {
    
    return [[self alloc] init];
    
  
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static FITBaseReminderTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
    
}

@end
