//
//  GPDrawCardViewController.m
//  LandlordsCard
//
//  Created by 郭鹏 on 2019/12/24.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GPDrawCardViewController.h"
#import "TATarotReadingShowView.h"
#import "TADrawCardView.h"
#import "TADrawCardArrowView.h"
#import "TAShuffleView.h"


@interface GPDrawCardViewController ()

@property (nonatomic,strong) TATarotReadingShowView *readingShowView;

@property (nonatomic, strong) TATarotReadinDrawModeManger *tarotReadinManger;

@property(strong,nonatomic) TADrawCardView *drawCardView;

@property (nonatomic, strong) TADrawCardArrowView *arrowView;

@property (nonatomic, strong) TAShuffleView *shuffleView;

@property (nonatomic, strong) NSDictionary *screenshotsSizeDic;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@end

@implementation GPDrawCardViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addView];
    [self setup];
    [self callback];
    [self stratShuffleAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.shuffleView removeFromSuperview];
    self.shuffleView = nil;
}

#pragma mark - Set up

- (void)addView{
    [self.view.layer addSublayer:self.gradientLayer];
    [self.view addSubview:self.readingShowView];
    [self.view addSubview:self.arrowView];
    [self.view addSubview:self.drawCardView];
}

- (void)setup{
    self.drawCardView.clipsToBounds = NO;
}

- (void)stratShuffleAnimation{
    [self hiddenAllView];
    [self shuffleAnimation];
}
- (void)shuffleAnimation{
    
    WS(ws);
    TAShuffleView *shuffleView = [[TAShuffleView alloc] initWithFrame:self.view.bounds];
    shuffleView.tarotCount = 21;
    shuffleView.cutPadding = 120;
    shuffleView.intervalAngle = M_PI / 80;
    shuffleView.bottomPadding = fanBottonPadding + 10;
    shuffleView.fanRadio = 600;
    [self.view addSubview:shuffleView];
    self.shuffleView = shuffleView;
    [shuffleView startAnimation];
    
    shuffleView.animationFinishedBlock = ^{
        [ws showAllView];
    };
}

- (void)hiddenAllView{
    self.readingShowView.alpha = 0;
    self.arrowView.alpha = 0;
    self.drawCardView.hidden = YES;
}

- (void)showAllView{
    
    self.drawCardView.hidden = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.readingShowView.alpha = 1;
        self.arrowView.alpha = 1;
    }completion:^(BOOL finished) {
        [self.arrowView startLineAnimation];
    }];
}

#pragma mark - set
- (void)setTarotReadingType:(TarotReadingType)tarotReadingType{
        
    _tarotReadingType = tarotReadingType;
    
    TATarotReadingDrawMode *readingMode = [self.tarotReadinManger queryReadingMode:tarotReadingType];
    self.readingShowView.readingDrawMode = readingMode;
    self.drawCardView.goalLocationArray = readingMode.drawLOctionModeArray;
    [self.readingShowView updateReadingViewStatus:[self.tarotReadinManger queryReadingCardStatus:tarotReadingType]];
    self.readingShowView.drawPath = [self.tarotReadinManger queryReadingCardPath:tarotReadingType];
}

- (void)setCardContentMode:(TATarReadingDrawContentMode *)cardContentMode{
    _cardContentMode = cardContentMode;
    
    self.tarotReadingType = cardContentMode.spreadId;
    self.readingShowView.cardContentMode = cardContentMode;
}


#pragma mark - Callback
- (void)callback{
    WS(ws);
    // 开始抽取卡片回调
    self.drawCardView.drawCardStartBlock = ^(NSInteger moveLocationIndex, NSInteger drawCardIndex) {
    };
    
    // 抽牌每一张成功的回调
    self.drawCardView.drawCardSucceedBlock = ^(NSInteger moveLocationIndex, BOOL finishDraw) {
        
     NSArray *cardStatusArray = [ws.tarotReadinManger updateReadingCardStatus:ws.tarotReadingType cardIndex:moveLocationIndex];
        [ws.readingShowView updateReadingViewStatus:cardStatusArray];
    };
    
    // 全部完成抽牌回调
    self.drawCardView.drawCardFinishBlock = ^(NSArray * _Nonnull finishSelectArray) {
        [ws moveDownDardView];
        [ws overturnShowCard];
    };
}

#pragma mark - Animate
- (void)overturnShowCard{
    [self.readingShowView overturnShowCard];
}

- (void)moveDownDardView{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.drawCardView.y = SCREEN_HEIGHT + 30;
        self.arrowView.y = SCREEN_HEIGHT + 30;

    } completion:^(BOOL finished) {}];
}



#pragma mark - Private
- (CAGradientLayer *)getGradientWithFrame:(CGRect) frame {
    
    UIColor *colorOne = [UIColor colorWithHexString:@"#342751" alpha:0.95];
    
    UIColor *colorTwo = [UIColor colorWithHexString:@"#291934" alpha:0.95];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopThree = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopThree, nil];
    // 渐变图层
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = colors;
    layer.locations = locations;
    layer.frame = frame;
    return layer;
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.readingShowView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - Lazy

- (CAGradientLayer *)gradientLayer{
    
    if (!_gradientLayer) {
        _gradientLayer = [self getGradientWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _gradientLayer;
}

- (TATarotReadingShowView *)readingShowView{
    
    if (!_readingShowView) {
        _readingShowView = [[TATarotReadingShowView alloc]init];
        
    }
    return _readingShowView;
}

- (TATarotReadinDrawModeManger *)tarotReadinManger{
    
    if (!_tarotReadinManger) {
        _tarotReadinManger = [[TATarotReadinDrawModeManger alloc]init];
        [_tarotReadinManger setupReadModeDic];
    }
    return _tarotReadinManger;
}


- (TADrawCardView *)drawCardView{
    
    if (!_drawCardView) {
        _drawCardView = [[TADrawCardView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT - fanBottonPadding, SCREEN_WIDTH,360)];
        _drawCardView.scaleValue = 0.534;
        _drawCardView.bgColor = [UIColor clearColor];
    }
    return _drawCardView;
}

- (TADrawCardArrowView *)arrowView{
    
    if (!_arrowView) {
        _arrowView = [[TADrawCardArrowView alloc]initWithCenter:CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT + 600 - fanBottonPadding - 40) radius:600];
    }
    return _arrowView;
}
@end
