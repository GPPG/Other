//
//  FITSetMindWeekView.h
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/10.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^NoChoiceWeekBlock)(BOOL choiceState);

@interface FITSetMindWeekView : UIView



@property (nonatomic, strong) NSMutableArray *weekdayStateArray;

@property (nonatomic, copy) NSString *statisticalStr;

@property (nonatomic, copy) NoChoiceWeekBlock noChoiceWeekBlock;


@end
