
//
//  GAStatisticsTool.m
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GAStatisticsUploadManger.h"
#import "GAAbtestManger.h"
#import "GAUserBehaviorManger.h"
#import "GAInputDataManger.h"
#import "GAPayManger.h"

@interface GAStatisticsUploadManger()

@property(strong, nonatomic)NSString *operateCodeStr;

@property(strong, nonatomic)NSString *objectStr;

@property(strong, nonatomic)NSString *positionStr;

@property(strong, nonatomic)NSString *enterStr;

@property(strong, nonatomic)NSString *operateResultStr;

@property(strong, nonatomic)NSString *tabStr;

@property(strong, nonatomic)NSString *remarkStr;

@property(strong, nonatomic)NSString *associateStr;

@property(strong, nonatomic)NSString *orderTypeStr;

@end

static GAStatisticsUploadManger *instance;

@implementation GAStatisticsUploadManger
    
#pragma mark - set

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (GAStatisticsUploadManger *(^)(NSString *))operateCode {
    return ^GAStatisticsUploadManger *(NSString *string) {
        GAStatisticsUploadManger *statistics = [GAStatisticsUploadManger sharedInstance];
        [[GAInputDataManger sharedInstance] ga_clearData];
        statistics.operateCodeStr = string;
        [GAInputDataManger sharedInstance].op = string;
        return statistics;
    };
}
    
- (GAStatisticsUploadManger *(^)(NSString *))object {
    return ^GAStatisticsUploadManger *(NSString *string) {
        self.objectStr = string;
        [GAInputDataManger sharedInstance].oj = string;

        return self;
    };
}
    
- (GAStatisticsUploadManger *(^)(NSString *))associate {
    return ^GAStatisticsUploadManger *(NSString *string) {
        self.associateStr = string;
        [GAInputDataManger sharedInstance].ob = string;
        //test
        return self;
    };
}
    
- (GAStatisticsUploadManger *(^)(NSString *))enter {
    return ^GAStatisticsUploadManger *(NSString *string) {
        self.enterStr = string;
        [GAInputDataManger sharedInstance].et = string;

        return self;
    };
}
    
- (GAStatisticsUploadManger *(^)(NSString *))tab {
    return ^GAStatisticsUploadManger *(NSString *string) {
        self.tabStr = string;
        [GAInputDataManger sharedInstance].tb = string;

        return self;
    };
}
    
- (GAStatisticsUploadManger *(^)(NSString *))remark {
    return ^GAStatisticsUploadManger *(NSString *string) {
        self.remarkStr = string;
        [GAInputDataManger sharedInstance].mk = string;

        return self;
    };
}
    
- (GAStatisticsUploadManger *(^)(NSString *))position {
    return ^GAStatisticsUploadManger *(NSString *string) {
        self.positionStr = string;
        [GAInputDataManger sharedInstance].ac = string;

        return self;
    };
}
    

    
- (GAStatisticsUploadManger *(^)(NSString *))orderType {
    return ^GAStatisticsUploadManger *(NSString *string) {
        self.orderTypeStr = string;
        [GAInputDataManger sharedInstance].od = string;

        return self;
    };
}
    
- (GAStatisticsUploadManger *(^)(NSString *))operateResult {
    return ^GAStatisticsUploadManger *(NSString *string) {
        self.operateResultStr = string;
        [GAInputDataManger sharedInstance].sr = string;

        return self;
    };
}
    
    
#pragma mark - pubilc
    
- (void)upload101{
    
    [[GAUserBehaviorManger sharedManager] uploadMode];
}
    
- (void)upload104{
    
    [[GAAbtestManger sharedManager] uploadMode];
        
}
    
- (void)upload59{
    
    [[GAPayManger sharedManager] uploadMode];

}
    
- (void)check101{
    [[GAUserBehaviorManger sharedManager] chekSurplusData];

    
}
    
- (void)check104{
    [[GAAbtestManger sharedManager] chekSurplusData];

    
}
    
- (void)check59{
    
    [[GAPayManger sharedManager] chekSurplusData];

}
    
@end
