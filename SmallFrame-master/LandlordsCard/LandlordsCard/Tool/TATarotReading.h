//
//  TATarotReading.h
//  Tarot
//
//  Created by 郭鹏 on 2019/1/4.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#ifndef TATarotReading_h
#define TATarotReading_h


//  元素头部间距
#define CardElementTopSpacing  180

//  心灵头部间距
#define CardSoulTopSpacing  114

// X 头部间距
#define CardXTopSpacing  128

// 圣三角头部间距
#define CardTriangleTopSpacing  138
// 交错头部间距
#define CardIntersectTopSpacing 180
// 恋人,爱情,复合树,菱形
#define CardOtherTopSpacing  (kIsSmallScreen ?  20 : 92)
// 牌间距
#define CardOtherSpacing 27

#define CardH 96

#define CardW CardH / 5.0 * 3.0

#define OldCardW (SCREEN_WIDTH - 236)

#define OldCardH OldCardW / 3.0 * 5.0

#define OldCardTopSpacing (CardIntersectTopSpacing  - 15)

// 牌阵卡片状态
typedef NS_ENUM(NSInteger,CardStatus){
    
    
    CardBlankStatus = 0,
    CardDragStatus,
    CardPlaceholderStatus,
    CardNormalStatus,
};


// 牌阵枚举
typedef NS_ENUM(NSInteger,TarotReadingType){
    
    TarotReadingLove = 501, // 爱情大十字
    TarotReadingTree = 502, // 复合之树
    TarotReadingPyramid = 401, // 恋人金字塔
    TarotReadingDiamond = 402, // 菱形牌阵
    TarotReadingIntersect = 403, //交错牌阵
    TarotReadingTriangle = 301, // 圣三角牌阵
    TarotReadingWealth = 405, // 财富金字塔牌阵
    TarotReadingCareer = 404, // 事业金字塔牌阵
    TarotReadingSoul = 406, // 心灵之光牌阵
    TarotReadingIraq = 303, // 伊西斯牌阵
    TarotReadingElement = 302, // 元素牌阵
    TarotReadingX = 503, //X牌阵
    TarotOld = 999, //变老牌阵
    TarotToday = 1000, //今天牌阵

};


#endif /* TATarotReading_h */
