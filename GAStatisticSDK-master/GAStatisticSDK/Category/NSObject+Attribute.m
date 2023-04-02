//
//  NSObject+Attribute.m
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/17.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "NSObject+Attribute.h"
#import <objc/runtime.h>

static char associateLengthKey;

@implementation NSObject (Attribute)

- (void)setFmbdId:(NSInteger)fmbdId{
    objc_setAssociatedObject(self, &associateLengthKey, @(fmbdId), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (NSInteger)fmbdId{
    return [(NSNumber *)objc_getAssociatedObject(self, &associateLengthKey) integerValue];

}

- (NSString *)getJsonString{
    
    NSDictionary *dict = [self ga_modelToJSONObject];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

}

+ (NSString *)getType{
    return NSStringFromClass([self class]);

}

- (NSString *)getType{
    return NSStringFromClass([self class]);
}



@end
