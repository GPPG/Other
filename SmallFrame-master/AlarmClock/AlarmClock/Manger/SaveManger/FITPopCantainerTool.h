//
//  FITPopCantainerTool.h
//  popView
//
//  Created by 郭鹏 on 2018/8/1.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^PopCompleteBlock)(void);

typedef void(^PopDismissBlock)(void);




@interface FITPopCantainerTool : NSObject

- (instancetype)initWithSuperController:(UIViewController *)superController popController:(UIViewController *)popController;

- (void)popup:(PopCompleteBlock)popCompleteBlock;

- (void)disappear:(PopDismissBlock)popDismissBlock;

// 是否遮挡导航栏
@property (nonatomic, assign) BOOL hideNavigationBar;

// 点击空白页是否退出
@property (nonatomic, assign) BOOL blankExit;

@end
