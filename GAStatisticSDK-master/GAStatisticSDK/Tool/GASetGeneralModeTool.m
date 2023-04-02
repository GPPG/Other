//
//  GASetGeneralModeTool.m
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/16.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GASetGeneralModeTool.h"
#import "GATimeTool.h"
#import "GAInitDataMode.h"
#import "GADeviceInfoTool.h"

@implementation GASetGeneralModeTool

+ (void)setGeneralMode:(GAInputDataManger *)inputManger{
    
    inputManger.ct = [GATimeTool ga_getNowTimeWithFormat];
    
    inputManger.pi = [GAInitDataMode sharedManager].appleId;

    inputManger.ui = [GADeviceInfoTool ga_UUIDStr];

    inputManger.ai = [GADeviceInfoTool ga_IDFAStr];

    inputManger.sm = [GADeviceInfoTool ga_countryCode];

    inputManger.vc = [GADeviceInfoTool ga_versionCode];

    inputManger.vn = [GADeviceInfoTool ga_versionName];
    
    inputManger.ch =  [GAInitDataMode sharedManager].channelId;
    
}
@end
