//
//  GPShapeViewController.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/4/18.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "GPShapeViewController.h"
#import "GPAvatarView.h"

@interface GPShapeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *vsLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchAgainBtn;
@property (weak, nonatomic) IBOutlet GPAvatarView *myAvatar;
@property (weak, nonatomic) IBOutlet GPAvatarView *opponentAvatar;
- (IBAction)searchAgainBtnClick:(UIButton *)sender;
@end

@implementation GPShapeViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupAnimated];
}
#pragma mark - 初始化
- (void)setupView
{
    self.myAvatar.name = @"我";
    self.myAvatar.image = [UIImage imageNamed:@"avatar-1"];
    self.opponentAvatar.name = @"一剑飞仙";
    self.opponentAvatar.image = [UIImage imageNamed:@"empty"];
}
- (void)setupAnimated
{
    CGSize avatarSize = self.myAvatar.size;
    CGFloat bounceXOffset = avatarSize.width / 1.9;
    CGSize morphSize = CGSizeMake(avatarSize.width * 0.85, avatarSize.height * 1.1);
    CGPoint rightBouncePoint = CGPointMake(self.view.width * 0.5 + bounceXOffset, self.myAvatar.center.y);
    CGPoint leftBouncePoint = CGPointMake(self.view.width * 0.5 - bounceXOffset, self.myAvatar.center.y);
    [self.myAvatar bounceOff:rightBouncePoint morphSize:morphSize];
    [self.opponentAvatar bounceOff:leftBouncePoint morphSize:morphSize];
}
#pragma mark - 内部方法
- (IBAction)searchAgainBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
