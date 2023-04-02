//
//  GPViewAnimationViewController.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/3/31.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "GPThreeLayerAnimationViewController.h"

@interface GPThreeLayerAnimationViewController ()<UITextFieldDelegate,CAAnimationDelegate>
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
@property (nonatomic, strong) UILabel *infoLabel;
@property(nonatomic, strong) CALayer *balloon;
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

@implementation GPThreeLayerAnimationViewController
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
    
    // 添加提示文本框
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.loginBtn.centerY + 60, SCREEN_WIDTH, 30)];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.text = @"请点击文本框输入账号和密码";
    self.infoLabel = infoLabel;
    [self.view insertSubview:infoLabel belowSubview:self.loginBtn];
    
    // 添加氢气球
    CALayer *balloon = [CALayer layer];
    balloon.contents = CFBridgingRelease([UIImage imageNamed:@"balloon"].CGImage);
    balloon.frame = CGRectMake(-50.0, 0.0, 50.0, 65.0);
    self.balloon = balloon;
    [self.view.layer insertSublayer:balloon below:self.phoneTextField.layer];
}
#pragma mark - 动画相关

- (void)setupAnimation
{
    self.phoneTextField.alpha = 0.0;
    self.passcodeTextField.alpha = 0.0;
    self.titleLabel.alpha = 0.0;
    self.infoLabel.alpha = 0.0;
    
//    self.loginBtnCenterYYLayout.constant += 30;
    self.loginBtn.alpha = 0.0;
    // layer动画
        // 透明度
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:animationOpacity];
    fadeIn.fromValue = @(0.0);
    fadeIn.toValue = @(1.0);
    fadeIn.duration = 0.5;
    fadeIn.fillMode = kCAFillModeBoth;
    fadeIn.beginTime = CACurrentMediaTime() + 0.5;
    [self.clound1.layer addAnimation:fadeIn forKey:nil];
    
    fadeIn.beginTime = CACurrentMediaTime() + 0.7;
    [self.clound2.layer addAnimation:fadeIn forKey:nil];
    
    fadeIn.beginTime = CACurrentMediaTime() + 0.9;
    [self.clound3.layer addAnimation:fadeIn forKey:nil];
    
    fadeIn.beginTime = CACurrentMediaTime() + 1.1;
    [self.clound4.layer addAnimation:fadeIn forKey:nil];    
}
- (void)loadAnimation
{
    self.phoneTextField.alpha = 1.0;
    self.passcodeTextField.alpha = 1.0;
    self.titleLabel.alpha = 1.0;
    self.infoLabel.alpha = 1.0;
    self.loginBtn.alpha = 1.0;
    
    // layer动画
        // 动画组
    CAAnimationGroup *textFiledGroup = [CAAnimationGroup animation];
    textFiledGroup.duration = 0.5;
    textFiledGroup.fillMode = kCAFillModeBackwards;
    textFiledGroup.delegate = self;
    [textFiledGroup setValue:@"form" forKey:@"name"];

    
    CABasicAnimation *flyRight = [CABasicAnimation animationWithKeyPath:animationX];
    flyRight.fromValue = @(-SCREEN_WIDTH * 0.5);
    flyRight.toValue = @(SCREEN_WIDTH * 0.5);

    CABasicAnimation *fadeFieldIn = [CABasicAnimation animationWithKeyPath:animationOpacity];
    fadeFieldIn.fromValue = @(0.25);
    fadeFieldIn.toValue = @(1.0);
    textFiledGroup.animations = @[flyRight,fadeFieldIn];
    
    [textFiledGroup setValue:self.titleLabel.layer forKey:@"layer"];
    [self.titleLabel.layer addAnimation:textFiledGroup forKey:nil];
    
    textFiledGroup.beginTime = CACurrentMediaTime() + 0.3;
    flyRight.fillMode = kCAFillModeBoth;
    [textFiledGroup setValue:self.phoneTextField.layer forKey:@"layerr"];
    [self.phoneTextField.layer addAnimation:textFiledGroup forKey:nil];
    
    textFiledGroup.beginTime = CACurrentMediaTime() + 0.4;
    [textFiledGroup setValue:self.passcodeTextField.layer forKey:@"layerrr"];
    [self.passcodeTextField.layer addAnimation:textFiledGroup forKey:nil];
        // layer的动画组
    CAAnimationGroup *loginAnimationGroup = [CAAnimationGroup animation];
    loginAnimationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    loginAnimationGroup.duration = 0.5;
    loginAnimationGroup.beginTime = CACurrentMediaTime() + 0.5;
    loginAnimationGroup.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *scaleDown = [CABasicAnimation animationWithKeyPath:animationSacle];
    scaleDown.fromValue = @(3.5);
    scaleDown.toValue = @(1.0);
    
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:animationRotation];
    rotate.fromValue = @(M_PI / 4.0);
    rotate.toValue = @(0.0);
    
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:animationOpacity];
    fade.fromValue = @(0.0);
    fade.toValue = @(1.0);
    loginAnimationGroup.animations = @[scaleDown,rotate,fade];
    [self.loginBtn.layer addAnimation:loginAnimationGroup forKey:nil];
    // layer的key
    CABasicAnimation *flyLeft = [CABasicAnimation animationWithKeyPath:animationX];
    flyLeft.fromValue = @(self.infoLabel.centerX + SCREEN_WIDTH);
    flyLeft.toValue = @(self.infoLabel.centerX);
    flyLeft.duration = 5.0;
    flyLeft.repeatCount = 4;
    flyLeft.autoreverses = YES;
    [self.infoLabel.layer addAnimation:flyLeft forKey:@"infoappear"];
    
    CABasicAnimation *fadeLabelIn = [CABasicAnimation animationWithKeyPath:animationOpacity];
    fadeLabelIn.fromValue = @(0.2);
    fadeLabelIn.toValue = @(1.0);
    fadeLabelIn.duration = 4.5;
    [self.infoLabel.layer addAnimation:fadeLabelIn forKey:@"fadein"];
        // 白云
    [self animateCloud:self.clound1.layer];
    [self animateCloud:self.clound2.layer];
    [self animateCloud:self.clound3.layer];
    [self animateCloud:self.clound4.layer];
    
    // layer的帧动画
    CAKeyframeAnimation *flight = [CAKeyframeAnimation animationWithKeyPath:animationPosition];
    flight.duration = 12.0;
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(-50.0, 0.0)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(self.view.width, 160.0)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(-50.0, self.loginBtn.centerY)];
    flight.values = @[value1,value2,value3];
    flight.keyTimes = @[@(0.0),@(0.5),@(1.0)];
    [self.balloon addAnimation:flight forKey:nil];
    self.balloon.position = CGPointMake(-50.0, self.loginBtn.centerY);
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
        self.loginBtn.width -= 80;
        self.loginBtnCenterYYLayout.constant -= 60.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self tintBackgroundColor:self.loginBtn.layer toColor:[UIColor colorWithRed:0.63 green:0.84 blue:0.35 alpha:1.0]];
        [self roundCorners:self.loginBtn.layer radius:10.0];
        self.loginBtn.enabled = YES;
    }];
    
    CAKeyframeAnimation *wobble = [CAKeyframeAnimation animationWithKeyPath:animationRotation];
    wobble.duration = 1;
    wobble.repeatCount = 4;
    wobble.values = @[@(0.0),@(-M_PI /  4.0),@(0.0),@(-M_PI / 4.0),@(0.0)];
    wobble.keyTimes = @[@(0.0),@(0.25),@(0.5),@(0.75),@(1.0)];
    [self.titleLabel.layer addAnimation:wobble forKey:nil];
}

- (void)animateCloud:(CALayer *)layer
{
    CGFloat cloudSpeed = 60.0 / SCREEN_WIDTH;
    CGFloat duration = (SCREEN_WIDTH - layer.frame.origin.x) * cloudSpeed;
    CABasicAnimation *cloudMove = [CABasicAnimation animationWithKeyPath:animationX];
    cloudMove.duration = duration;
    cloudMove.toValue = @(SCREEN_WIDTH + layer.frame.size.width * 0.5);
    cloudMove.delegate = self;
    cloudMove.fillMode = kCAFillModeForwards;
    [cloudMove setValue:@"cloud" forKey:@"name"];
    [cloudMove setValue:layer forKey:@"layer"];
    [layer addAnimation:cloudMove forKey:nil];
}
- (void)roundCorners:(CALayer *)layer radius:(CGFloat)radius
{
    CASpringAnimation *round = [CASpringAnimation animationWithKeyPath:animationCorner];
    round.damping = 5.0;
    round.fromValue = @(layer.cornerRadius);
    round.toValue = @(radius);
    round.duration = round.settlingDuration;    [layer addAnimation:round forKey:nil];
    layer.cornerRadius = radius;
}
- (void)tintBackgroundColor:(CALayer *)layer toColor:(UIColor *)toColor
{
    CASpringAnimation *tint = [CASpringAnimation animationWithKeyPath:animationBackColor];
    tint.damping = 5.0;
    tint.initialVelocity = -10.0;
    tint.fromValue = (__bridge id _Nullable)(layer.backgroundColor);
    tint.toValue = toColor;
    tint.duration = tint.settlingDuration;
    [layer addAnimation:tint forKey:nil];
    layer.backgroundColor = toColor.CGColor;
}
#pragma mark - 文本框代理
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.infoLabel.layer removeAnimationForKey:@"infoappear"];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length < 6) {
        CASpringAnimation *jump = [CASpringAnimation animationWithKeyPath:animationY];
        jump.initialVelocity = 100.0;
        jump.mass = 10.0;
        jump.stiffness = 1500.0;
        jump.damping = 50.0;
        jump.fromValue = @(textField.layer.position.y + 1.0);
        jump.toValue = @(textField.layer.position.y);
        jump.duration = jump.settlingDuration;
        [textField.layer addAnimation:jump forKey:nil];
        
        textField.layer.borderWidth = 3.0;
        textField.layer.borderColor = [UIColor clearColor].CGColor;
        
        CASpringAnimation *flash = [CASpringAnimation animationWithKeyPath:animationBorderColor];
        flash.damping = 3.0;
        flash.stiffness = 200.0;
        flash.fromValue = (id)[UIColor redColor].CGColor;
        flash.toValue = (id)[UIColor whiteColor].CGColor;
        flash.duration = flash.settlingDuration;
        [textField.layer addAnimation:flash forKey:nil];
        
    }
}
#pragma mark - 动画代理
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKey:@"name"] isEqualToString:@"form"]) {
        CALayer *layer = [anim valueForKey:@"layer"];
        CALayer *layerr = [anim valueForKey:@"layerr"];
        CALayer *layerrr = [anim valueForKey:@"layerrr"];

        CASpringAnimation *pulse = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
        pulse.fromValue = @(1.25);
        pulse.toValue = @(1.0);
        pulse.duration = pulse.settlingDuration;
        pulse.damping = 7.5;
        [layer addAnimation:pulse forKey:nil];
        [layerr addAnimation:pulse forKey:nil];
        [layerrr addAnimation:pulse forKey:nil];
    }
    
    if ([[anim valueForKey:@"name"] isEqualToString:@"cloud"]) {
        CALayer *layer = [anim valueForKey:@"layer"];
        layer.frame = CGRectMake(-layer.bounds.size.width, layer.position.y, layer.bounds.size.width, layer.bounds.size.height);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self animateCloud:layer];
        });
    }
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
        self.spinner.alpha = 1.0;
        self.spinner.center = CGPointMake(40.0, self.loginBtn.height * 0.5);
        [self.view layoutIfNeeded];
    } completion:nil];
    
    [self tintBackgroundColor:self.loginBtn.layer toColor:[UIColor colorWithDisplayP3Red:0.85 green:0.83 blue:0.45 alpha:1.0]];
    [self roundCorners:self.loginBtn.layer radius:25.0];
    
    
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
