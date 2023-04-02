//
//  GAPayMode.h
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/16.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAUploadModeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface GAPayMode : NSObject<NSCopying,NSCoding,NSMutableCopying,GAUploadModeProtocol>

@property (nonatomic, assign) NSInteger pn;

@property (nonatomic, copy) NSString *at;

//客户端日志打印时间
@property (nonatomic, copy) NSString *ct;
//ios：appid android：包名
@property (nonatomic, copy) NSString *pi;
//UUID
@property (nonatomic, copy) NSString *ui;
//IDFA
@property (nonatomic, copy) NSString *ai;
//国家代码。
@property (nonatomic, copy) NSString *sm;
//产品版本号(build值)
@property (nonatomic, copy) NSString *vc;
//产品版本号(version值)
@property (nonatomic, copy) NSString *vn;
//渠道
@property (nonatomic, assign) NSInteger ch;

//操作码（见操作码对应表）
@property (nonatomic, copy) NSString *op;
//统计对象
@property (nonatomic, copy) NSString *oj;
//位置
@property (nonatomic, copy) NSString *ac;
//入口
@property (nonatomic, copy) NSString *et;
//操作结果（默认1）
@property (nonatomic, copy) NSString *sr;
//tab分类
@property (nonatomic, copy) NSString *tb;
//备注
@property (nonatomic, copy) NSString *mk;
//关联对象
@property (nonatomic, copy) NSString *ob;
//关联对象
@property (nonatomic, copy) NSString *od;

- (BOOL)judgeModeCorrect;

@end

NS_ASSUME_NONNULL_END
