//
//  GPAvatarView.h
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/4/18.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPAvatarView : UIView
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, strong)  UIImage *image;
- (void)bounceOff:(CGPoint)point morphSize:(CGSize)morphSize;
@end
