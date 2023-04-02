//
//  GABasic19Mode.m
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/17.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import "GABasic19Mode.h"
#import "GAGeneralModel.h"
#import "GADeviceInfoTool.h"

@interface GABasic19Mode()

//abtest的id，没有可以传1
@property (nonatomic, copy) NSString *at;
//用户操作系统的版本信息
@property (nonatomic, copy) NSString *os;
//用户rom信息
@property (nonatomic, copy) NSString *rm;
//用户手机型号，如：iPhone6s
@property (nonatomic, copy) NSString *md;
//1：手机，2：平板
@property (nonatomic, assign) NSInteger mp;
//语言代码
@property (nonatomic, copy) NSString *la;

@property (nonatomic, strong) GAGeneralModel *generalModel;
@end

@implementation GABasic19Mode
//@synthesize fmbdId;

- (instancetype)initWithPn:(NSInteger)pn {
    if (self = [super init]) {
        self.generalModel = [[GAGeneralModel alloc] initWithPn:pn];
    }
    return self;
}



- (NSString *)at {
    if (_at == nil) {
        _at = @"1";
    }
    return _at;
}

- (NSString *)os {
    if (_os == nil) {
        _os = [GADeviceInfoTool ga_systemVersion];
    }
    return _os;
}

- (NSString *)rm {
    if (_rm == nil) {
        _rm = [GADeviceInfoTool ga_romInfo];
    }
    return _rm;
}

- (NSString *)md {
    if (_md == nil) {
        _md = [GADeviceInfoTool ga_deviceTypeStr];
    }
    return _md;
}

- (NSInteger)mp {
    if (_mp == 0) {
        _mp = [GADeviceInfoTool ga_phoneType];
    }
    return _mp;
}

- (NSString *)la {
    if (_la == nil) {
        _la = [GADeviceInfoTool ga_language];
    }
    return _la;
}

- (nonnull NSString *)getType {
    return NSStringFromClass([self class]);
}

+ (nonnull NSString *)getType {
    return NSStringFromClass([self class]);
}

@end
