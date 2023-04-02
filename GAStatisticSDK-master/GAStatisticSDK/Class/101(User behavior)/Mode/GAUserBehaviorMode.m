//
//  GAUserBehaviorMode.m
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/16.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GAUserBehaviorMode.h"

@implementation GAUserBehaviorMode
- (void)encodeWithCoder:(NSCoder *)aCoder { [self ga_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self ga_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self ga_modelCopy]; }
- (NSUInteger)hash { return [self ga_modelHash]; }
- (BOOL)isEqual:(id)object { return [self ga_modelIsEqual:object]; }
- (NSString *)description { return [self ga_modelDescription]; }
- (id)mutableCopyWithZone:(NSZone *)zone{return [self ga_modelCopy];};

- (BOOL)judgeModeCorrect{
    
    BOOL correct = YES;
    if (!self.pn || !self.ct || !self.pi || !self.ui || !self.ai || !self.at || !self.sm || !self.vc || !self.vn || !self.ch || !self.op) {
        correct = NO;
    }
    return correct;
}
@end
