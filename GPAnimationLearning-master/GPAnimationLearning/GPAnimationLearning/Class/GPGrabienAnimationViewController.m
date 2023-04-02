//
//  GPGrabienAnimationViewController.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/5/16.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "GPGrabienAnimationViewController.h"
#import "GPAnimatedMaskLabelView.h"

@interface GPGrabienAnimationViewController()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLabelTopLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;
@property (weak, nonatomic) IBOutlet GPAnimatedMaskLabelView *animatedView;
@end


@implementation GPGrabienAnimationViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.animatedView.textStr = @"滑动解锁";
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didSlider)];
    [self.animatedView addGestureRecognizer:swipe];
}
- (void)didSlider
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"meme"]];
    imageView.center = self.view.center;
    imageView.centerX += self.view.width;
    [self.view addSubview:imageView];
    
    self.topLabelTopLayout.constant -= 200;
    self.bottomLayout.constant -= 200;
    [UIView animateWithDuration:0.33 animations:^{
        [self.view layoutIfNeeded];
        imageView.centerX -= self.view.width;
    }];
    
    self.topLabelTopLayout.constant += 200;
    self.bottomLayout.constant += 200;
    [UIView animateWithDuration:0.33 delay:1.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self.view layoutIfNeeded];
        imageView.centerX += self.view.width;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

@end
