//
//  TATarotReadinDrawModeManger.m
//  Tarot
//
//  Created by 郭鹏 on 2019/1/3.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "TATarotReadinDrawModeManger.h"


@interface TATarotReadinDrawModeManger()

@property (nonatomic, strong) NSMutableDictionary  <NSString *,TATarotReadingDrawMode *> *tarotReadingDic;

@property (nonatomic, strong) NSMutableDictionary *cardStatusDic;


@property (nonatomic, strong) NSMutableDictionary *cardPathDic;

@end






@implementation TATarotReadinDrawModeManger


- (TATarotReadingDrawMode *)queryReadingMode:(TarotReadingType)tarotReadingType{
    
    return self.tarotReadingDic[enumToString(tarotReadingType)];
}

- (NSMutableArray *)queryReadingCardStatus:(TarotReadingType)tarotReadingType{
    return self.cardStatusDic[enumToString(tarotReadingType)];
}

- (UIBezierPath *)queryReadingCardPath:(TarotReadingType)tarotReadingType{

    return self.cardPathDic[enumToString(tarotReadingType)];
}


- (NSArray *)updateReadingCardStatus:(TarotReadingType)tarotReadingType cardIndex:(NSInteger)index{
    
    NSMutableArray *readingCardStatusArray = [self queryReadingCardStatus:tarotReadingType];
    
    [readingCardStatusArray replaceObjectAtIndex:index - 1 withObject:enumToString(CardPlaceholderStatus)];
    if (readingCardStatusArray.count != index) {
        [readingCardStatusArray replaceObjectAtIndex:index withObject:enumToString(CardDragStatus)];
    }
    
    [self.cardStatusDic setValue:readingCardStatusArray forKey: enumToString(tarotReadingType)];
    return  [readingCardStatusArray copy];
}

- (void)setupReadModeDic{
    
    // 恋人金字塔
    [self setupPyramid:TarotReadingPyramid];
    
    // 事业金字塔
    [self setupPyramid:TarotReadingCareer];
    
    // 财富金字塔
    [self setupWealth];
    
    // 爱情大十字
    [self setupLove];
    
    // X 牌阵
    [self setupX];
    
    // 复合之树
    [self setupTree];
    
    // 心灵牌阵
    [self setupSoul];

    // 菱形牌阵
    [self setupDiamond];
    
    // 圣三角牌阵
    [self setupTriangle];
    
    // 交错牌阵
    [self setupIntersect];
    
    // 伊西斯牌阵
    [self setupElement:TarotReadingIraq];
    
    // 元素牌阵
    [self setupElement:TarotReadingElement];
    
    // 变老牌阵
    [self setupOld];
    
    // 今天牌阵
    [self setupToday];
}

// 今天牌阵
- (void)setupToday{
    
    CGFloat W = (SCREEN_WIDTH - 136) * 0.3333333;
    CGFloat H = W / 3.0 * 5.0;

    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardOtherTopSpacing + CardH + CardOtherSpacing + CardH * 0.5 + 25;
    
    if ( kIsiPhoneXAll) {
        Y += 60;
    }
    
    NSArray *pointArray  = @[pointToValue(CGPointMake(X, Y - H)),pointToValue(CGPointMake(X  - W - 34, Y)),pointToValue(CGPointMake(X + 34 + W,Y))];

    NSArray *angleArray = @[integerToStr(0),integerToStr(0),integerToStr(0)];
    
    NSArray *cardIndex = @[integerToStr(1),integerToStr(2),integerToStr(3)];
    
    NSArray *cardSize = @[sizeToValue(CGSizeMake(W, H)),sizeToValue(CGSizeMake(W, H)),sizeToValue(CGSizeMake(W, H))];
    
    NSMutableArray *cardStatus = [NSMutableArray arrayWithArray:@[enumToString(CardDragStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus)]];
    
    NSMutableArray *titleArray = [NSMutableArray arrayWithArray: @[@"爱情",@"事业",@"财富"]];

    [self creatTarotReadingCarStatus:cardStatus tarotReadingType:TarotToday];
    
    [self createTarotReadMode:pointArray angleArray:angleArray cardArray:cardIndex tarotReadingType:TarotToday sizeArray:cardSize titlarray:titleArray];
}

// 变老牌阵
- (void)setupOld{

    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardIntersectTopSpacing + OldCardH * 0.5 - 15;
    
    NSArray *pointArray  = @[pointToValue(CGPointMake(X, Y))];
    
    NSArray *angleArray = @[integerToStr(0)];
    
    NSArray *cardIndex = @[integerToStr(0)];
    
    NSArray *cardSize = @[sizeToValue(CGSizeMake(OldCardW, OldCardH))];
    
    NSMutableArray *cardStatus = [NSMutableArray arrayWithArray:@[enumToString(CardDragStatus)]];
    
    [self creatTarotReadingCarStatus:cardStatus tarotReadingType:TarotOld];
    [self createTarotReadMode:pointArray angleArray:angleArray cardArray:cardIndex tarotReadingType:TarotOld sizeArray:cardSize];
    
    
}

// 交错牌阵
- (void)setupIntersect{
    
    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardIntersectTopSpacing + CardH * 0.5;
    
    CGFloat intersectSpacingValue =  (CardH - CardW) * 0.5;

    
    NSArray *pointArray  = @[pointToValue(CGPointMake(X - CardW - CardOtherSpacing -intersectSpacingValue ,Y)),pointToValue(CGPointMake(X, Y)),pointToValue(CGPointMake(X,Y)),pointToValue(CGPointMake(X + CardW + CardOtherSpacing + intersectSpacingValue, Y))];
    
    NSArray *angleArray = @[integerToStr(0),integerToStr(0),integerToStr(90),integerToStr(0)];
    
    NSArray *cardIndex = @[integerToStr(0),integerToStr(1),integerToStr(2),integerToStr(3)];
    
    NSArray *cardSize = @[sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardH, CardW)),sizeToValue(CGSizeMake(CardW, CardH))];
    
    NSMutableArray *cardStatus = [NSMutableArray arrayWithArray:@[enumToString(CardDragStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus)]];
    
    [self creatTarotReadingCarStatus:cardStatus tarotReadingType:TarotReadingIntersect];
    [self createTarotReadMode:pointArray angleArray:angleArray cardArray:cardIndex tarotReadingType:TarotReadingIntersect sizeArray:cardSize];
}

// 圣三角牌阵
- (void)setupTriangle{
    
    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardTriangleTopSpacing + CardH * 0.5;
    
    NSArray *pointArray  = @[pointToValue(CGPointMake(X,Y + CardH + CardOtherSpacing)),pointToValue(CGPointMake(X - CardOtherSpacing - CardW, Y)),pointToValue(CGPointMake(X + CardW + CardOtherSpacing,Y))];
    
    NSArray *angleArray = @[integerToStr(0),integerToStr(0),integerToStr(0)];
    
    NSArray *cardIndex = @[integerToStr(0),integerToStr(1),integerToStr(2)];
    
    NSArray *cardSize = @[sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH))];
    
    NSMutableArray *cardStatus = [NSMutableArray arrayWithArray:@[enumToString(CardDragStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus)]];
    
    [self creatTarotReadingCarStatus:cardStatus tarotReadingType:TarotReadingTriangle];
    [self createTarotReadMode:pointArray angleArray:angleArray cardArray:cardIndex tarotReadingType:TarotReadingTriangle sizeArray:cardSize];
}

// 菱形牌阵
- (void)setupDiamond{
    
    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardOtherTopSpacing + CardH * 0.5;
    
    NSArray *pointArray  = @[pointToValue(CGPointMake(X,Y)),pointToValue(CGPointMake(X - CardOtherSpacing - CardW, Y + CardOtherSpacing + CardH)),pointToValue(CGPointMake(X,Y + 2 * CardH + 2 *CardOtherSpacing)),pointToValue(CGPointMake(X + CardOtherSpacing + CardW, Y + CardOtherSpacing + CardH))];
    
    NSArray *angleArray = @[integerToStr(0),integerToStr(0),integerToStr(0),integerToStr(0)];
    
    NSArray *cardIndex = @[integerToStr(0),integerToStr(1),integerToStr(2),integerToStr(3)];
    
    NSArray *cardSize = @[sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH))];
    
    NSMutableArray *cardStatus = [NSMutableArray arrayWithArray:@[enumToString(CardDragStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus)]];
    
    [self setupDiamondPath];
    [self creatTarotReadingCarStatus:cardStatus tarotReadingType:TarotReadingDiamond];
    [self createTarotReadMode:pointArray angleArray:angleArray cardArray:cardIndex tarotReadingType:TarotReadingDiamond sizeArray:cardSize];
}

// 复合之树
- (void)setupTree{
    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardOtherTopSpacing + CardH + CardOtherSpacing + CardH * 0.5;
    
    NSArray *pointArray  = @[pointToValue(CGPointMake(X,Y + CardH + CardOtherSpacing)),pointToValue(CGPointMake(X,Y)),pointToValue(CGPointMake(X + CardOtherSpacing * 2 + CardW, Y)),pointToValue(CGPointMake(X - CardW - CardOtherSpacing * 2,Y)),pointToValue(CGPointMake(X, CardOtherTopSpacing + CardH * 0.5))];
    NSArray *angleArray = @[integerToStr(0),integerToStr(0),integerToStr(30),integerToStr(-30),integerToStr(0)];
    
    NSArray *cardIndex = @[integerToStr(0),integerToStr(1),integerToStr(2),integerToStr(3),integerToStr(4)];
    
    NSArray *cardSize = @[sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH))];
    
    NSMutableArray *cardStatus = [NSMutableArray arrayWithArray:@[enumToString(CardDragStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus)]];
    
    [self creatTarotReadingCarStatus:cardStatus tarotReadingType:TarotReadingTree];
    [self createTarotReadMode:pointArray angleArray:angleArray cardArray:cardIndex tarotReadingType:TarotReadingTree sizeArray:cardSize];
    
}

// 心灵牌阵
- (void)setupSoul{

    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardSoulTopSpacing + CardH * 0.5;

    NSArray *pointArray  = @[pointToValue(CGPointMake(X,Y + CardH + CardSoulTopSpacing * 0.5)),pointToValue(CGPointMake(X + CardOtherSpacing * 2 + CardW, Y + CardW * sin(angle2Rad(20)))),pointToValue(CGPointMake(X,Y)),pointToValue(CGPointMake(X - CardW - CardOtherSpacing * 2,Y + CardW * sin(angle2Rad(20))))];
    
     NSArray *angleArray = @[integerToStr(0),integerToStr(30),integerToStr(0),integerToStr(-30)];
    
    NSArray *cardIndex = @[integerToStr(0),integerToStr(1),integerToStr(2),integerToStr(3)];
    
    NSArray *cardSize = @[sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH))];
    
    NSMutableArray *cardStatus = [NSMutableArray arrayWithArray:@[enumToString(CardDragStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus)]];
    
    [self creatTarotReadingCarStatus:cardStatus tarotReadingType:TarotReadingSoul];
    [self createTarotReadMode:pointArray angleArray:angleArray cardArray:cardIndex tarotReadingType:TarotReadingSoul sizeArray:cardSize];
}

// 爱情大十字
- (void)setupLove{
    
    CGFloat X = SCREEN_WIDTH * 0.5;

    CGFloat Y = CardOtherTopSpacing + CardH + CardOtherSpacing + CardH * 0.5;

    NSArray *pointArray  = @[pointToValue(CGPointMake(X - CardW - CardOtherSpacing,Y)),pointToValue(CGPointMake(X + CardOtherSpacing + CardW, Y)),pointToValue(CGPointMake(X, CardOtherTopSpacing + CardH * 0.5)),pointToValue(CGPointMake(X,Y)),pointToValue(CGPointMake(X,Y + CardH + CardOtherSpacing))];
    
    NSArray *angleArray = @[integerToStr(0),integerToStr(0),integerToStr(0),integerToStr(0),integerToStr(0)];
    
    NSArray *cardIndex = @[integerToStr(0),integerToStr(1),integerToStr(2),integerToStr(3),integerToStr(4)];
    
    NSArray *cardSize = @[sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH))];
    
    NSMutableArray *cardStatus = [NSMutableArray arrayWithArray:@[enumToString(CardDragStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus)]];
    
    [self setupLovePath];
    
    [self creatTarotReadingCarStatus:cardStatus tarotReadingType:TarotReadingLove];
    [self createTarotReadMode:pointArray angleArray:angleArray cardArray:cardIndex tarotReadingType:TarotReadingLove sizeArray:cardSize];
}

- (void)setupX{
    
    
    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardXTopSpacing + CardH + CardH * 0.5;
    
    NSArray *pointArray  = @[pointToValue(CGPointMake(X ,Y - 11)),pointToValue(CGPointMake(X - CardW - CardOtherSpacing,Y - CardH)),pointToValue(CGPointMake(X + CardW + CardOtherSpacing,Y - CardH)),pointToValue(CGPointMake(X - CardW - CardOtherSpacing,Y + CardH - 22)),pointToValue(CGPointMake(X + CardW + CardOtherSpacing,Y + CardH - 22))];
    
    NSArray *angleArray = @[integerToStr(0),integerToStr(0),integerToStr(0),integerToStr(0),integerToStr(0)];
    
    NSArray *cardIndex = @[integerToStr(0),integerToStr(1),integerToStr(2),integerToStr(3),integerToStr(4)];
    
    NSArray *cardSize = @[sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH))];
    
    NSMutableArray *cardStatus = [NSMutableArray arrayWithArray:@[enumToString(CardDragStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus)]];
    
    [self setupXPath];
    
    [self creatTarotReadingCarStatus:cardStatus tarotReadingType:TarotReadingX];
    [self createTarotReadMode:pointArray angleArray:angleArray cardArray:cardIndex tarotReadingType:TarotReadingX sizeArray:cardSize];
}

// X 贝塞尔曲线
- (void)setupXPath{
    
    CGFloat X = SCREEN_WIDTH * 0.5;

    CGFloat Y = CardXTopSpacing + CardH;

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(X - CardW * 0.5 - CardOtherSpacing, Y)];
    [path addLineToPoint:CGPointMake(X - CardW * 0.5, Y + CardOtherSpacing - 11)];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(X + CardW * 0.5 + CardOtherSpacing, Y)];
    [path addLineToPoint:CGPointMake(X + CardW * 0.5, Y + CardOtherSpacing - 11)];
    
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(X - CardW * 0.5 - CardOtherSpacing, Y + CardH - 22)];
    [path addLineToPoint:CGPointMake(X - CardW * 0.5, Y - CardOtherSpacing - 11 + CardH)];
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(X + CardW * 0.5 + CardOtherSpacing, Y + CardH - 22)];
    [path addLineToPoint:CGPointMake(X + CardW * 0.5, Y - CardOtherSpacing - 11 + CardH)];
    
    [path appendPath:path1];
    [path appendPath:path2];
    [path appendPath:path3];
    
    [self creatTarotReadingCarPath:path tarotReadingType:TarotReadingX];
}

// 爱情大十字 贝塞尔曲线
- (void)setupLovePath{
    
    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardOtherTopSpacing + CardH;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(X, Y)];
    [path addLineToPoint:CGPointMake(X, Y + CardOtherSpacing)];
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(X + CardOtherSpacing + CardW * 0.5, Y + CardH * 0.5 + CardOtherSpacing)];
    [path1 addLineToPoint:CGPointMake(X + CardW * 0.5, Y + CardOtherSpacing + CardH * 0.5)];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(X - CardOtherSpacing - CardW * 0.5, Y + CardH * 0.5 + CardOtherSpacing)];
    [path2 addLineToPoint:CGPointMake(X - CardW * 0.5, Y + CardOtherSpacing + CardH * 0.5)];
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(X, Y + CardH + CardOtherSpacing)];
    [path3 addLineToPoint:CGPointMake(X, Y + CardH + 2 * CardOtherSpacing)];
    
    [path appendPath:path1];
    [path appendPath:path2];
    [path appendPath:path3];

    [self creatTarotReadingCarPath:path tarotReadingType:TarotReadingLove];
}

// 菱形牌阵 贝塞尔曲线
- (void)setupDiamondPath{
    
    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardOtherTopSpacing + CardH;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(X - CardW * 0.5, Y)];
    [path addLineToPoint:CGPointMake(X - CardOtherSpacing - CardW * 0.5, Y + CardOtherSpacing)];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(X + CardW * 0.5, Y)];
    [path1 addLineToPoint:CGPointMake(X + CardW * 0.5 + CardOtherSpacing , Y + CardOtherSpacing)];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(X - CardOtherSpacing - CardW * 0.5, Y + CardH + CardOtherSpacing)];
    [path2 addLineToPoint:CGPointMake(X - CardW * 0.5, Y + 2 * CardOtherSpacing + CardH)];
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(X + CardW * 0.5, Y + CardH + 2 * CardOtherSpacing)];
    [path3 addLineToPoint:CGPointMake(X + CardW * 0.5 + CardOtherSpacing, Y + CardH +  CardOtherSpacing)];
    
    [path appendPath:path1];
    [path appendPath:path2];
    [path appendPath:path3];
    [self creatTarotReadingCarPath:path tarotReadingType:TarotReadingDiamond];
}

// 恋人金字塔
- (void)setupPyramid:(TarotReadingType)readingType{
    
    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardOtherTopSpacing + CardH + CardOtherSpacing + CardH * 0.5;

    NSArray *pointArray  = @[pointToValue(CGPointMake(X,Y)),pointToValue(CGPointMake(X - CardOtherSpacing - CardW, Y)),pointToValue(CGPointMake(X + CardOtherSpacing + CardW,Y)),pointToValue(CGPointMake(X, CardOtherTopSpacing + CardH * 0.5))];
    
    NSArray *angleArray = @[integerToStr(0),integerToStr(0),integerToStr(0),integerToStr(0)];
    
    NSArray *cardIndex = @[integerToStr(0),integerToStr(1),integerToStr(2),integerToStr(3)];
    
    NSArray *cardSize = @[sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH))];
    
    NSMutableArray *cardStatus = [NSMutableArray arrayWithArray:@[enumToString(CardDragStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus)]];
    
    [self creatTarotReadingCarStatus:cardStatus tarotReadingType:readingType];
    [self createTarotReadMode:pointArray angleArray:angleArray cardArray:cardIndex tarotReadingType:readingType sizeArray:cardSize];
}

// 财富金字塔
- (void)setupWealth{
    
    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardOtherTopSpacing + CardH + CardOtherSpacing + CardH * 0.5;
    
    NSArray *pointArray  = @[pointToValue(CGPointMake(X, CardOtherTopSpacing + CardH * 0.5)),pointToValue(CGPointMake(X - CardOtherSpacing - CardW, Y)),pointToValue(CGPointMake(X,Y)),pointToValue(CGPointMake(X + CardOtherSpacing + CardW,Y))];

    NSArray *angleArray = @[integerToStr(0),integerToStr(0),integerToStr(0),integerToStr(0)];
    
    NSArray *cardIndex = @[integerToStr(0),integerToStr(1),integerToStr(2),integerToStr(3)];
    
    NSArray *cardSize = @[sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH))];
    
    NSMutableArray *cardStatus = [NSMutableArray arrayWithArray:@[enumToString(CardDragStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus)]];
    
    [self creatTarotReadingCarStatus:cardStatus tarotReadingType:TarotReadingWealth];
    [self createTarotReadMode:pointArray angleArray:angleArray cardArray:cardIndex tarotReadingType:TarotReadingWealth sizeArray:cardSize];
    
}

- (void)setupElement:(TarotReadingType)readingType{
    
    CGFloat X = SCREEN_WIDTH * 0.5;
    
    CGFloat Y = CardElementTopSpacing + CardH * 0.5;
    
   NSArray *pointArray  = @[pointToValue(CGPointMake(X - CardOtherSpacing - CardW,Y)),pointToValue(CGPointMake(X, Y)),pointToValue(CGPointMake(X + CardW + CardOtherSpacing,Y))];

    if (readingType == TarotReadingElement) {
        pointArray  = @[pointToValue(CGPointMake(X, Y)),pointToValue(CGPointMake(X - CardOtherSpacing - CardW,Y)),pointToValue(CGPointMake(X + CardW + CardOtherSpacing,Y))];
    }
    
    NSArray *angleArray = @[integerToStr(0),integerToStr(0),integerToStr(0)];
    
    NSArray *cardIndex = @[integerToStr(0),integerToStr(1),integerToStr(2)];
    
    NSArray *cardSize = @[sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH)),sizeToValue(CGSizeMake(CardW, CardH))];
    
    NSMutableArray *cardStatus = [NSMutableArray arrayWithArray:@[enumToString(CardDragStatus),enumToString(CardBlankStatus),enumToString(CardBlankStatus)]];
    
    [self creatTarotReadingCarStatus:cardStatus tarotReadingType:readingType];
    [self createTarotReadMode:pointArray angleArray:angleArray cardArray:cardIndex tarotReadingType:readingType sizeArray:cardSize];
    
}


- (void)creatTarotReadingCarStatus:(NSMutableArray *)cardStatusArray tarotReadingType:(TarotReadingType)tarotReadingType{
    [self.cardStatusDic setValue:cardStatusArray forKey: enumToString(tarotReadingType)];
}

- (void)createTarotReadMode:(NSArray <NSValue *>*)pointArray angleArray:(NSArray *)angleArray cardArray:(NSArray *)cardArray tarotReadingType:(TarotReadingType)tarotReadingType sizeArray:(NSArray *)sizeArray{
    
    TATarotReadingDrawMode *drawMode = [[TATarotReadingDrawMode alloc]init];
    
    NSMutableArray *modeArray = [NSMutableArray array];
    
    [cardArray enumerateObjectsUsingBlock:^(NSString *indexStr, NSUInteger idx, BOOL * _Nonnull stop) {
       
        TADrawLocationMode *locationMode = [[TADrawLocationMode alloc]initWith:[pointArray[idx] CGPointValue] angle:[angleArray[idx] integerValue] cardIndex:                                      [indexStr integerValue] cardSize:[sizeArray[idx] CGSizeValue]];
        
        [modeArray addObject:locationMode];
    }];
    drawMode.drawLOctionModeArray = modeArray;
    drawMode.tarotReadingName = @"爱情牌阵";
    
    [self.tarotReadingDic setValue:drawMode forKey:enumToString(tarotReadingType)];
}

- (void)createTarotReadMode:(NSArray <NSValue *>*)pointArray angleArray:(NSArray *)angleArray cardArray:(NSArray *)cardArray tarotReadingType:(TarotReadingType)tarotReadingType sizeArray:(NSArray *)sizeArray titlarray:(NSArray *)titlarray{
    
    TATarotReadingDrawMode *drawMode = [[TATarotReadingDrawMode alloc]init];
    
    NSMutableArray *modeArray = [NSMutableArray array];
    
    [cardArray enumerateObjectsUsingBlock:^(NSString *indexStr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TADrawLocationMode *locationMode = [[TADrawLocationMode alloc]initWith:[pointArray[idx] CGPointValue] angle:[angleArray[idx] integerValue] cardIndex:                                      [indexStr integerValue] cardSize:[sizeArray[idx] CGSizeValue]  cardName:titlarray[idx]];
        
        [modeArray addObject:locationMode];
    }];
    drawMode.drawLOctionModeArray = modeArray;
    drawMode.tarotReadingName = @"爱情牌阵";
    
    [self.tarotReadingDic setValue:drawMode forKey:enumToString(tarotReadingType)];
}

- (void)creatTarotReadingCarPath:(UIBezierPath *)path tarotReadingType:(TarotReadingType)tarotReadingType{
    [self.cardPathDic setValue:path forKey: enumToString(tarotReadingType)];
}

#pragma mark - lazy
- (NSMutableDictionary *)tarotReadingDic
{
    if (!_tarotReadingDic) {
        _tarotReadingDic = [NSMutableDictionary dictionary];
    }
    return _tarotReadingDic;
}

- (NSMutableDictionary *)cardStatusDic
{
    if (!_cardStatusDic) {
        _cardStatusDic = [NSMutableDictionary dictionary];
    }
    return _cardStatusDic;
}

- (NSMutableDictionary *)cardPathDic
{
    if (!_cardPathDic) {
        _cardPathDic = [NSMutableDictionary dictionary];
    }
    return _cardPathDic;
}

@end
