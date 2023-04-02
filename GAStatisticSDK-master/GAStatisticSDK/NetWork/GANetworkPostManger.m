//
//  GANetworkManger.m
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GANetworkPostManger.h"

@implementation GANetworkPostManger
    
+ (void)postWithUrl:(NSString *)url body:(NSString *)bodyStr headerField:(nullable NSDictionary *)headerField complete:(void(^)(NSData *data, NSError *error))complate {
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    mRequest.HTTPMethod = @"POST";
    mRequest.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    [mRequest setTimeoutInterval:5.0];
    
    for (NSString *key in headerField.allKeys) {
        [mRequest setValue:headerField[key] forHTTPHeaderField:key];
    }
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:mRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (complate) {
            complate(data, error);
        }
    }];
    [task resume];
}
    
+ (void)postWithUrl:(NSString *)url body:(NSString *)bodyStr headerField:(nullable NSDictionary *)headerField maxRetryCount:(NSInteger)maxRetryCount complete:(void(^)(NSData *data, NSError *error))complate {
    if (maxRetryCount < 0) {
        if (complate) {
            NSError *error = [NSError errorWithDomain:@"com.spring.StatisticSdk.ErrorDomain" code:101 userInfo:@{NSLocalizedDescriptionKey:@"retry fail"}];
            complate(nil, error);
            return;
        }
    }
    
    __weak typeof(self) ws = self;
    [self postWithUrl:url body:bodyStr headerField:headerField complete:^(NSData * _Nonnull data, NSError * _Nonnull error) {
        if (error) {
            [ws postWithUrl:url body:bodyStr headerField:headerField maxRetryCount:maxRetryCount - 1 complete:complate];
        } else {
            if (complate) {
                complate(data, error);
            }
        }
    }];
}
    
+ (void)requestWithRequest:(NSURLRequest *)request complate:(void(^)(NSData *data, NSError *error))complate {
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (complate) {
            complate(data, error);
        }
    }];
    [task resume];
}
    
+ (void)requestWithRequest:(NSURLRequest *)request maxRetryCount:(NSInteger)maxRetryCount complate:(void(^)(NSData *data, NSError *error))complate {
    if (maxRetryCount < 0) {
        if (complate) {
            NSError *error = [NSError errorWithDomain:@"com.spring.StatisticSdk.ErrorDomain" code:101 userInfo:@{NSLocalizedDescriptionKey:@"retry fail"}];
            complate(nil, error);
            return;
        }
    }
    
    __weak typeof(self) ws = self;
    [self requestWithRequest:request complate:^(NSData * _Nonnull data, NSError * _Nonnull error) {
        if (error) {
            [ws requestWithRequest:request maxRetryCount:maxRetryCount - 1 complate:complate];
        } else {
            if (complate) {
                complate(data, error);
            }
        }
    }];
}

    
    
@end
