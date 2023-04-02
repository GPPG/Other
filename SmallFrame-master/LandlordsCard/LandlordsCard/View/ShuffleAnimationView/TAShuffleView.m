//
//  TAShuffleView.m
//  Tarot
//
//  Created by 李亚洲 on 2018/12/14.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import "TAShuffleView.h"
#import "TATarotView.h"

static NSString *const burstAnimationKey = @"burstAnimationKey";
static NSString *const expansionAnimationKey = @"expansionAnimationKey";

@interface TAShuffleView ()<CAAnimationDelegate>

@property (nonatomic, copy) NSArray *tarots;

@property (nonatomic, assign) CGFloat leftStartAngle;//左边第一张牌的偏转角度
@property (nonatomic, assign) CGFloat rightStartAngle;//右边第一张牌的偏转角度
@property (nonatomic, assign) CGFloat leftStartIndex;//左边第一张牌在数组中的索引
@property (nonatomic, assign) CGFloat rightStartIndex;//右边第一张牌在数组中的索引

@property (nonatomic, assign) CGFloat downScale;//下落过程中塔罗牌的放大倍率
@end

@implementation TAShuffleView

- (instancetype)init {
    if (self = [super init]) {
        [self addObserver];
//        self.tarotCount = 20;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addObserver];
    }
    return self;
}

- (void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];    
}

- (void)didEnterBackground{
    
    if (self.animationFinishedBlock) {
        self.animationFinishedBlock();
    }
    self.animationFinishedBlock = nil;
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark ---setter---

- (void)setTarotCount:(NSInteger)tarotCount {
    if (_tarotCount == tarotCount) {
        return;
    }
    
    _tarotCount = tarotCount;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:tarotCount];
    for (int index = 0; index < tarotCount; index ++) {
        TATarotView *tarotView = [[TATarotView alloc] initWithFrontImageNamed:@"card_back" realImageNamed:@"card_back"];
        tarotView.frame = CGRectMake(0, 0, 60, 100);
        tarotView.clipsToBounds = YES;
        tarotView.layer.cornerRadius = 5;
        [self addSubview:tarotView];
        [array addObject:tarotView];
        [tarotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 100));
            make.center.equalTo(self);
        }];
    }
    self.tarots = array;
}

#pragma mark ---public---

- (void)startAnimation {
    self.backgroundColor = [UIColor clearColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self burstAnimation:self.tarots.count - 1];
    });
}

#pragma mark ---private---

- (void)burstAnimation:(NSInteger)index {
    if (index < 0 || index > self.tarots.count - 1) {
        return;
    }
    TATarotView *tarotView = self.tarots[index];
    
    //自转
    CGFloat rotateDuration = 1.0;
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = @(0);
    CGFloat endAngle = M_PI * 1.5 / 180 * (arc4random() % 180);
    rotateAnimation.toValue = @(endAngle);
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.speed = 1.5;
    rotateAnimation.duration = rotateDuration;
    
    //
    CGFloat radio = 90 + arc4random() % 30;//散开半径
    CGFloat angle = M_PI * 2 / self.tarots.count;//每张牌出去的角度
    //先以一个半圆的轨迹扩散到最大位置
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(self.center.x + radio / 2 * cos(angle * index), self.center.y - radio / 2 *sin(angle * index)) radius:radio / 2 startAngle:M_PI - angle * index endAngle: -angle * index clockwise:YES];
    //再以最大位置做转圈动画
    [path addArcWithCenter:self.center radius:radio startAngle:-angle * index endAngle:-angle * index + M_PI_2 + M_PI_4 / 10 * (arc4random() % 10) clockwise:YES];
    
    CGFloat keyDuration = rotateDuration;
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path = path.CGPath;
    keyAnimation.duration = keyDuration;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.calculationMode = kCAAnimationPaced;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0.3 :1.0 :1.0];
    
    //回归自转
    CGFloat maxStart = 0.7;
    CGFloat start = arc4random() % 100 / 100.0 * maxStart;//在转圈动画结束后，间隔多长时间开始回归动画
    CGFloat regainDuration = 0.3;
    CGFloat end = endAngle > M_PI ? 2*M_PI : 0;
    CABasicAnimation *regainAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    regainAnimation.fromValue = @(endAngle);
    regainAnimation.toValue = @(end);
    regainAnimation.fillMode = kCAFillModeForwards;
    regainAnimation.removedOnCompletion = NO;
    
    //回归收牌
    CABasicAnimation *regainPositonAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    regainPositonAnimation.fromValue = [NSValue valueWithCGPoint:path.currentPoint];
    regainPositonAnimation.toValue = [NSValue valueWithCGPoint:self.center];
    regainPositonAnimation.fillMode = kCAFillModeForwards;
    regainPositonAnimation.removedOnCompletion = NO;
    
    CAAnimationGroup *regainGroup = [CAAnimationGroup animation];
    regainGroup.animations = @[regainAnimation, regainPositonAnimation];
    regainGroup.fillMode = kCAFillModeForwards;
    regainGroup.removedOnCompletion = NO;
    regainGroup.duration = regainDuration;
    regainGroup.beginTime = keyDuration + start;
    
    
    //上下切牌动画
    CGFloat key1Duration = 0.8;
    CAKeyframeAnimation *key1 = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    key1.values = @[@(self.center.y), @(self.center.y + self.cutPadding), @(self.center.y - self.cutPadding)];
    key1.keyTimes = @[@(0), @(0.33), @(1)];
    key1.duration = key1Duration;
    key1.fillMode = kCAFillModeForwards;
    key1.removedOnCompletion = NO;
    key1.calculationMode = kCAAnimationPaced;
    key1.beginTime = keyDuration + maxStart + regainDuration;
    
    CGFloat key3Duration = key1Duration * 2;
    CAKeyframeAnimation *key3 = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    key3.values = @[@(self.center.y), @(self.center.y + self.cutPadding), @(self.center.y + self.cutPadding), @(self.center.y - self.cutPadding)];
    key3.keyTimes = @[@(0), @(0.33 / 2), @(0.67), @(1)];
    key3.duration = key3Duration;
    key3.fillMode = kCAFillModeForwards;
    key3.removedOnCompletion = NO;
    key3.beginTime = key1.beginTime;
    
    //中
    CGFloat key2Duration = key1Duration;
    CAKeyframeAnimation *key2 = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    key2.values = @[@(self.center.y), @(self.center.y + self.cutPadding), @(self.center.y - self.cutPadding)];
    key2.keyTimes = @[@(0), @(0.33), @(1)];
    key2.duration = key2Duration;
    key2.fillMode = kCAFillModeForwards;
    key2.removedOnCompletion = NO;
    key2.calculationMode = kCAAnimationPaced;
    key2.beginTime = key1.beginTime + key1Duration;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    if (index < self.tarots.count / 3) {
        group.animations = @[rotateAnimation, keyAnimation, regainGroup, key1];
        
        group.duration = key1.beginTime + key1Duration;
    } else if (index < self.tarots.count / 3 * 2) {
        group.animations = @[rotateAnimation, keyAnimation, regainGroup, key2];
        group.duration = key2.beginTime + key2Duration;
    } else {
        group.animations = @[rotateAnimation, keyAnimation, regainGroup, key3];
        group.duration = key3.beginTime + key3Duration;
    }
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.beginTime = CACurrentMediaTime() + 0.5;
    group.delegate = self;
    
    [tarotView.layer addAnimation:group forKey:burstAnimationKey];
    [self burstAnimation:--index];
}

//塔罗牌展开的动画
- (void)expansionAnimation {
    self.leftStartAngle = 0;
    self.rightStartAngle = 0;
    self.leftStartIndex = floorf((self.tarots.count - 1) / 2.0);
    self.rightStartIndex = ceilf((self.tarots.count - 1) / 2.0);
    self.downScale = 1.8;
    if (self.tarots.count % 2 == 0) {
        self.leftStartAngle = self.intervalAngle / 2.0;
        self.rightStartAngle = self.intervalAngle / 2.0;
    }
    
    [self expansionAnimation:0];
}

- (void)expansionAnimation:(NSInteger)index {
    if (index < 0 || index > self.tarots.count - 1) {
        return;
    }
    TATarotView *tarotView = self.tarots[index];
    
    BOOL isLeft = (index <= self.leftStartIndex);
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframe.removedOnCompletion = NO;
    keyframe.fillMode = kCAFillModeForwards;
    
    CGFloat startIndex = isLeft ? self.leftStartIndex : self.rightStartIndex;
    CGFloat startintervalAngle = isLeft ? -self.leftStartAngle : self.rightStartAngle;
    CGFloat startAngle = M_PI_2 * 3;
    CGFloat endAngle = M_PI_2 * 3 + startintervalAngle - self.intervalAngle * (startIndex - index);
    CGFloat expansionDuration = 0.35;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(self.center.x, self.center.y + self.fanRadio - self.cutPadding) radius:self.fanRadio startAngle:startAngle endAngle:endAngle clockwise:!isLeft];
    keyframe.path = path.CGPath;
    keyframe.fillMode = kCAFillModeForwards;
    keyframe.removedOnCompletion = NO;
    keyframe.duration = expansionDuration;
    
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    baseAnimation.fromValue = @(0);
    baseAnimation.toValue = @(startintervalAngle - self.intervalAngle * (startIndex - index));
    baseAnimation.duration = expansionDuration;
    baseAnimation.fillMode = kCAFillModeForwards;
    baseAnimation.removedOnCompletion = NO;
    
    //下落动画
    CGFloat padding = self.bottomPadding - tarotView.bounds.size.height * self.downScale / 2;
    CGFloat downEndAngle = M_PI_2 * 3 + (startintervalAngle - self.intervalAngle * (startIndex - index)) * 2;
    UIBezierPath *downPath = [UIBezierPath bezierPath];
    [downPath addArcWithCenter:CGPointMake(self.center.x, self.bounds.size.height + self.fanRadio - padding) radius:self.fanRadio startAngle:startAngle endAngle:downEndAngle clockwise:!isLeft];
    
    CGFloat downDuration = 0.25;
    CABasicAnimation *downAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    downAnimation.fromValue = @(path.currentPoint);
    downAnimation.toValue = @(downPath.currentPoint);
    downAnimation.duration = downDuration;
    downAnimation.fillMode = kCAFillModeForwards;
    downAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *base1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    base1.fromValue = @(startintervalAngle - self.intervalAngle * (startIndex - index));
    base1.toValue = @((startintervalAngle - self.intervalAngle * (startIndex - index)) * 1.8);
    base1.duration = downDuration;
    base1.fillMode = kCAFillModeForwards;
    base1.removedOnCompletion = NO;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(1);
    scaleAnimation.toValue = @(self.downScale);
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.duration = downDuration;
    
    CAAnimationGroup *downGroup = [CAAnimationGroup animation];
    downGroup.animations = @[downAnimation, base1, scaleAnimation];
    downGroup.fillMode = kCAFillModeForwards;
    downGroup.removedOnCompletion = NO;
    downGroup.duration = downDuration;
    downGroup.beginTime = expansionDuration + 0.1;
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[keyframe, baseAnimation, downGroup];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.duration = downGroup.beginTime + downDuration;
    group.beginTime = CACurrentMediaTime() + 0.1;
    group.delegate = self;
    
    [tarotView.layer addAnimation:group forKey:expansionAnimationKey];
    [self expansionAnimation:++index];
}

#pragma mark ---CAAnimationDelegate---

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    TATarotView *tarotView = [self.tarots lastObject];
    if (anim == [tarotView.layer animationForKey:burstAnimationKey]) {
        
        [self expansionAnimation];
    }
    
    if (anim == [tarotView.layer animationForKey:expansionAnimationKey]) {
        [self removeFromSuperview];
        if (!flag) {
            return;
        }
        [[NSNotificationCenter defaultCenter]removeObserver:self];
        if (self.animationFinishedBlock) {
            self.animationFinishedBlock();
        }
        self.animationFinishedBlock = nil;
    }
}

@end
