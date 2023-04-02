
//
//  FITAlarmTitleTool.m
//  fitness
//
//  Created by 郭鹏 on 2018/8/31.
//  Copyright © 2018年 supergeek. All rights reserved.
//

#import "FITAlarmTitleTool.h"


@implementation FITAlarmTitleMode



@end



@interface FITAlarmTitleTool()

@property (nonatomic, strong) NSArray *modeArray;

@end

@implementation FITAlarmTitleTool

+ (FITAlarmTitleMode *)getLocalTitleMode{
    
    FITAlarmTitleMode *mode = [self getRandomNumber];
    
    return mode;
}

+ (FITAlarmTitleMode *)getRandomNumber
{
   return [self modeArray][arc4random() % 3];
}

+ (NSArray<FITAlarmTitleMode *> *)modeArray
{
        FITAlarmTitleMode *mode0 = [[FITAlarmTitleMode alloc]init];
        mode0.localTitle = NSLocalizedString(@"Workout Now For Perfect Body",nil);
        mode0.localContent = NSLocalizedString(@"Do something",nil);
        
        FITAlarmTitleMode *mode1 = [[FITAlarmTitleMode alloc]init];
        mode1.localTitle = NSLocalizedString(@"Don't Stop",nil);
        mode1.localContent = NSLocalizedString(@"Your body",nil);
        
        FITAlarmTitleMode *mode2 = [[FITAlarmTitleMode alloc]init];
        mode2.localTitle = @"";
        mode2.localContent = NSLocalizedString(@"Its challenge day",nil);
    
      NSArray *modeArray = @[
                       mode0,
                       mode1,
                       mode2
                       ];
    return modeArray;
}

@end
