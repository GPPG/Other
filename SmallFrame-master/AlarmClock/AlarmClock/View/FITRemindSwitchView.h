//
//  FITRemindSwitchView.h
//  fitness
//
//  Created by 郭鹏 on 2018/10/10.
//  Copyright © 2018 supergeek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SwitchActionBlock)(BOOL switchState);

@interface FITRemindSwitchView : UIView

@property (nonatomic, copy) SwitchActionBlock switchActionBlock;

@property (nonatomic, assign) BOOL switchStatus;

@end
