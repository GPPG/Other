//
//  GABsic19DataTool.m
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/18.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import "GABsic19DataTool.h"
#import "GAFMDBTool.h"
#import "GABasic19Mode.h"
#import "NSObject+GAModel.h"
#import "GANetworkPostTool.h"

@interface GABsic19DataTool ()

//数据库，上传服务器成功，但删除时失败的列表
@property (nonatomic, strong) NSSet *deleteFailList;
@end

static NSString * const kDeleteFailList = @"kSPDeleteFailList";

@implementation GABsic19DataTool

+ (instancetype)shareTool {
    static GABsic19DataTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [self new];
    });
    return tool;
}

- (instancetype)init {
    if (self = [super init]) {
        self.deleteFailList = [[NSUserDefaults standardUserDefaults] objectForKey:kDeleteFailList];
    }
    return self;
}

- (void)updateUserOpenCountWithComplete:(void (^)(BOOL))complete {
    __weak typeof(self) ws = self;
    [[GAFMDBTool shareManager] selectType:[GABasic19Mode getType] complete:^(NSArray<id> * _Nullable arr) {
        GABasic19Mode *model = [[ws getUploadIdsWithArray:arr] firstObject];
        if (model) {
            model.uo += 1;
            [[GAFMDBTool shareManager] updateModel:model withType:[GABasic19Mode getType] complete:complete];
        } else {
            model = [[GABasic19Mode alloc] initWithPn:1];
            model.uo = 1;
            [[GAFMDBTool shareManager] insertWithModel:model complete:^(NSInteger ID) {
                if (complete) {
                    complete(ID >= 0);
                }
            }];
        }
        NSLog(@"19--->累计用户打开次数:%ld", (long)model.uo);
    }];
}

- (void)uploadWithComplete:(void (^)(BOOL))complete {
    __weak typeof(self) ws = self;
    [[GAFMDBTool shareManager] selectType:[GABasic19Mode getType] complete:^(NSArray<id> * _Nullable arr) {
        if (arr.count > 0) {
            __weak typeof(ws) wws = ws;
            NSLog(@"19协议开始上传。。。");
            [[GANetworkPostTool shareTool] postWithArray:[ws getUploadIdsWithArray:arr] complete:^(BOOL success) {
                NSLog(@"19协议上传服务器结果:%d", success);
                if (success) {//上传成功，删除数据库数据
                    __weak typeof(wws) wwws = wws;
                    [[GAFMDBTool shareManager] deleteIds:[wws getDeleteIdsWithArray:arr] complete:^(BOOL success) {
                        NSLog(@"19协议从数据库中的删除结果:%d", success);
                        if (!success) {//删除失败
                            [self fmdbDeleteFailWithIds:[wwws getDeleteIdsWithArray:arr]];
                        }
                        if (complete) {//上传成功后返回yes，为了更新上传时间，不管数据库是否删除失败
                            complete(YES);
                        }
                    }];
                } else {
                    if (complete) {
                        complete(NO);
                    }
                }
            }];
        } else {
            NSLog(@"19协议，查询数据库中没有数据");
            if (complete) {
                complete(NO);
            }
        }
    }];
}

#pragma mark ---private---

//过滤已经上传过服务器的数据
- (NSArray <id>*)getUploadIdsWithArray:(NSArray <id>*)array {
    if (array.count < 0) {
        return nil;
    }
    
    NSMutableArray *mArr = @[].mutableCopy;
    for (id model in array) {
//        if ([self.deleteFailList containsObject:@(model.fmbdId)]) {
//            continue;
//        }
        [mArr addObject:model];
    }
    return mArr.copy;
}

- (NSArray *)getDeleteIdsWithArray:(NSArray <id> *)array {
    if (array.count < 0 && self.deleteFailList == nil) {
        return nil;
    }
    
    NSMutableSet *mSet = [NSMutableSet setWithArray:self.deleteFailList.allObjects];
    for (id model in array) {
//        [mSet addObject:@(model.fmbdId)];
    }
    return mSet.allObjects;
}

- (void)fmdbDeleteFailWithIds:(NSArray *)array {
    NSMutableSet *mSet = [NSMutableSet setWithArray:self.deleteFailList.allObjects];
    [mSet addObjectsFromArray:array];
    self.deleteFailList = mSet.copy;
    [[NSUserDefaults standardUserDefaults] setObject:self.deleteFailList forKey:kDeleteFailList];
}

@end
