//
//  GPMicMonitor.h
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/6/14.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^levelsHandlerBlock)(CGFloat handFloat);

@interface GPMicMonitor : NSObject

@property (nonatomic, copy) levelsHandlerBlock levelsHandlerBlock;

@end
