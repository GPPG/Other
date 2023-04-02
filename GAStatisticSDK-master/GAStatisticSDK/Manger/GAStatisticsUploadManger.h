//
//  GAStatisticsTool.h
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GAStatisticsUploadManger : NSObject

    
+ (GAStatisticsUploadManger *(^)(NSString *))operateCode;
    
- (GAStatisticsUploadManger *(^)(NSString *))object;
    
- (GAStatisticsUploadManger *(^)(NSString *))associate;
    
- (GAStatisticsUploadManger *(^)(NSString *))enter;
    
- (GAStatisticsUploadManger *(^)(NSString *))tab;
    
- (GAStatisticsUploadManger *(^)(NSString *))remark;
    
- (GAStatisticsUploadManger *(^)(NSString *))position;

- (GAStatisticsUploadManger *(^)(NSString *))orderType;
    
- (GAStatisticsUploadManger *(^)(NSString *))operateResult;

+ (instancetype)sharedInstance;

- (void)upload101;
    
- (void)upload104;
    
- (void)upload59;
    
- (void)check101;
    
- (void)check104;
    
- (void)check59;
    
@end

NS_ASSUME_NONNULL_END
