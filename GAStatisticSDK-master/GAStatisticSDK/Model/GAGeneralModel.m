//
//  GAGeneralModel.m
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/17.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import "GAGeneralModel.h"
#import "GATimeTool.h"
#import "GADeviceInfoTool.h"
#import "GABasicDataModel.h"

@interface GAGeneralModel ()

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

@end

@implementation GAGeneralModel

- (instancetype)initWithPn:(NSInteger)pn {
    if (self = [super init]) {
        self.pn = pn;
    }
    return self;
}

+ (nonnull instancetype)modelWithDict:(nonnull NSDictionary *)dict {
    GAGeneralModel *model = [self new];
    
    model.pn = [dict[@"pn"] integerValue];
    model.ct = dict[@"ct"];
    model.pi = dict[@"pi"];
    model.ui = dict[@"ui"];
    model.ai = dict[@"ai"];
    model.sm = dict[@"sm"];
    model.vc = dict[@"vc"];
    model.vn = dict[@"vn"];
    model.ch = [dict[@"ch"] integerValue];
    
    return model;
}


- (NSDictionary *)getJson {
    NSDictionary *dict = @{@"pn":@(self.pn),
                           @"ct":self.ct ?: @"",
                           @"pi":self.pi ?: @"",
                           @"ui":self.ui ?: @"",
                           @"ai":self.ai ?: @"",
                           @"sm":self.sm ?: @"",
                           @"vc":self.vc ?: @"",
                           @"vn":self.vn ?: @"",
                           @"ch":@(self.ch)
                           };
    return dict;
}

+ (nonnull NSString *)getType {
    return NSStringFromClass([self class]);
}

- (nonnull NSString *)getType {
    return NSStringFromClass([self class]);
}

- (nonnull NSString *)getJsonString {
    NSDictionary *dict = [self getJson];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


+ (nonnull instancetype)modelWithJsonStr:(nonnull NSString *)JsonStr {
    NSData *data = [JsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:0];
    return [self modelWithDict:dict];
}


- (NSString *)ct {
    return [GATimeTool ga_getNowTimeWithFormat];
}

- (NSString *)pi {
    if (_pi == nil) {
        _pi = [GABasicDataModel sharedManager].appleId;
    }
    return _pi;
}

- (NSString *)ui {
    if (_ui == nil) {
        _ui = [GADeviceInfoTool ga_UUIDStr];
    }
    return _ui;
}

- (NSString *)ai {
    if (_ai == nil) {
        _ai = [GADeviceInfoTool ga_IDFAStr];
    }
    return _ai;
}

- (NSString *)sm {
    if (_sm == nil) {
        _sm = [GADeviceInfoTool ga_countryCode];
    }
    return _sm;
}

- (NSString *)vc {
    return [GADeviceInfoTool ga_versionCode];
}

- (NSString *)vn {
    return [GADeviceInfoTool ga_versionName];
}

- (NSInteger)ch {
    if (_ch == 0) {
        _ch = [GABasicDataModel sharedManager].channelId;
    }
    return _ch;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    GAGeneralModel *model = [[[self class] allocWithZone:zone] init];
    model.pn = self.pn;
    model.ct = [self.ct mutableCopy];
    model.pi = [self.pi mutableCopy];
    model.ui = [self.ui mutableCopy];
    model.ai = [self.ai mutableCopy];
    model.sm = [self.sm mutableCopy];
    model.vc = [self.vc mutableCopy];
    model.vn = [self.vn mutableCopy];
    model.ch = self.ch;
    return model;
}


@end
