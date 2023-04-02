//
//  GANetworkMeterManger.h
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GANetworkChangeBlock)(BOOL canUse);

@interface GANetworkMeterManger : NSObject

+ (instancetype)sharedManager;
- (void)ga_addNetworkChangeObserver:(GANetworkChangeBlock)block;
- (void)ga_removeNetworkChangeObserver;
@end

NS_ASSUME_NONNULL_END
