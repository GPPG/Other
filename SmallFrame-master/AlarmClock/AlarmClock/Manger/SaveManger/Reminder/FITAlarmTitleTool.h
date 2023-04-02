//
//  FITAlarmTitleTool.h
//  fitness
//
//  Created by 郭鹏 on 2018/8/31.
//  Copyright © 2018年 supergeek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FITAlarmTitleMode : NSObject

@property (nonatomic, copy) NSString *localTitle;

@property (nonatomic, copy) NSString *localContent;

@end


@interface FITAlarmTitleTool : NSObject

+ (FITAlarmTitleMode *)getLocalTitleMode;

@end
