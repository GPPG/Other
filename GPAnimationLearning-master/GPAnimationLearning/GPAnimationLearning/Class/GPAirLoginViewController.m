//
//  GPAirLoginViewController.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/4/1.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "GPAirLoginViewController.h"
#import "GPFlighData.h"
#import "GPSnowView.h"

@interface GPAirLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *flightLabel;
@property (weak, nonatomic) IBOutlet UILabel *FlightNO;
@property (weak, nonatomic) IBOutlet UILabel *boardingLabel;
@property (weak, nonatomic) IBOutlet UILabel *boardingNOLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalPointLabel;
@property (weak, nonatomic) IBOutlet UIImageView *airImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, strong) GPSnowView *snowView;
@property (nonatomic, strong) GPFlighData *beiJingFlightData;
@property (nonatomic, strong) GPFlighData *sahngHaiFlightData;
@end

typedef NS_ENUM(NSInteger,AnimationDirection){
    positive = 1,
    negative = -1
};

@implementation GPAirLoginViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - 初始化方法
- (void)setupView
{
    [self.topView addSubview:({
        GPSnowView *snowView = [[GPSnowView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        self.snowView = snowView;
        snowView;
    })];
    [self changFlightData:self.beiJingFlightData animated:NO];
}
#pragma mark - 内部方法
- (void)changFlightData:(GPFlighData *)flightData animated:(BOOL)isAnimated
{
    self.topLabel.text = flightData.summaryStr;
    
    AnimationDirection direction = flightData.isTakingOff ? positive : negative;
    
    if (isAnimated) {
        // 飞机起飞
        [self planeDepart];
        // 头部标题
        [self summarySwitch:flightData.summaryStr];
        // 背景图片更换
        [self fadeImageView:[UIImage imageNamed:flightData.weatherImageNameStr] showEffects:flightData.isShowWeatherEffects];
        // 航班号和登机口
        [self cubeTransition:self.FlightNO text:flightData.flightNrStr direction:direction];
        [self cubeTransition:self.boardingNOLabel text:flightData.gateNrStr direction:direction];
        
        // 出发点和目标点
        CGPoint offsetDeparting = CGPointMake(direction * 80, 0.0);
        [self moveLabel:self.originLabel text:flightData.departingFromStr offset:offsetDeparting];
        
        CGPoint offsetArriving = CGPointMake(0.0,direction * 50);
        [self moveLabel:self.arrivalPointLabel text:flightData.arrivingToStr offset:offsetArriving];
        // 状态文字
        [self cubeTransition:self.statusLabel text:flightData.flightStatusStr direction:direction];
    }
    else{ // 第一次,不用动画直接赋值
        self.FlightNO.text = flightData.flightNrStr;
        self.boardingNOLabel.text = flightData.gateNrStr;
        self.originLabel.text = flightData.departingFromStr;
        self.arrivalPointLabel.text = flightData.arrivingToStr;
        self.statusLabel.text = flightData.flightStatusStr;
        self.bgImageView.image = [UIImage imageNamed:flightData.weatherImageNameStr];
        self.snowView.hidden = !flightData.isShowWeatherEffects;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self changFlightData:flightData.isTakingOff ? self.sahngHaiFlightData : self.beiJingFlightData animated:YES];
    });
}

#pragma mark - 动画相关
// 图片
- (void)fadeImageView:(UIImage *)toImage showEffects:(BOOL)showEffects
{
    // 背景图片
    [UIView transitionWithView:self.bgImageView duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.bgImageView.image = toImage;
    } completion:nil];
    
    // 雪花发射器
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.snowView.alpha = showEffects ? 1.0 : 0.0;
    } completion:nil];
}
// 航班号&登机口&状态文字
- (void)cubeTransition:(UILabel *)label text:(NSString *)text direction:(AnimationDirection)direction
{
    CGFloat auxLabelOffset = direction * label.height * 0.5;
    CGAffineTransform transScaleForm = CGAffineTransformMakeScale(1.0, 0.1);
    CGAffineTransform tempTop = CGAffineTransformMakeTranslation(0.0, auxLabelOffset);
    CGAffineTransform tempDow = CGAffineTransformMakeTranslation(0.0, -auxLabelOffset);
    CGAffineTransform transTopForm = CGAffineTransformConcat(transScaleForm, tempTop);
    CGAffineTransform transDowForm = CGAffineTransformConcat(transScaleForm, tempDow);
    
    UILabel *auxLabel = [[UILabel alloc]initWithFrame:label.frame];
    [label.superview addSubview:({
        auxLabel.backgroundColor = [UIColor clearColor];
        auxLabel.transform = transTopForm;
        auxLabel.text = text;
//        [auxLabel sizeToFit];
        
        auxLabel.font = label.font;
        auxLabel.textAlignment = label.textAlignment;
        auxLabel.textColor = label.textColor;
        auxLabel;
    })];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        auxLabel.transform = CGAffineTransformIdentity;
        label.transform = transDowForm;
    } completion:^(BOOL finished) {
        label.transform = CGAffineTransformIdentity;
        label.text = auxLabel.text;
        [label sizeToFit];
        [auxLabel removeFromSuperview];
    }];
}
// 出发点和到达点
- (void)moveLabel:(UILabel *)label text:(NSString *)text offset:(CGPoint)offset
{
    CGAffineTransform tempTransform = CGAffineTransformMakeTranslation(offset.x, offset.y);
 
    UILabel *auxLabel = [[UILabel alloc]initWithFrame:label.frame];
    [self.view addSubview:({
        auxLabel.backgroundColor = [UIColor clearColor];
        auxLabel.text = text;
        [auxLabel sizeToFit];
        auxLabel.font = label.font;
        auxLabel.textAlignment = label.textAlignment;
        auxLabel.textColor = label.textColor;
        auxLabel.transform = tempTransform;
        auxLabel.alpha = 0;
        auxLabel;
    })];

    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        label.transform = tempTransform;
        label.alpha = 0.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        auxLabel.transform = CGAffineTransformIdentity;
        auxLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        label.text = text;
        [label sizeToFit];
        label.alpha = 1.0;
        label.transform = CGAffineTransformIdentity;
        [auxLabel removeFromSuperview];
    }];
}
// 飞机起飞喽
- (void)planeDepart
{
    CGPoint originalCenter = self.airImageView.center;
    
    [UIView animateKeyframesWithDuration:1.5 delay:0.0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.25 animations:^{
            self.airImageView.centerX += 80.0;
            self.airImageView.centerY -= 10;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.4 animations:^{
            self.airImageView.transform = CGAffineTransformMakeRotation(-M_PI / 8);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
            self.airImageView.centerX += 100.0;
            self.airImageView.centerY -= 50;
            self.airImageView.alpha = 0.0;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.51 relativeDuration:0.01 animations:^{
            self.airImageView.transform = CGAffineTransformIdentity;
            self.airImageView.center = CGPointMake(0.0, originalCenter.y);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.45 animations:^{
            self.airImageView.alpha = 1.0;
            self.airImageView.center = originalCenter;
        }];
    } completion:nil];
}
// 标题
- (void)summarySwitch:(NSString *)summaryText
{

    [UIView animateKeyframesWithDuration:1.0 delay:0.0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.45 animations:^{
            self.topImageView.centerY -= 100.0;
            self.topLabel.centerY -= 100.0;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.45 animations:^{
            self.topImageView.centerY += 100.0;
            self.topLabel.centerY += 100.0;
        }];
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.topLabel.text = summaryText;
    });
    
}


#pragma mark - 懒加载
- (GPFlighData *)beiJingFlightData
{
    if (!_beiJingFlightData) {
        _beiJingFlightData = [[GPFlighData alloc]initWithIsBeiJing:YES];
    }
    return _beiJingFlightData;
}
- (GPFlighData *)sahngHaiFlightData
{
    if (!_sahngHaiFlightData) {
        _sahngHaiFlightData = [[GPFlighData alloc]initWithIsBeiJing:NO];
    }
    return _sahngHaiFlightData;
}
@end
