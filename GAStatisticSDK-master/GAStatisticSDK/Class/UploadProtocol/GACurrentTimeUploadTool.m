//
//  GACurrentTimeUploadTool.m
//  GAStatisticSDK
//
//  Created by 郭鹏 on 2019/4/18.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GACurrentTimeUploadTool.h"
#import "GAFMDBTool.h"
#import "GAInputDataManger.h"
#import "GANetworkPostTool.h"
#import "GAUploadModeProtocol.h"


@interface GACurrentTimeUploadTool()


@property (nonatomic, assign) UploadType uploadType;

@property(assign, nonatomic)BOOL isUploading;

@end


@implementation GACurrentTimeUploadTool


- (instancetype)initWithType:(UploadType)uploadType{
    
    if (self = [super init]) {
        self.uploadType = uploadType;
    }
    return self;
}

#pragma mark - GAUploadProtocol
//校验模型的正确性 ---> 保存模型到数据库 ---> 从数据库读取模型 ---> 上传 --->上传成功 ---> 删除数据库 ---> 检查数据库是否还有内容
//校验模型的正确性 ---> 保存模型到数据库 ---> 从数据库读取模型 ---> 上传 --->上传失败 --->校验数据正确性 ----> 删除数据库
- (void)uploadMode{
    
    NSObject <GAUploadModeProtocol> *obj = [self getSubMode];
    
    if (![self judgeModeCorrect:obj]) {
        GALog(@"上传参数格式不正确");
        return;
    };
    
    [self saveMode];
}

// 保存模型到数据库
- (void)saveMode{
    
    __weak typeof(self) ws = self;
    
    [[GAFMDBTool shareManager] insertWithModel:[self getSubMode] complete:^(NSInteger ID) {
        
        if (ID < 0) {
            return;
        }
        [ws getModeArray];
    }];
}

// 从数据库读取模型
- (void)getModeArray{
    
    if (self.isUploading) {
        return;
    }
    self.isUploading = YES;
    __weak typeof(self) ws = self;
    [[GAFMDBTool shareManager] selectType:[self getModeClassStr] complete:^(NSArray<id> * _Nullable arr) {
        [ws uploadModeArray:arr];
    }];
}

// 上传
- (void)uploadModeArray:(NSArray *)modeArray{
    
    if (modeArray.count == 0) {
        return;
    }
    
    __weak typeof(self) ws = self;
    [[GANetworkPostTool shareTool] postWithArray:modeArray complete:^(BOOL success) {
        
        ws.isUploading = NO;
        if (success) {
            GALog(@"协议--->上传成功");
            // 删除保存的参数
            [ws deleteModeArray:modeArray];
        }else{
            // 校验参数的正确性,如果错误,删除错误的模型
            [ws getMistakeModeIdArray:modeArray];
            GALog(@"协议--->上传失败");
        }
    }];
}
// 上传成功,删除数据库内容
- (void)deleteModeArray:(NSArray *)modeArray{
    
    __weak typeof(self) ws = self;
    [[GAFMDBTool shareManager] deleteIds:[self getModeIdArray:modeArray] complete:^(BOOL success) {
        if (success) {
            GALog(@"协议------>数据库删除成功")
            [ws chekSurplusData];
        }else{
            GALog(@"协议----->数据库删除失败")
        }
    }];
}

// 检查数据库是否还有模型
- (void)chekSurplusData{
    
    NSArray <NSObject *>*modeArray = [[GAFMDBTool shareManager] selectType:[self getModeClassStr]];
    if (modeArray.count == 0) {
        GALog(@"协议--->数据库中没有数据");
        return;
    }
    GALog(@"协议--->数据库中存在数据");
    
    [self uploadModeArray:modeArray];
}



#pragma mark - private

// 获取ID数组
- (NSArray *)getModeIdArray:(NSArray *)modeArray{
    
    NSMutableArray *array = [NSMutableArray array];
    
    [modeArray enumerateObjectsUsingBlock:^(NSObject *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:@(obj.fmbdId)];
    }];
    return [array copy];
}




// 删除错误参数
- (void)getMistakeModeIdArray:(NSArray *)modeArray{
    
    NSMutableArray *array = [NSMutableArray array];
    
    [modeArray enumerateObjectsUsingBlock:^(NSObject <GAUploadModeProtocol>*obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![self judgeModeCorrect:obj]) {
            [array addObject:@(obj.fmbdId)];
        };
    }];
    
    
    if (array.count) {
        [[GAFMDBTool shareManager] deleteIds:array complete:^(BOOL success) {
            if (success) {
                GALog(@"协议------>数据库删除成功")
            }else{
                GALog(@"协议----->数据库删除失败")
            }
        }];
    }
}

// 判断参数格式是否正确
- (BOOL)judgeModeCorrect:(NSObject <GAUploadModeProtocol>*)obj{
    
    BOOL correct = [obj judgeModeCorrect];
    return correct;
}


- (NSObject <GAUploadModeProtocol> *)getSubMode{
    
    NSObject <GAUploadModeProtocol> *mode;
    switch (self.uploadType) {
        case AbUploadType:
            mode = [[[GAInputDataManger sharedInstance] getAbInputMode] mutableCopy];
            break;
        case PayUploadType:
            mode = [[[GAInputDataManger sharedInstance] getPayInputMode] mutableCopy];
            break;
        case UserBehaviorUploadType:
            mode = [[[GAInputDataManger sharedInstance] getUserInputMode] mutableCopy];
            break;
            
        default:
            break;
    }
    return mode;
}

- (NSString *)getModeClassStr{
    
    NSString *modeStr;
    switch (self.uploadType) {
        case AbUploadType:
            modeStr = [GAABMode getType];
            break;
        case PayUploadType:
            modeStr = [GAPayMode getType];
            break;
        case UserBehaviorUploadType:
            modeStr = [GAUserBehaviorMode getType];
            break;
            
        default:
            break;
    }
    return modeStr;
}

@end
