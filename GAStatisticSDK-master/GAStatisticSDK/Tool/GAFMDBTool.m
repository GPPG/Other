//
//  GAFMDBTool.m
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/17.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import "GAFMDBTool.h"
#import "FMDB.h"
#import "NSObject+GAModel.h"

@interface GAFMDBTool ()

@property (nonatomic, strong) FMDatabaseQueue *queue;
@end

@implementation GAFMDBTool

static GAFMDBTool *manager;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [super allocWithZone:zone];
        }
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.queue = [self createDataBaseQueue];
    }
    return self;
}

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [self new];
        }
    });
    return manager;
}

- (FMDatabaseQueue *)createDataBaseQueue {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [documentsPath stringByAppendingPathComponent:@"statistic.sqlite"];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sql = @"create table if not exists table_statistic ('id' INTEGER PRIMARY KEY AUTOINCREMENT,'type' TEXT NOT NULL, 'paramsString' TEXT NOT NULL)";
        if ([db executeUpdate:sql]) {
            GALog(@"数据库表table_statistic创建成功");
        };
    }];
    return queue;
}

- (NSInteger)insertWithModel:(id)model {
    __block NSInteger ID = -1;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        GALog(@"insert--->start--->type:%@,paramsString:%@", [model getType], [model ga_modelToJSONString]);
        BOOL result = [db executeUpdate:@"insert into 'table_statistic' (type,paramsString) values(?,?)" withArgumentsInArray:@[[model getType], [model ga_modelToJSONString]]];
        if (result) {
            ID = (NSInteger)db.lastInsertRowId;
        }
        GALog(@"insert--->end--->ID:%ld--->type:%@,paramsString:%@", (long)ID, [model getType], [model ga_modelToJSONString]);
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return ID;
}

- (NSArray *)insertArray:(NSArray<id> *)array {
    if (array.count <= 0) {
        return nil;
    }
    __block NSMutableArray *ids = @[].mutableCopy;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        GALog(@"insertArray--->start");
        for (int i = 0; i < array.count; i ++) {
            NSInteger ID;
            id model = array[i];
            GALog(@"insert--->start--->type:%@,paramsString:%@", [model getType], [model ga_modelToJSONString]);
            BOOL result = [db executeUpdate:@"insert into 'table_statistic' (type,paramsString) values(?,?)" withArgumentsInArray:@[[model getType], [model ga_modelToJSONString]]];
            GALog(@"insert--->end--->ID:%lld--->type:%@,paramsString:%@", db.lastInsertRowId, [model getType], [model ga_modelToJSONString]);
            if (!result) {
                *rollback = YES;
                ids = nil;
                break;
            }
            ID = (NSInteger)db.lastInsertRowId;
            [ids addObject:@(ID)];
        }
        GALog(@"insertArray--->end--->rollback:%d", *rollback);
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return ids.copy;
}

- (BOOL)deleteId:(NSInteger)ID {
    __block BOOL result;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        GALog(@"delete--->start--->ID:%ld", (long)ID);
        result = [db executeUpdate:@"delete from 'table_statistic' where ID = ?" withArgumentsInArray:@[@(ID)]];
        GALog(@"delete--->end--->result:%d--->ID:%ld", result, (long)ID);
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return result;
}

- (BOOL)deleteIds:(NSArray *)ids {
    __block BOOL isSuccess = YES;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        GALog(@"deleteArray--->start");
        for (NSNumber *ID in ids) {
            GALog(@"delete--->start--->ID:%ld", (long)[ID integerValue]);
            BOOL result = [db executeUpdate:@"delete from 'table_statistic' where ID = ?" withArgumentsInArray:@[ID]];
            GALog(@"delete--->end--->result:%d--->ID:%ld", result, (long)[ID integerValue]);
            if (!result) {
                *rollback = YES;
                isSuccess = NO;
                break;
            }
        }
        GALog(@"deleteArray--->end--->rollBack:%d", *rollback);
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return isSuccess;
}

- (BOOL)deleteWithType:(NSString *)type {
    __block BOOL result;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        GALog(@"delete--->start--->type:%@", type);
        result = [db executeUpdate:@"delete from 'table_statistic' where type = ?" withArgumentsInArray:@[type]];
        GALog(@"delete--->end--->result:%d--->type:%@", result, type);
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return result;
}

- (BOOL)updateModel:(id)model withType:(NSString *)type {
    __block BOOL result;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        GALog(@"upload--->start--->type:%@,paramsString:%@", type, [model ga_modelToJSONString]);
        result = [db executeUpdate:@"update 'table_statistic' set paramsString = ? where type = ?" withArgumentsInArray:@[[model ga_modelToJSONString], type]];
        GALog(@"upload--->end--->result:%d--->type:%@,paramsString:%@", result, type, [model ga_modelToJSONString]);
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return result;
}

- (BOOL)updateModel:(id)model withID:(NSInteger)ID {
    __block BOOL result;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        GALog(@"upload--->start--->ID:%ld,paramsString:%@", (long)ID, [model ga_modelToJSONString]);
        result = [db executeUpdate:@"update 'table_statistic' set paramsString = ? where ID = ?" withArgumentsInArray:@[[model ga_modelToJSONString], @(ID)]];
        GALog(@"upload--->end--->result:%d--->ID:%ld,paramsString:%@", result, (long)ID, [model ga_modelToJSONString]);
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return result;
}

- (NSArray<id> *)selectId:(NSInteger)ID {
    __block NSMutableArray *mArr = @[].mutableCopy;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        GALog(@"select--->start--->ID:%ld", (long)ID);
        FMResultSet *result = [db executeQuery:@"select * from 'table_statistic' where ID = ?" withArgumentsInArray:@[@(ID)]];
        while ([result next]) {
            NSString *type = [result stringForColumn:@"type"];
            NSObject *model = [NSClassFromString(type) ga_modelWithJSON:[result stringForColumn:@"paramsString"]];
            model.fmbdId = [result intForColumn:@"ID"];
            [mArr addObject:model];
            GALog(@"select--->item--->type:%@,paramsString:%@", type, [result stringForColumn:@"paramsString"]);
        }
        GALog(@"select--->end--->ID:%ld", (long)ID);
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return mArr.copy;
}

- (NSArray<id> *)selectType:(NSString *)type {
    __block NSMutableArray *mArr = @[].mutableCopy;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        GALog(@"select--->start--->type:%@", type);
        FMResultSet *result = [db executeQuery:@"select * from 'table_statistic' where type = ?" withArgumentsInArray:@[type]];
        while ([result next]) {
            NSObject *model = [NSClassFromString(type) ga_modelWithJSON:[result stringForColumn:@"paramsString"]];
            model.fmbdId = [result intForColumn:@"ID"];
            [mArr addObject:model];
            GALog(@"select--->item--->type:%@,paramsString:%@", type, [result stringForColumn:@"paramsString"]);
        }
        GALog(@"select--->end--->type:%@", type);
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return mArr.copy;
}

- (NSArray<id> *)selectall {
    __block NSMutableArray *mArr = @[].mutableCopy;
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        GALog(@"select--->start--->all");
        FMResultSet *result = [db executeQuery:@"select * from 'table_statistic'"];
        while ([result next]) {
            NSString *type = [result stringForColumn:@"type"];
            NSObject *model = [NSClassFromString(type) ga_modelWithJSON:[result stringForColumn:@"paramsString"]];
            model.fmbdId = [result intForColumn:@"ID"];
            [mArr addObject:model];
            GALog(@"select--->item--->type:%@,paramsString:%@", type, [result stringForColumn:@"paramsString"]);
        }
        GALog(@"select--->end--->all");
        dispatch_semaphore_signal(signal);
    }];
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return mArr.copy;
}

#pragma mark ---异步回调---
#pragma mark ---增加---
- (void)insertWithModel:(id)model complete:(void(^)(NSInteger ID))complete {
    __block NSInteger ID = -1;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        GALog(@"insert--->start--->type:%@,paramsString:%@", [model getType], [model ga_modelToJSONString]);
        dispatch_semaphore_t signal = dispatch_semaphore_create(0);
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            BOOL result = [db executeUpdate:@"insert into 'table_statistic' (type,paramsString) values(?,?)" withArgumentsInArray:@[[model getType], [model ga_modelToJSONString]]];
            if (result) {
                ID = (NSInteger)db.lastInsertRowId;
            }
            GALog(@"insert--->end--->ID:%ld--->type:%@,paramsString:%@", (long)ID, [model getType], [model ga_modelToJSONString]);
            dispatch_semaphore_signal(signal);
        }];
        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(ID);
            }
        });
    });
}

#pragma mark ---批量增加---
- (void)insertArray:(NSArray<id> *)array complete:(void (^)(NSArray * _Nullable))complete {
    if (array.count <= 0) {
        if (complete) {
            complete(nil);
        }
    }
    __block NSMutableArray *ids = @[].mutableCopy;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_t signal = dispatch_semaphore_create(0);
        [self.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
            GALog(@"insertArray--->start");
            for (int i = 0; i < array.count; i ++) {
                NSInteger ID;
                id model = array[i];
                GALog(@"insert--->start--->type:%@,paramsString:%@", [model getType], [model ga_modelToJSONString]);
                BOOL result = [db executeUpdate:@"insert into 'table_statistic' (type,paramsString) values(?,?)" withArgumentsInArray:@[[model getType], [model ga_modelToJSONString]]];
                GALog(@"insert--->end--->ID:%lld--->type:%@,paramsString:%@", db.lastInsertRowId, [model getType], [model ga_modelToJSONString]);
                if (!result) {
                    *rollback = YES;
                    ids = nil;
                    break;
                }
                ID = (NSInteger)db.lastInsertRowId;
                [ids addObject:@(ID)];
            }
            GALog(@"insertArray--->end--->rollback:%d", *rollback);
            dispatch_semaphore_signal(signal);
        }];
        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(ids);
            }
        });
    });
}

#pragma mark ---删---
- (void)deleteId:(NSInteger)ID complete:(void (^)(BOOL))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block BOOL result;
        dispatch_semaphore_t signal = dispatch_semaphore_create(0);
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            GALog(@"delete--->start--->ID:%ld", (long)ID);
            result = [db executeUpdate:@"delete from 'table_statistic' where ID = ?" withArgumentsInArray:@[@(ID)]];
            GALog(@"delete--->end--->result:%d--->ID:%ld", result, (long)ID);
            dispatch_semaphore_signal(signal);
        }];
        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(result);
            }
        });
    });
}

- (void)deleteWithType:(NSString *)type complete:(void (^)(BOOL))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block BOOL result;
        dispatch_semaphore_t signal = dispatch_semaphore_create(0);
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            GALog(@"delete--->start--->type:%@", type);
            result = [db executeUpdate:@"delete from 'table_statistic' where type = ?" withArgumentsInArray:@[type]];
            GALog(@"delete--->end--->result:%d--->type:%@", result, type);
            dispatch_semaphore_signal(signal);
        }];
        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(result);
            }
        });
    });
}

#pragma mark ---批量删除---
- (void)deleteIds:(NSArray *)ids complete:(void (^)(BOOL))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block BOOL isSuccess = YES;
        dispatch_semaphore_t signal = dispatch_semaphore_create(0);
        [self.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
            GALog(@"deleteArray--->start");
            for (NSNumber *ID in ids) {
                GALog(@"delete--->start--->ID:%ld", (long)[ID integerValue]);
                BOOL result = [db executeUpdate:@"delete from 'table_statistic' where ID = ?" withArgumentsInArray:@[ID]];
                GALog(@"delete--->end--->result:%d--->ID:%ld", result, (long)[ID integerValue]);
                if (!result) {
                    *rollback = YES;
                    isSuccess = NO;
                    break;
                }
            }
            GALog(@"deleteArray--->end--->rollBack:%d", *rollback);
            dispatch_semaphore_signal(signal);
        }];
        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(isSuccess);
            }
        });
    });
}

#pragma mark ---修改---
- (void)updateModel:(id)model withType:(NSString *)type complete:(void (^)(BOOL))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block BOOL result;
        dispatch_semaphore_t signal = dispatch_semaphore_create(0);
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            GALog(@"upload--->start--->type:%@,paramsString:%@", type, [model ga_modelToJSONString]);
            result = [db executeUpdate:@"update 'table_statistic' set paramsString = ? where type = ?" withArgumentsInArray:@[[model ga_modelToJSONString], type]];
            GALog(@"upload--->end--->result:%d--->type:%@,paramsString:%@", result, type, [model ga_modelToJSONString]);
            dispatch_semaphore_signal(signal);
        }];
        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(result);
            }
        });
    });
}

- (void)updateModel:(id)model withID:(NSInteger)ID complete:(void (^)(BOOL))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block BOOL result;
        dispatch_semaphore_t signal = dispatch_semaphore_create(0);
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            GALog(@"upload--->start--->ID:%ld,paramsString:%@", (long)ID, [model ga_modelToJSONString]);
            result = [db executeUpdate:@"update 'table_statistic' set paramsString = ? where ID = ?" withArgumentsInArray:@[[model ga_modelToJSONString], @(ID)]];
            GALog(@"upload--->end--->result:%d--->ID:%ld,paramsString:%@", result, (long)ID, [model ga_modelToJSONString]);
            dispatch_semaphore_signal(signal);
        }];
        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(result);
            }
        });
    });
}

#pragma mark ---查询---
- (void)selectId:(NSInteger)ID complete:(void (^)(NSArray<id> * _Nullable))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block NSMutableArray *mArr = @[].mutableCopy;
        dispatch_semaphore_t signal = dispatch_semaphore_create(0);
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            GALog(@"select--->start--->ID:%ld", (long)ID);
            FMResultSet *result = [db executeQuery:@"select * from 'table_statistic' where ID = ?" withArgumentsInArray:@[@(ID)]];
            while ([result next]) {
                NSString *type = [result stringForColumn:@"type"];
                NSObject *model = [NSClassFromString(type) ga_modelWithJSON:[result stringForColumn:@"paramsString"]];
                model.fmbdId = [result intForColumn:@"ID"];
                [mArr addObject:model];
                GALog(@"select--->item--->type:%@,paramsString:%@", type, [result stringForColumn:@"paramsString"]);
            }
            GALog(@"select--->end--->ID:%ld", (long)ID);
            dispatch_semaphore_signal(signal);
        }];
        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(mArr.copy);
            }
        });
    });
}

- (void)selectType:(NSString *)type complete:(void (^)(NSArray<id> * _Nullable))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block NSMutableArray *mArr = @[].mutableCopy;
        dispatch_semaphore_t signal = dispatch_semaphore_create(0);
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            GALog(@"select--->start--->type:%@", type);
            FMResultSet *result = [db executeQuery:@"select * from 'table_statistic' where type = ?" withArgumentsInArray:@[type]];
            while ([result next]) {
                NSObject *model = [NSClassFromString(type) ga_modelWithJSON:[result stringForColumn:@"paramsString"]];
                model.fmbdId = [result intForColumn:@"ID"];
                [mArr addObject:model];
                GALog(@"select--->item--->type:%@,paramsString:%@", type, [result stringForColumn:@"paramsString"]);
            }
            GALog(@"select--->end--->type:%@", type);
            dispatch_semaphore_signal(signal);
        }];
        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(mArr.copy);
            }
        });
    });
}

- (void)selectallWithComplete:(void (^)(NSArray<id> * _Nullable))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block NSMutableArray *mArr = @[].mutableCopy;
        dispatch_semaphore_t signal = dispatch_semaphore_create(0);
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            GALog(@"select--->start--->all");
            FMResultSet *result = [db executeQuery:@"select * from 'table_statistic'"];
            while ([result next]) {
                NSString *type = [result stringForColumn:@"type"];
                NSObject *model = [NSClassFromString(type) ga_modelWithJSON:[result stringForColumn:@"paramsString"]];
                model.fmbdId = [result intForColumn:@"ID"];
                
                [mArr addObject:model];
                GALog(@"select--->item--->type:%@,paramsString:%@", type, [result stringForColumn:@"paramsString"]);
            }
            GALog(@"select--->end--->all");
            dispatch_semaphore_signal(signal);
        }];
        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(mArr.copy);
            }
        });
    });
}

@end
