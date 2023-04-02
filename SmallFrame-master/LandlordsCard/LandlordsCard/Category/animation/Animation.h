//
//  Animation.h
//  UIDynamicDemo
//
//  Created by 李亚洲 on 2018/12/18.
//  Copyright © 2018 李亚洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Animation : NSObject

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat begainTime;
@property (nonatomic, assign) CGFloat repeatCount;
@property (nonatomic, assign) BOOL isRear;
@end

NS_ASSUME_NONNULL_END
