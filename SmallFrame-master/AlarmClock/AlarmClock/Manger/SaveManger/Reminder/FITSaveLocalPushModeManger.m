//
//  FITSaveLocalPushModeManger.m
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/8.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import "FITSaveLocalPushModeManger.h"
#import "FITLocalNotificationTool.h"
#import "FITLocalPushMode.h"
#import "NSDate+JKUtilities.h"


@implementation FITSaveLocalPushModeManger

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

//- (void)saveLocalNotification:(UILocalNotification *)localNotification indexPath:(NSIndexPath *)indexPath{
//    
//    
//    [self setupPushMode];
//    
//    FITSaveLocalPushTotalMode *pushMode = [FITSaveLocalPushModeTool pushMode];
//    
//    FITSaveLocalPushMode *mode = [[FITSaveLocalPushMode alloc]init];
//    mode.localNotification = localNotification;
//
//    [pushMode.alarmTotalArray[indexPath.section].alarmSubArray addObject:mode];
//    
//    [FITSaveLocalPushModeTool savePushMode:pushMode];
//    
//}

// 获取一个 FITSaveLocalPushMode
- (FITSaveLocalPushMode *)getSaveLocalPushMode:(UILocalNotification *)localNotification localState:(BOOL)localState{
    
    FITSaveLocalPushMode *mode = [[FITSaveLocalPushMode alloc]init];
    mode.localNotification = localNotification;
    mode.localNotificationState = localState;
    return mode;
}

// 获取一组 FITSaveLocalPushMode
- (NSMutableArray *)getSaveLocalPushModeS:(NSArray <UILocalNotification  *> *)localNotificationS localState:(NSArray *)localStateArray{
    

    NSMutableArray *tempArray = [NSMutableArray array];
    
    [localNotificationS enumerateObjectsUsingBlock:^(UILocalNotification * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL localState;
        if (localStateArray.count == 0) {
            localState = YES;
        }else{
            localState = [localStateArray[idx] integerValue];
        }
        
        FITSaveLocalPushMode *mode = [self getSaveLocalPushMode:obj localState:localState];
        [tempArray addObject:mode];
    }];
    return tempArray;
}

// 添加一组本地闹钟 (默认全部循环)
- (void)addLocalNotificationS:(NSArray <UILocalNotification *>*)localArray{
    
    [self addLocalNotificationS:localArray selectWeekday:nil];
}

// 添加一组本地通知 (自定义开启循环天数)
- (void)addLocalNotificationS:(NSArray <UILocalNotification *>*)localArray selectWeekday:(NSArray *)selectArray{
    
    [self setupPushMode];
    
    
    FITSaveLocalPushTotalMode *pushMode = [FITSaveLocalPushModeTool pushMode];
    
    
    FITSaveLocalPushSubTotalMode *pushSubMode = [[FITSaveLocalPushSubTotalMode alloc]init];
    
    pushSubMode.alarmSubArray = [self getSaveLocalPushModeS:localArray localState:selectArray];
    
    pushSubMode.switchState = YES;
    
    [pushMode.alarmTotalArray addObject:pushSubMode];
    
    [FITSaveLocalPushModeTool savePushMode:pushMode];
    
    NSArray *tempArray = [self getOnLocalNotification:pushSubMode];
    
    NSArray *str = [pushMode yy_modelToJSONObject];
    NSLog(@"数组:%@",str);

    // 通知刷新UI
    if (self.addNotificationSBlcok) {
        self.addNotificationSBlcok(tempArray);
    }
}

// 删除一组本地闹钟
- (void)deleteLocalNotificationS:(NSInteger)section{
    
    FITSaveLocalPushTotalMode *pushMode = [FITSaveLocalPushModeTool pushMode];
    
    FITSaveLocalPushSubTotalMode *subTotalMode = pushMode.alarmTotalArray[section];
    
    NSArray *tempArray = [self getOnLocalNotification:subTotalMode];
    
    [pushMode.alarmTotalArray removeObjectAtIndex:section];
    
    [FITSaveLocalPushModeTool savePushMode:pushMode];
    
    // 通知刷新UI
    if (self.deleteNotificationSBlcok) {
        self.deleteNotificationSBlcok(tempArray);
    }
}

- (void)deleteLocalNotificationAll{
    
    FITSaveLocalPushTotalMode *pushMode = [FITSaveLocalPushModeTool pushMode];

    [pushMode.alarmTotalArray removeAllObjects];
    
    [FITSaveLocalPushModeTool savePushMode:pushMode];

    // 通知刷新UI
    if (self.deleteNotificationAllBlcok) {
        self.deleteNotificationAllBlcok();
    }
}

// 更新一组闹钟开关
- (void)updateLocalNotificationSwitchStateSection:(NSInteger )index switchState:(BOOL)switchState{
    
    FITSaveLocalPushTotalMode *pushMode = [FITSaveLocalPushModeTool pushMode];
    
    FITSaveLocalPushSubTotalMode *subMode = pushMode.alarmTotalArray[index];
    
    subMode.switchState = switchState;
    
    [FITSaveLocalPushModeTool savePushMode:pushMode];
    
    // 通知刷新UI
    NSMutableArray *onTempArray = [self getOnLocalNotification:subMode];

    if (self.updateLocalNotificationSectionSwitchBlock) {
        self.updateLocalNotificationSectionSwitchBlock([onTempArray copy], switchState);
    }
}

// 更新一组触发时间和选择循环
- (void)updateLocalNotificationStrikeTime:(NSInteger)section hour:(NSInteger)hour min:(NSInteger)min selectStateArray:(NSArray *)selectArray{
    
    FITSaveLocalPushTotalMode *pushMode = [FITSaveLocalPushModeTool pushMode];
    
    FITSaveLocalPushSubTotalMode *subMode = pushMode.alarmTotalArray[section];
    
    NSMutableArray *onOldArray = [self getOnLocalNotification:subMode];

    NSMutableArray *tempArray = [NSMutableArray array];
    
    [subMode.alarmSubArray enumerateObjectsUsingBlock:^(FITSaveLocalPushMode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        FITLocalPushMode *pushMode = [[FITLocalPushMode alloc]init];
        pushMode.localTitle = obj.localNotification.alertTitle;
        pushMode.localContent = obj.localNotification.alertBody;
        pushMode.localweekday = obj.localNotification.fireDate.jk_weekday;
        pushMode.localHour = hour;
        pushMode.localMin = min;
        
        [tempArray addObject:pushMode];
    }];
    
    NSArray *array =  [FITLocalNotificationTool creationLocalLocalNotifictionS:tempArray];
    
    NSMutableArray *savelocalPushModeArray = [self getSaveLocalPushModeS:array localState:selectArray];
    
    subMode.alarmSubArray = savelocalPushModeArray;

    [FITSaveLocalPushModeTool savePushMode:pushMode];
    
    NSMutableArray *onNewArray = [NSMutableArray array];
    
    if (subMode.switchState) {
        onNewArray = [self getOnLocalNotification:subMode];
    }

    if (self.updateLocalNotificationStrikeTimeBlock) {
        self.updateLocalNotificationStrikeTimeBlock(onOldArray,onNewArray);
    }
}

// 返回本地全部的通知
- (NSArray <UILocalNotification *>*)getSaveTotalLocalNOtification{
    
    NSMutableArray *tempArray = [NSMutableArray array];

    FITSaveLocalPushTotalMode *pushMode = [FITSaveLocalPushModeTool pushMode];

    [pushMode.alarmTotalArray enumerateObjectsUsingBlock:^(FITSaveLocalPushSubTotalMode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [obj.alarmSubArray enumerateObjectsUsingBlock:^(FITSaveLocalPushMode * _Nonnull pushMode, NSUInteger idx, BOOL * _Nonnull stop) {
            [tempArray addObject:pushMode.localNotification];
        }];
    }];
    
    return [tempArray copy];
    
}

/***********************************************************************************************************************/
// 更新一组星期选中的状态 (废弃接口)
- (void)updateLocalNotificationWeekdaySwitchState:(NSIndexPath *)indexPath localNotificationState:(BOOL)localNotificationState{
    
    FITSaveLocalPushTotalMode *pushMode = [FITSaveLocalPushModeTool pushMode];
    
    FITSaveLocalPushSubTotalMode *subMode = pushMode.alarmTotalArray[indexPath.section];
    
    FITSaveLocalPushMode *saveMode = subMode.alarmSubArray[indexPath.row];
    
    saveMode.localNotificationState = localNotificationState;
    
    [FITSaveLocalPushModeTool savePushMode:pushMode];
    
    // 通知刷新UI
    if (self.updateLocalNotificationWeekdaySelectBlock) {
        self.updateLocalNotificationWeekdaySelectBlock(saveMode.localNotification, saveMode.localNotificationState);
    }
}

#pragma mark - 内部方法
// 打开的通知
- (NSMutableArray *)getOnLocalNotification:(FITSaveLocalPushSubTotalMode *)SaveLocalPushSubTotalMode{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    [SaveLocalPushSubTotalMode.alarmSubArray enumerateObjectsUsingBlock:^(FITSaveLocalPushMode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.localNotificationState) {
            [tempArray addObject:obj.localNotification];
        }
    }];
    return [tempArray copy];
}

- (NSMutableArray *)getOffLocalNotification:(FITSaveLocalPushSubTotalMode *)SaveLocalPushSubTotalMode{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    [SaveLocalPushSubTotalMode.alarmSubArray enumerateObjectsUsingBlock:^(FITSaveLocalPushMode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (!obj.localNotificationState) {
            [tempArray addObject:obj.localNotification];
        }
    }];
    return [tempArray copy];
}

// 判断是否存在
- (void)setupPushMode{
    
    if ([FITSaveLocalPushModeTool pushMode] == nil) {
        
        FITSaveLocalPushTotalMode *pushMode = [[FITSaveLocalPushTotalMode alloc]init];
        pushMode.alarmTotalArray = [NSMutableArray array];
        [FITSaveLocalPushModeTool savePushMode:pushMode];
    }
}

#pragma clang diagnostic pop




@end

