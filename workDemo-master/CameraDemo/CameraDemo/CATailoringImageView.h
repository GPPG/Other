//
//  CATailoringImageView.h
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/22.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^TailoringCompleteBlock)(UIImage * _Nullable resizeImage);
NS_ASSUME_NONNULL_BEGIN

@interface CATailoringImageView : UIView

- (instancetype)initWithOriginalImage:(UIImage *)originalImage;


- (void)resizeWHScale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
