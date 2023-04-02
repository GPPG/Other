//
//  GAGeneralModel.h
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/17.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GAGeneralModel : NSObject

//日志序列
@property (nonatomic, assign) NSInteger pn;

- (instancetype)initWithPn:(NSInteger)pn;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (NSDictionary *)getJson;

+ (instancetype)modelWithJsonStr:(NSString *)JsonStr;
- (NSString *)getJsonString;

+ (NSString *)getType;
- (NSString *)getType;

@end

