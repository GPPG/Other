//
//  GANetworkPostTool.h
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GANetworkPostTool : NSObject

+ (instancetype)shareTool;

- (void)postWithArray:(NSArray *)array complete:(void(^ __nullable)(BOOL success))complete;

    
@end

NS_ASSUME_NONNULL_END
