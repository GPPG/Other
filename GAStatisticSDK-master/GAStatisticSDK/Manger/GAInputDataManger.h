//
//  GAInputDataManger.h
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAABMode.h"
#import "GAPayMode.h"
#import "GAUserBehaviorMode.h"

NS_ASSUME_NONNULL_BEGIN

@interface GAInputDataManger : NSObject


// orderTypeStr od 订单类型 (59协议)
@property(strong, nonatomic)NSString *od;

// abtest 没有为1 (59协议)
@property (nonatomic, copy) NSString *at;


// operateCodeStr op 操作码 (59,101,104协议)
@property(strong, nonatomic)NSString *op;
// objectStr oj 统计对象 (59,101,104协议)
@property(strong, nonatomic)NSString *oj;
// positionStr ac 位置 (59,101,104协议)
@property(strong, nonatomic)NSString *ac;
// enterStr et 入口 (59,101,104协议)
@property(strong, nonatomic)NSString *et;
// operateResultStr sr 操作结果(默认1) (59,101,104协议)
@property(strong, nonatomic)NSString *sr;
// tabStr tb 分类 (59,101,104协议)
@property(strong, nonatomic)NSString *tb;
// remarkStr mk 备注 (59,101,104协议)
@property(strong, nonatomic)NSString *mk;
// associateStr ob 关联对象 (59,101,104协议)
@property(strong, nonatomic)NSString *ob;


//日志序列 (59,101,104协议)
@property (nonatomic, assign) NSInteger pn;
//客户端日志打印时间 (59,101,104协议)
@property (nonatomic, copy) NSString *ct;
//ios：appid android：包名 (59,101,104协议)
@property (nonatomic, copy) NSString *pi;
//UUID (59,101,104协议)
@property (nonatomic, copy) NSString *ui;
//IDFA (59,101,104协议)
@property (nonatomic, copy) NSString *ai;
//国家代码。(59,101,104协议)
@property (nonatomic, copy) NSString *sm;
//产品版本号(build值) (59,101,104协议)
@property (nonatomic, copy) NSString *vc;
//产品版本号(version值) (59,101,104协议)
@property (nonatomic, copy) NSString *vn;
//渠道 (59,101,104协议)
@property (nonatomic, assign) NSInteger ch;

+ (instancetype)sharedInstance;

- (GAABMode *)getAbInputMode;

- (GAPayMode *)getPayInputMode;

- (GAUserBehaviorMode *)getUserInputMode;
- (void)ga_clearData;

@end

NS_ASSUME_NONNULL_END
