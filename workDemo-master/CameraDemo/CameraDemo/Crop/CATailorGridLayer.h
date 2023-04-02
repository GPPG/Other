//
//  CATailorGridLayer.h
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/24.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CATailorGridLayer : UIView

@property (nonatomic, assign) CGRect clippingRect;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *gridColor;

@end

NS_ASSUME_NONNULL_END
