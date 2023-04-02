//
//  GPViewAnimationViewController.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/3/31.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "GPViewAnimationViewController.h"
#import <CoreFoundation/CoreFoundation.h>

@interface GPViewAnimationViewController ()
// 控件
@property (weak, nonatomic) IBOutlet UIImageView *clound1;
@property (weak, nonatomic) IBOutlet UIImageView *clound2;
@property (weak, nonatomic) IBOutlet UIImageView *clound3;
@property (weak, nonatomic) IBOutlet UIImageView *clound4;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *passcodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, assign) CGPoint initialPoint;
// 控件约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tittleCenterYLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneCenterYLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passcodeCenterYLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnCenterYLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnCenterYYLayout;

// 动作
- (IBAction)loginBtnClick:(id)sender;

// 名称数组
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation GPViewAnimationViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupAnimation];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadAnimation];
}
#pragma mark - 初始化
- (void)setupView
{
    self.loginBtn.layer.cornerRadius = 10;
    self.loginBtn.layer.masksToBounds = YES;
    
    // 添加网络指示器
    [self.loginBtn addSubview:({
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.frame = CGRectMake(-50.0, 6.0, 20.0, 20.0);
        spinner.alpha = 0.0;
        [spinner startAnimating];
        self.spinner = spinner;
        spinner;
    })];
    
    // 添加登录提示背景
    [self.view addSubview:({
        UIImageView *statusImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"banner"]];
        statusImageView.hidden = YES;
        statusImageView.center = self.view.center;
        self.initialPoint = statusImageView.center;
        self.statusImageView = statusImageView;
        statusImageView;
    })];
    
    // 添加背景提示文字
    [self.statusImageView addSubview:({
        UILabel *statusLabel = [[UILabel alloc]init];
        statusLabel.textColor = [UIColor colorWithDisplayP3Red:0.89 green:0.38 blue:0.0 alpha:1.0];
        statusLabel.width = 100;
        statusLabel.height = 30;
        statusLabel.center = CGPointMake(self.statusImageView.width * 0.5, self.statusImageView.height * 0.5);
        statusLabel.font = [UIFont systemFontOfSize:18];
        self.statusLabel = statusLabel;
        statusLabel;
    })];
}
#pragma mark - 动画相关
- (void)setupAnimation
{
    self.phoneTextField.alpha = 0.0;
    self.passcodeTextField.alpha = 0.0;
    self.titleLabel.alpha = 0.0;
    
    self.tittleCenterYLayout.constant -= SCREEN_WIDTH;
    self.phoneCenterYLayout.constant -= SCREEN_WIDTH;
    self.passcodeCenterYLayout.constant -= SCREEN_WIDTH;
    self.loginBtnCenterYYLayout.constant += 30;
    
    self.loginBtn.alpha = 0.0;
    self.clound1.alpha = 0.0;
    self.clound2.alpha = 0.0;
    self.clound3.alpha = 0.0;
    self.clound4.alpha = 0.0;
    
}
- (void)loadAnimation
{
    self.phoneTextField.alpha = 1.0;
    self.passcodeTextField.alpha = 1.0;
    self.titleLabel.alpha = 1.0;
    
    // view 动画
    [UIView animateWithDuration:0.5 animations:^{
        self.tittleCenterYLayout.constant += SCREEN_WIDTH;
        [self.view layoutIfNeeded];
    }];
    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.phoneCenterYLayout.constant += SCREEN_WIDTH;
        [self.view layoutIfNeeded];
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.4 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.passcodeCenterYLayout.constant += SCREEN_WIDTH;
        [self.view layoutIfNeeded];
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.clound1.alpha = 1.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.7 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.clound2.alpha = 1.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.9 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.clound3.alpha = 1.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:1.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.clound4.alpha = 1.0;
    } completion:nil];
    
    // spring动画
    [UIView animateWithDuration:0.5 delay:0.4 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.loginBtn.alpha = 1.0;
        self.loginBtnCenterYYLayout.constant -= 30;
        [self.view layoutIfNeeded];
    } completion:nil];
    
    [self animateCloud:self.clound1];
    [self animateCloud:self.clound2];
    [self animateCloud:self.clound3];
    [self animateCloud:self.clound4];
}
- (void)showMessage:(NSInteger)messageInt
{
    self.statusLabel.text = self.titleArray[messageInt];
    [UIView transitionWithView:self.statusImageView duration:0.33 options:UIViewAnimationOptionCurveEaseOut & UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        self.statusImageView.hidden = NO;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (messageInt < self.titleArray.count - 1) {
                [self removeMessage:messageInt];
            }else{
                [self resetForm];
            }
        });
    }];
}

- (void)removeMessage:(NSInteger)messageInt
{
 
    [UIView animateWithDuration:0.33 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.statusImageView.centerX += SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        self.statusImageView.hidden = YES;
        self.statusImageView.center = self.initialPoint;
        [self showMessage:messageInt + 1];
    }];
}
- (void)resetForm
{
 
    [UIView transitionWithView:self.statusImageView duration:0.2 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        self.statusImageView.hidden = YES;
        self.statusImageView.center = self.initialPoint;
    } completion:nil];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.spinner.center = CGPointMake(-50, 6);
        self.spinner.alpha = 0.0;
        self.loginBtn.backgroundColor = [UIColor colorWithRed:0.63 green:0.84 blue:0.35 alpha:1.0];
        self.loginBtn.width -= 80;
        self.loginBtnCenterYYLayout.constant -= 60.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished){
        self.loginBtn.enabled = YES;
    }];
    
}

- (void)animateCloud:(UIImageView *)cloundImageView
{
    CGFloat cloudSpeed = 60.0 / SCREEN_WIDTH;
    CGFloat duration = (SCREEN_WIDTH - cloundImageView.frame.origin.x) * cloudSpeed;
    [UIView animateWithDuration: duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        cloundImageView.x = SCREEN_WIDTH;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        cloundImageView.x = -cloundImageView.width;
        [self animateCloud:cloundImageView];
        [self.view layoutIfNeeded];
    }];
}
#pragma mark - 内部方法
- (IBAction)loginBtnClick:(id)sender {
    
    [UIView animateWithDuration:1.5 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.loginBtn.width += 80;
        self.loginBtn.enabled = NO;
        [self showMessage:0];
    } completion:nil];
    
    [UIView animateWithDuration:0.33 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.loginBtnCenterYYLayout.constant += 60.0;
        self.loginBtn.backgroundColor = [UIColor colorWithDisplayP3Red:0.85 green:0.83 blue:0.45 alpha:1.0];
        self.spinner.alpha = 1.0;
        self.spinner.center = CGPointMake(40.0, self.loginBtn.height * 0.5);
        [self.view layoutIfNeeded];
    } completion:nil];
}
#pragma mark - 懒加载
- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"连接中...",@"开始验证...",@"验证中...",@"登录失败"];
    }
    return _titleArray;
}
@end
