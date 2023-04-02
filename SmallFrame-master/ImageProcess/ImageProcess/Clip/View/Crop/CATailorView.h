//
//  CATailorView.h
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/24.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Clip.h"
NS_ASSUME_NONNULL_BEGIN

@interface CATailorView : UIView


@property (strong, nonatomic) UIImageView *bgImageView;

@property (nonatomic, strong) UIImage *originalImage;

- (void)resizeWHScale:(CGFloat)width height:(CGFloat)height;

- (void)rotateClick;

- (void)verticalFlipAction;

- (UIImage *)getTailorImage;

- (CGRect)getTailorImageRect;

- (CGRect)getCurrentShowImageFrame;

- (UIImage *)getCurrentShowImage;

@end

NS_ASSUME_NONNULL_END
