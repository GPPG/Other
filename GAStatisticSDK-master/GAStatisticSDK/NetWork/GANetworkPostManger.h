//
//  GANetworkManger.h
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GANetworkPostManger : NSObject
/**
 发送请求
 
 @param url url
 @param bodyStr 请求体
 @param headerField 请求头参数
 @param complate 结果回调
 */
+ (void)postWithUrl:(NSString *)url body:(NSString *)bodyStr headerField:(nullable NSDictionary *)headerField complete:(void(^)(NSData *data, NSError *error))complate;

/**
 发送请求
 
 @param url url
 @param bodyStr 请求体
 @param headerField 请求头参数
 @param maxRetryCount 最大重试次数
 @param complate 结果回调
 */
+ (void)postWithUrl:(NSString *)url body:(NSString *)bodyStr headerField:(nullable NSDictionary *)headerField maxRetryCount:(NSInteger)maxRetryCount complete:(void(^)(NSData *data, NSError *error))complate;
/**
 发送请求
 
 @param request request
 @param complate 结果回调
 */
+ (void)requestWithRequest:(NSURLRequest *)request complate:(void(^)(NSData *data, NSError *error))complate;

/**
 发送请求
 
 @param request request
 @param maxRetryCount 最大重试次数
 @param complate 结果回调
 */
+ (void)requestWithRequest:(NSURLRequest *)request maxRetryCount:(NSInteger)maxRetryCount complate:(void(^)(NSData *data, NSError *error))complate;

@end

NS_ASSUME_NONNULL_END
