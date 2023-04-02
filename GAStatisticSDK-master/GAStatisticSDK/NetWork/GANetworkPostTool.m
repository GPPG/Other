//
//  GANetworkPostTool.m
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GANetworkPostTool.h"
#import "GAInitDataMode.h"
#import "GATimeTool.h"
#import "GAStringTool.h"
#import "GANetworkPostManger.h"

static NSString * const url_host = @"http://s.do4health.com/s";

@interface GANetworkPostTool()
    

    
@end

@implementation GANetworkPostTool
    
    
+ (instancetype)shareTool{
    static GANetworkPostTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [self new];
    });
    return tool;

}
    
- (void)postWithArray:(NSArray *)array complete:(void(^ __nullable)(BOOL success))complete{
    if (array == nil || array.count == 0) {
        return;
    }
    
    NSString *urlStr = [self statisticUrl];
    NSString *bodyStr = [GAStringTool ga_objectTOjsonString:[self modelToDictWithArray:array]];
    NSDictionary *headerDict = @{@"content-Type":@"application/json"};

    [GANetworkPostManger postWithUrl:urlStr body:bodyStr headerField:headerDict maxRetryCount:3 complete:^(NSData * _Nonnull data, NSError * _Nonnull error) {
        GALog(@"请求类型：type = %@", [array[0] getType]);
        GALog(@"请求url：urlStr = %@", urlStr);
        GALog(@"请求参数：bodyStr = %@", bodyStr);
        GALog(@"请求结果：data = %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        BOOL result = NO;
        if (error == nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([dict[@"sc"] isEqualToString:@"SUCCESS"]) {
                result = YES;
            }
        }
        
        if (complete) {
            complete(result);
        }
    }];
}

#pragma mark - private
    
- (NSString *)statisticUrl {
    return [NSString stringWithFormat:@"%@/%@/%@/%@", url_host, [GAInitDataMode sharedManager].productNum, [GAInitDataMode sharedManager].productPublicKey, [GATimeTool ga_getNowTimeTimestamp]];
}

- (NSArray <NSDictionary *>*)modelToDictWithArray:(NSArray *)array {
    
    NSMutableArray *dicArray = [[NSMutableArray alloc]init];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dicArray addObject:[obj ga_modelToJSONObject]];
    }];
    return dicArray.copy;
}
    
@end
