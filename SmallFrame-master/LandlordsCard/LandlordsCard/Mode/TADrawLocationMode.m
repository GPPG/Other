
//
//  TADrawLocationMode.m
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/13.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import "TADrawLocationMode.h"

@implementation TADrawLocationMode

- (instancetype)initWith:(CGPoint) centerPoint angle:(CGFloat)angle{
    if (self = [super init]) {
        self.centerPoint = centerPoint;
        self.angle = angle;
    }
    return self;
}

- (instancetype)initWith:(CGPoint) centerPoint angle:(CGFloat)angle cardIndex:(NSInteger)cardIndex{

    if (self = [super init]) {
        self.centerPoint = centerPoint;
        self.angle = angle;
        self.cardIndex = cardIndex;
    }
    return self;
}


- (instancetype)initWith:(CGPoint) centerPoint angle:(CGFloat)angle cardIndex:(NSInteger)cardIndex cardSize:(CGSize)cardSize{
    if (self = [super init]) {
        self.centerPoint = centerPoint;
        self.angle = angle;
        self.cardIndex = cardIndex;
        self.cardSize = cardSize;
    }
    return self;
}

- (instancetype)initWith:(CGPoint) centerPoint angle:(CGFloat)angle cardIndex:(NSInteger)cardIndex cardSize:(CGSize)cardSize cardName:(NSString *)cardNameStr{
    if (self = [super init]) {
        self.centerPoint = centerPoint;
        self.angle = angle;
        self.cardIndex = cardIndex;
        self.cardSize = cardSize;
        self.cardNameStr = cardNameStr;
    }
    return self;

    
    
}


@end
