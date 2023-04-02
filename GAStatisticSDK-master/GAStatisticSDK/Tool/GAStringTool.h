//
//  SPStringUtil.h
//  StatisticSdk
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GAStringTool : NSObject

+ (NSString*)ga_objectTOjsonString:(id)object;
+ (NSString *)ga_convertToJsonData:(NSDictionary *)dict;
+ (NSDictionary *)ga_dictionaryWithJsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
