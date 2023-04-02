//
//  GAFMDBTool.h
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/17.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GAFMDBTool : NSObject

+ (instancetype)shareManager;

//增
- (NSInteger)insertWithModel:(id)model;
- (void)insertWithModel:(id)model complete:(void(^ __nullable)(NSInteger ID))complete;

//批量增加
- (NSArray *)insertArray:(NSArray <id>*)array;
- (void)insertArray:(NSArray <id>*)array complete:(void(^ __nullable)(NSArray * _Nullable arr))complete;

//删
- (BOOL)deleteId:(NSInteger)ID;
- (BOOL)deleteWithType:(NSString *)type;
- (void)deleteId:(NSInteger)ID complete:(void(^ __nullable)(BOOL success))complete;
- (void)deleteWithType:(NSString *)type complete:(void(^ __nullable)(BOOL success))complete;

//批量删除
- (BOOL)deleteIds:(NSArray *)ids;
- (void)deleteIds:(NSArray *)ids complete:(void(^ __nullable)(BOOL success))complete;

//改
- (BOOL)updateModel:(id)model withType:(NSString *)type;
- (BOOL)updateModel:(id)model withID:(NSInteger)ID;
- (void)updateModel:(id)model withType:(NSString *)type complete:(void(^ __nullable)(BOOL success))complete;
- (void)updateModel:(id)model withID:(NSInteger)ID complete:(void(^ __nullable)(BOOL success))complete;

//查
- (NSArray<id> *)selectId:(NSInteger)ID;
- (NSArray<id> *)selectType:(NSString *)type;
- (NSArray<id> *)selectall;
- (void)selectId:(NSInteger)ID complete:(void(^ __nullable)(NSArray<id> * _Nullable arr))complete;
- (void)selectType:(NSString *)type complete:(void(^ __nullable)(NSArray<id> * _Nullable arr))complete;
- (void)selectallWithComplete:(void(^ __nullable)(NSArray<id> * _Nullable arr))complete;


@end

