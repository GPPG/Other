//
//  GAPayManger.m
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/19.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GAPayManger.h"
#import "GACurrentTimeUploadTool.h"
#import "GAUploadProtocol.h"


@interface GAPayManger()<GAUploadProtocol>

@property (nonatomic, strong) GACurrentTimeUploadTool *uploadTool;

@end

static GAPayManger *instance;

@implementation GAPayManger


+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - public

//校验模型的正确性 ---> 保存模型到数据库 ---> 从数据库读取模型 ---> 上传 --->上传成功 ---> 删除数据库 ---> 检查数据库是否还有内容
//校验模型的正确性 ---> 保存模型到数据库 ---> 从数据库读取模型 ---> 上传 --->上传失败 --->校验数据正确性 ----> 删除数据库

- (void)uploadMode{
    
    [self.uploadTool uploadMode];
    
}

// 检查数据库是否还有模型
- (void)chekSurplusData{
    [self.uploadTool chekSurplusData];
}

#pragma mark - lazy
- (GACurrentTimeUploadTool *)uploadTool
{
    if (!_uploadTool) {
        _uploadTool = [[GACurrentTimeUploadTool alloc]initWithType:PayUploadType];
    }
    return _uploadTool;
}





@end
