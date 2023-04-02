//
//  GASQLManager.m
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/17.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import "GASQLManager.h"

#define kNameFile (@"Student.sqlite")

@implementation GASQLManager

//创建单例
static GASQLManager * manager = nil;

+ (GASQLManager *)shareManager {
    static dispatch_once_t once;
    dispatch_once(&once,^{
        manager = [[self alloc] init];
        [manager createDataBaseTableIfNeeded];
    });
    return manager;
}

//获取数据库的完整路径
- (NSString *)applicationDocumentsDirectoryFile {
    NSArray * paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [paths firstObject];
    NSString * filePath = [documentDirectory stringByAppendingPathComponent:kNameFile];
    return filePath;
}

//再定义一个函数，接下来的操作是创建数据库，在进行数据库操作之前，确保数据库存在，不存在的时候必须要进行创建
- (void)createDataBaseTableIfNeeded {
    NSString * writetablePath =[self applicationDocumentsDirectoryFile];
    GALog(@"数据库的地址是：%@",writetablePath);
    //打开数据库
    
    //第一个参数数据库文件所在的完整路径
    //第二个参数是数据库 DataBase 对象
    if (sqlite3_open([writetablePath UTF8String], &db) != SQLITE_OK) {
        //失败 数据库关闭
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败！");//抛出错误信息
    } else {
        //成功
        char * err;
        NSString * createSQL =[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS StudentName (idNum TEXT PRIMARYKEY, name TEXT);"];
        //SQLite的执行函数
        /*
         第一个参数 db对象
         第二个参数 语句
         第三个和第四个参数 回调函数和回调函数参数
         第五个参数 是一个错误信息
         */
        if (sqlite3_exec(db, [createSQL UTF8String], NULL, NULL, &err) !=SQLITE_OK) {
            //失败 数据库关闭
            sqlite3_close(db);
            NSAssert1(NO, @"建表失败！%s", err);//抛出错误信息
        }
        sqlite3_close(db);
    }
}

//增
- (int)insert:(GAStudentModel *)model {
    if ([self openDb]) {
        NSString * sql =@"INSERT OR REPLACE INTO StudentName (idNum, name) VALUES (?,?)";
        sqlite3_stmt * statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL) ==SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [model.idNum UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.name UTF8String], -1, NULL);
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSAssert(NO, @"插入数据失败!");
            }
            sqlite3_finalize(statement);
            sqlite3_close(db);
        }
    }
    return 0;
}


//删除
- (void)remove:(NSString *)idNum {
    /*
     第一步 sqlite3_open 打开数据库
     第二步 sqlite3_prepare_v2 预处理 SQL 语句操作
     第三步 sqlite3_bind_text 函数绑定参数
     第四步 sqlite3_step 函数执行 SQL 语句
     第五步 sqlite3_finalize 和 sqlite3_close 释放资源
     */
    if ([self openDb]) {
        NSString * sql =@"DELETE FROM StudentName where idNum = ?";
        sqlite3_stmt * statement;
        //预处理
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL) ==SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [idNum UTF8String], -1, NULL);
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSAssert(NO, @"删除数据失败!");
            }
            sqlite3_finalize(statement);
            sqlite3_close(db);
        }
    }
}


- (void)modify:(GAStudentModel *)model idNum:(NSString*)idNum {
    if ([self openDb]) {
        NSString * sql = @"update StudentName set  idNum = ? ,name = ? where idNum = ?";
        sqlite3_stmt * statement;
        //预处理
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL) ==SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [model.idNum UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.name UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [idNum UTF8String], -1, NULL);
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSAssert(NO, @"更新数据失败!");
            }
            sqlite3_finalize(statement);
            sqlite3_close(db);
        }
    }
}


- (GAStudentModel *)searchWithIDNum:(NSString *)idNum {
    if ([self openDb]) {
        NSString * qsql =@"SELECT idNum,name FROM StudentName where idNum = ?";
        sqlite3_stmt * statement;//语句对象
        //第一个参数：数据库对象
        //第二个参数：SQL语句
        //第三个参数：执行语句的长度 -1是指全部长度
        //第四个参数：语句对象
        //第五个参数：没有执行的语句部分 NULL
        
        //预处理
        if(sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) ==SQLITE_OK){
            //进行 按主键查询数据库
            //第一个参数 语句对象
            //第二个参数 参数开始执行的序号
            //第三个参数 我们要绑定的值
            //第四个参数 绑定的字符串的长度
            //第五个参数 指针 NULL
            //绑定
            sqlite3_bind_text(statement, 1, [idNum UTF8String], -1, NULL);
            //遍历结果集
            /*
             有一个返回值 SQLITE_ROW常量代表查出来了
             */
            if (sqlite3_step(statement) == SQLITE_ROW) {
                //提取数据
                /*
                 第一个：语句对象
                 第二个：字段的索引
                 */
                char * idNum = (char *)sqlite3_column_text(statement, 0);
                //数据转化
                NSString * idNumStr =[[NSString alloc]initWithUTF8String:idNum];
                
                char * name =(char *)sqlite3_column_text(statement, 1);
                NSString * nameStr =[[NSString alloc]initWithUTF8String:name];
                
                GAStudentModel * model =[[GAStudentModel alloc] init];
                model.idNum = idNumStr;
                model.name = nameStr;
                
                //释放
                sqlite3_finalize(statement);
                sqlite3_close(db);
                return model;
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return nil;
}


- (NSArray *)searchArray {
    NSMutableArray *array = [NSMutableArray array];
    
    if ([self openDb]) {
        NSString * qsql =@"SELECT idNum,name FROM StudentName";
        sqlite3_stmt * statement;//语句对象
        
        if(sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) ==SQLITE_OK){
            sqlite3_bind_text(statement, 1, NULL, -1, NULL);
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char * idNum = (char *)sqlite3_column_text(statement, 0);
                //数据转化
                NSString * idNumStr =[[NSString alloc]initWithUTF8String:idNum];
                
                char * name =(char *)sqlite3_column_text(statement, 1);
                NSString * nameStr =[[NSString alloc]initWithUTF8String:name];
                
                GAStudentModel * model =[[GAStudentModel alloc] init];
                model.idNum = idNumStr;
                model.name = nameStr;
                [array addObject:model];
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
        return array;
    }
    return nil;
}

- (BOOL)openDb {
    NSString * path =[self applicationDocumentsDirectoryFile];
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"打开数据库失败!");
        return false;
    }
    return true;
}




@end
