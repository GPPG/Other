

//
//  TATarotReadingShowView.m
//  Tarot
//
//  Created by 郭鹏 on 2018/12/29.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import "TATarotReadingShowView.h"
#import "TATarReadingDrawContentMode.h"

#define ReadCardViewTag 1000

@interface TATarotReadingShowView()

@property (nonatomic, strong) TATarotReadingCardView *readingCardView;

@property (nonatomic, strong) NSMutableArray *cardViewArray;



@end

@implementation TATarotReadingShowView


#pragma mark - set up
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    
}

- (void)setReadingDrawMode:(TATarotReadingDrawMode *)readingDrawMode{
    _readingDrawMode = readingDrawMode;

    [self addSubView];
}

- (void)setDrawPath:(UIBezierPath *)drawPath{
    _drawPath = drawPath;
    [self addDrawPath];
}

- (void)addDrawPath{

    CAShapeLayer *shapeLine =  [CAShapeLayer layer];
    shapeLine.frame = self.frame;
    shapeLine.lineDashPattern = @[@(2),@(2)];
    shapeLine.fillColor = [UIColor clearColor].CGColor;
    shapeLine.strokeColor = [UIColor whiteColor].CGColor;
    shapeLine.path = self.drawPath.CGPath;
    [self.layer addSublayer:shapeLine];
}

- (void)addSubView{
    
    self.cardViewArray = [NSMutableArray array];
    
    [self.readingDrawMode.drawLOctionModeArray enumerateObjectsUsingBlock:^(TADrawLocationMode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        TATarotReadingCardView *readCardView = [[TATarotReadingCardView alloc]initWithCardStatus:CardBlankStatus];
        readCardView.tempSize = obj.cardSize;
        
        readCardView.size = obj.cardSize;
        readCardView.center = obj.centerPoint;
        readCardView.tag = obj.cardIndex;
        [readCardView setup];
        if (obj.angle != 90) {
            CGAffineTransform transform= CGAffineTransformMakeRotation(angle2Rad(obj.angle));
            readCardView.transform = transform;
            readCardView.bgImageView.image = [UIImage imageNamed:@"card_back"];
        }else{
            
            readCardView.bgImageView.image = [HImageUtility image:[UIImage imageNamed:@"card_back"] rotation:UIImageOrientationRight];
        }
        
        [self.cardViewArray addObject:readCardView];
        [self addSubview:readCardView];
        
        
        if (obj.cardNameStr.length) {
            UILabel *cardNameLabel = [[UILabel alloc]init];
            cardNameLabel.text = obj.cardNameStr;
            cardNameLabel.font = [UIFont systemFontOfSize:17];
            [cardNameLabel sizeToFit];
            cardNameLabel.center = CGPointMake(obj.centerPoint.x,obj.centerPoint.y + obj.cardSize.height * 0.5 + 20);
            cardNameLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
            cardNameLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:cardNameLabel];
        }
    }];
}

#pragma mark - public


- (void)updateReadingViewStatus:(NSArray *)cardStatusArray{
    
    [cardStatusArray enumerateObjectsUsingBlock:^(NSString *objStr, NSUInteger idx, BOOL * _Nonnull stop) {
       
        TATarotReadingCardView *readCardView = self.cardViewArray[idx];
        
        [readCardView updateCardStatus:[objStr integerValue]];
    }];
}

- (void)ShowCard{
    
    
    [self.cardViewArray enumerateObjectsUsingBlock:^(TATarotReadingCardView  *objView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TATarotReadingCardView *readCardView = self.cardViewArray[idx];
        [readCardView updateCardStatus:CardNormalStatus];
        
        TATarReadingDrawCardMode *mode = self.cardContentMode.cardModeArray[idx];
        
        if (mode.cardID.length == 0) {
            mode.cardID = @"card_front";
        }
        
        BOOL isY = YES;
        if (objView.width > objView.height) {
            
            isY = NO;
        }
        
            if (objView.bgImageView.size.height < objView.bgImageView.width) {
                
                
                if (mode.cardType) {//正位
                    ((UIImageView *)objView.bgImageView).image = [HImageUtility image:[UIImage imageNamed:mode.cardID] rotation:UIImageOrientationRight];
                }else{
                    ((UIImageView *)objView.bgImageView).image = [HImageUtility image:[UIImage imageNamed:mode.cardID] rotation:UIImageOrientationLeft];
                }
                
            }else{
                
                if (mode.cardType) {//正位
                    ((UIImageView *)objView.bgImageView).image = [UIImage imageNamed:mode.cardID];
                }else{
                    ((UIImageView *)objView.bgImageView).image = [HImageUtility image:[UIImage imageNamed:mode.cardID] rotation:UIImageOrientationDown];
                }
                
            }
    }];
}


- (void)overturnShowCard{
    
    [self.cardViewArray enumerateObjectsUsingBlock:^(TATarotReadingCardView  *objView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TATarReadingDrawCardMode *mode = self.cardContentMode.cardModeArray[idx];
        
        if (mode.cardID.length == 0) {
            mode.cardID = @"card_front";
        }
        
        BOOL isY = YES;
        if (objView.width > objView.height) {
            
            isY = NO;
        }
        
        
        
        [objView.bgImageView flipAnimationY:isY animation:^(Animation * _Nonnull animation) {
            animation.duration = 1;
            animation.isRear = YES;
        } flipBlock:^(BOOL rear, UIView * _Nonnull view) {
            if (view.size.height < view.width) {
                
                
                if (mode.cardType) {//正位
                    ((UIImageView *)view).image = [HImageUtility image:[UIImage imageNamed:mode.cardID] rotation:UIImageOrientationRight];
                }else{
                    ((UIImageView *)view).image = [HImageUtility image:[UIImage imageNamed:mode.cardID] rotation:UIImageOrientationLeft];
                }
                
            }else{
                
                if (mode.cardType) {//正位
                    ((UIImageView *)view).image = [UIImage imageNamed:mode.cardID];
                }else{
                    ((UIImageView *)view).image = [HImageUtility image:[UIImage imageNamed:mode.cardID] rotation:UIImageOrientationDown];
                }
                
            }
        }];
    }];
}




@end
