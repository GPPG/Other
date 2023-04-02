//
//  SPStringUtil.m
//  StatisticSdk
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GAStringTool.h"

@implementation GAStringTool

+ (NSString*)ga_objectTOjsonString:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:0
                                                         error:&error];
    if (!jsonData) {
        GALog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

+ (NSString *)ga_convertToJsonData:(NSDictionary *)dict {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        GALog(@"%@",error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (NSDictionary *)ga_dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        GALog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
