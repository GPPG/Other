//
//  TADrawLocationMode.h
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/13.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TADrawLocationMode : NSObject

@property (nonatomic, assign) CGPoint centerPoint;

@property(assign,nonatomic) CGFloat angle;

@property (nonatomic, assign) NSInteger cardIndex;

@property (nonatomic, assign) CGSize cardSize;

@property (nonatomic, copy) NSString *cardNameStr;


- (instancetype)initWith:(CGPoint) centerPoint angle:(CGFloat)angle;

- (instancetype)initWith:(CGPoint) centerPoint angle:(CGFloat)angle cardIndex:(NSInteger)cardIndex;

- (instancetype)initWith:(CGPoint) centerPoint angle:(CGFloat)angle cardIndex:(NSInteger)cardIndex cardSize:(CGSize)cardSize;

- (instancetype)initWith:(CGPoint) centerPoint angle:(CGFloat)angle cardIndex:(NSInteger)cardIndex cardSize:(CGSize)cardSize cardName:(NSString *)cardNameStr;


@end

NS_ASSUME_NONNULL_END
