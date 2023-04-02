//
//  GAPayManger.h
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/19.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GAPayManger : NSObject

+ (instancetype)sharedManager;

- (void)uploadMode;

- (void)chekSurplusData;

@end

NS_ASSUME_NONNULL_END
