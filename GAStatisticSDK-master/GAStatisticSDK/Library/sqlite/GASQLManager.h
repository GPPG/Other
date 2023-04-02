//
//  GASQLManager.h
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/17.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "GAStudentModel.h"

@interface GASQLManager : NSObject {

    sqlite3 * db;
}

+(GASQLManager *)shareManager;

//插入
-(int)insert:(GAStudentModel *)model;

//删除
-(void)remove:(NSString *)idNum;


//修改
- (void)modify:(GAStudentModel *)model idNum:(NSString*)idNum ;

//查询
- (GAStudentModel *)searchWithIDNum:(GAStudentModel *)model;

//查询全部
- (NSArray *)searchArray;


@end


