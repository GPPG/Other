//
//  GPHorizontalItemList.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/4/7.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "GPHorizontalItemListView.h"

@interface GPHorizontalItemListView()
@property (nonatomic, strong) UIView *supview;

@end


@implementation GPHorizontalItemListView

#define buttonWidth 60
#define padding 10

- (instancetype)initWithView:(UIView *)view
{
    if (self = [super init]) {
        self.supview = view;
        [self setupView];
        [self addSubView];
    }
    return self;
}

- (void)setupView
{
    CGRect rect = CGRectMake(self.supview.width, 120, self.supview.width, 80);
    self.frame = rect;
    self.alpha = 0.0;
    self.contentSize = CGSizeMake(padding * buttonWidth, buttonWidth + 2 * padding);
}
- (void)addSubView
{
    for (int i = 0; i < 10; i ++) {
        
        [self addSubview:({
            NSString *tempStr = [NSString stringWithFormat:@"summericons_100px_0%d",i];
            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:tempStr]];
            imageView.center = CGPointMake(i * buttonWidth + buttonWidth * 0.5, buttonWidth * 0.5);
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapImage:)];
            [imageView addGestureRecognizer:tap];
            imageView;
        })];
    }
}

- (void)didTapImage:(UITapGestureRecognizer *)tap
{
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(tap.view.tag);
    }
}
- (void)didMoveToSuperview
{
    [UIView animateWithDuration:1.0 delay:0.01 usingSpringWithDamping:0.5 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 1.0;
        self.centerX -= self.width;
    } completion:nil];
}
@end
