//
//  CACorpGridLayer.h
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/23.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CACorpGridLayer : UIView

@property (nonatomic, assign) CGRect clippingRect;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *gridColor;



@end

NS_ASSUME_NONNULL_END
