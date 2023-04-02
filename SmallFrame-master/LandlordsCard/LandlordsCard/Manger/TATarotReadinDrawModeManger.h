//
//  TATarotReadinDrawModeManger.h
//  Tarot
//
//  Created by 郭鹏 on 2019/1/3.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TATarotReadingDrawMode.h"
#import "TATarotReading.h"



NS_ASSUME_NONNULL_BEGIN

@interface TATarotReadinDrawModeManger : NSObject

/**
 初始化牌阵数据
 */
- (void)setupReadModeDic;

- (void)setupOld;

- (void)setupToday;

/**
 根据牌阵ID,获取牌阵的信息

 @param tarotReadingType 牌阵ID
 @return 牌阵信息
 */
- (TATarotReadingDrawMode *)queryReadingMode:(TarotReadingType)tarotReadingType;

/**
 根据牌阵ID,获取牌阵卡片初始化状态

 @param tarotReadingType 牌阵ID
 @return 牌阵状态
 */
- (NSMutableArray *)queryReadingCardStatus:(TarotReadingType)tarotReadingType;


/**
 根据牌阵ID,获取牌阵卡片连线
 
 @param tarotReadingType 牌阵ID
 @return 牌阵状态
 */
- (UIBezierPath *)queryReadingCardPath:(TarotReadingType)tarotReadingType;

/**
 更新牌阵卡片状态

 @param tarotReadingType 牌阵类型
 @param index 牌阵卡片编号
 @return 牌阵状态
 */
- (NSArray *)updateReadingCardStatus:(TarotReadingType)tarotReadingType cardIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
