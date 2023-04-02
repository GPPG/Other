//
//  GAPromotion45Mode.h
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/17.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GAPromotion45Mode : NSObject

//af 明细 传appsflyer返回的map原始数据
@property (nonatomic, copy) NSString *af;
//AF Agency 传agency数据
@property (nonatomic, copy) NSString *aa;
//1、GA参数部分链接，即从“utm_source=”开始到结束部分的链接
@property (nonatomic, copy) NSString *ga;
//Referrer 传原始的referrer
@property (nonatomic, copy) NSString *re;

- (instancetype)initWithPn:(NSInteger)pn af:(NSString *)af aa:(NSString *)aa ga:(NSString *)ga re:(NSString *)re;


@end

