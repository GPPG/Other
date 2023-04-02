
//
//  TADarwCardCollectionViewLayoutAttributes.m
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/12.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import "TADarwCardCollectionViewLayoutAttributes.h"

@interface TADarwCardCollectionViewLayoutAttributes ()<NSCopying>




@end


@implementation TADarwCardCollectionViewLayoutAttributes

-(void)setAngle:(CGFloat)angle
{
    
    _angle = angle;
    
    self.zIndex = (int)(angle * 1000000);
    self.transform = CGAffineTransformMakeRotation(angle);
//    CGFloat x = 2 * sin(angle / 2) * 600;
//    self.transform = CGAffineTransformMakeTranslation(x, 0);
}

-(id)copyWithZone:(NSZone *)zone
{
    
    TADarwCardCollectionViewLayoutAttributes *attributes =  [super copyWithZone:zone];
    attributes.anchorPoint = self.anchorPoint;
    attributes.angle = self.angle;
    return attributes;
}

@end
