//
//  CACropView.h
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/23.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CACropConfigureManger.h"

NS_ASSUME_NONNULL_BEGIN

@interface CACropView : UIView

@property (strong, nonatomic) UIImageView *bgImageView;

@property (nonatomic, strong) CACropConfigureManger *manger;

@property (strong, nonatomic, readonly) UIImage *originalImage;

- (UIImage *)getCurrentImage;

- (CGRect)getImageFrame;

- (UIImage *)editImage;

- (instancetype)initWith:(CACropConfigureManger *)manger tailoringImage:(UIImage *)tailoringImage;

- (void)setWidth:(CGFloat)W height:(CGFloat)H;

@end

NS_ASSUME_NONNULL_END
