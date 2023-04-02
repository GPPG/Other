//
//  GAInputDataManger.m
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GAInputDataManger.h"
#import "GASetGeneralModeTool.h"
#import "GAInitDataMode.h"

static GAInputDataManger *instance;

@interface GAInputDataManger()
    

    
@end


@implementation GAInputDataManger
    
    
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)ga_clearData {
    self.op = @"";
    self.oj = @"";
    self.ac = @"";
    self.et = @"";
    self.sr = @"";
    self.tb = @"";
    self.mk = @"";
    self.ob = @"";
    self.od = @"";
}


// 104
- (GAABMode *)getAbInputMode{
    [GASetGeneralModeTool setGeneralMode:instance];
    self.pn = 6;
    self.at = [GAInitDataMode sharedManager].abtestId;
    GAABMode *abmode = [GAABMode ga_modelWithJSON:[self ga_modelToJSONObject]];
    
    return abmode;
    
}

// 59
- (GAPayMode *)getPayInputMode{
    [GASetGeneralModeTool setGeneralMode:instance];
    self.pn = 5;
    self.at = [GAInitDataMode sharedManager].abtestId;

    GAPayMode *paymode = [GAPayMode ga_modelWithJSON:[self ga_modelToJSONObject]];
    
    return paymode;
}

// 101
- (GAUserBehaviorMode *)getUserInputMode{
    [GASetGeneralModeTool setGeneralMode:instance];
    self.pn = 4;
    self.at = [GAInitDataMode sharedManager].abtestId;

    GAUserBehaviorMode *usermode = [GAUserBehaviorMode ga_modelWithJSON:[self ga_modelToJSONObject]];
    
    return usermode;
}

    
@end
