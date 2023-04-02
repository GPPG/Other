//
//  UIView+HXExtension.h
//  照片选择器
//
//  Created by 洪欣 on 17/2/16.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>

#define hxBottomMargin (HX_IS_IPhoneX_All ? 34 : 0)

#define HX_IS_IPhoneX_All (HX_Is_iPhoneX || HX_Is_iPhoneXR || HX_Is_iPhoneXS || HX_Is_iPhoneXS_MAX || HX_IS_IPHONEX)

#define HX_UI_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 判断iPhone X
#define HX_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iPHoneXr
#define HX_Is_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !HX_UI_IS_IPAD : NO)

//判断iPHoneXs
#define HX_Is_iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !HX_UI_IS_IPAD : NO)

//判断iPhoneXs Max
#define HX_Is_iPhoneXS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !HX_UI_IS_IPAD : NO)


#define HX_IS_IPHONEX (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896)) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(896, 414)))

@class HXPhotoManager;
@interface UIView (HXExtension)

@property (assign, nonatomic) CGFloat hx_x;
@property (assign, nonatomic) CGFloat hx_y;
@property (assign, nonatomic) CGFloat hx_w;
@property (assign, nonatomic) CGFloat hx_h;
@property (assign, nonatomic) CGFloat hx_centerX;
@property (assign, nonatomic) CGFloat hx_centerY;
@property (assign, nonatomic) CGSize hx_size;
@property (assign, nonatomic) CGPoint hx_origin;

@end
