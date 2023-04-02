//
//  NSObject+Attribute.h
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/17.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Attribute)

@property (nonatomic, assign) NSInteger fmbdId;

+ (nonnull NSString *)getType;

- (NSString *)getJsonString;

+ (NSString *)getType;

- (NSString *)getType;



@end

NS_ASSUME_NONNULL_END
