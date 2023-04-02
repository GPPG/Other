//
//  FITPushAuthorizationTool.h
//  fitness
//
//  Created by 郭鹏 on 2018/9/5.
//  Copyright © 2018年 supergeek. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RegisterPushSuccessfulBlock)(void);
typedef void(^RegisterPushFailureBlock)(void);

typedef void(^RegisterPushBlock)(void);

typedef void(^AlterBlock)(void);


@interface FITPushAuthorizationTool : NSObject



- (void)acquirePushAuthorizationStatus:(RegisterPushBlock)registerPushBlock;


-(void)acquirePushAuthorizationStatus:(RegisterPushSuccessfulBlock)registerPushSuccessfulBlock registerPushFailureBlock:(RegisterPushFailureBlock)registerPushFailureBlock;

- (void)showAlterAuthorizaView:(AlterBlock)AlterBlock;

@end
