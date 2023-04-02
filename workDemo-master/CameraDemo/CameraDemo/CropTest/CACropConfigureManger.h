//
//  CACropConfigureManger.h
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/23.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CACropConfigureManger : NSObject
/**
 是否可移动的裁剪框
 */
@property (assign, nonatomic) BOOL movableCropBox;


/**
 可移动的裁剪框是否可以编辑大小
 */
@property (assign, nonatomic) BOOL movableCropBoxEditSize;

/**
 可移动裁剪框的比例 (w,h)
 一定要是宽比高哦!!!
 当 movableCropBox = YES && movableCropBoxEditSize = YES
 如果不设置比例即可自由编辑大小
 */
@property (assign, nonatomic) CGPoint movableCropBoxCustomRatio;


@end

NS_ASSUME_NONNULL_END
