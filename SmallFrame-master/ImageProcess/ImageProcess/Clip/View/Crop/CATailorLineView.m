//
//  CATailorLineView.m
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/24.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "CATailorLineView.h"
#import "UIColor+SWCustomMethod.h"

@implementation CATailorLineView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rct = self.bounds;

    CGContextSetLineWidth(context, 0.5);
    
    CGContextBeginPath(context);
    CGFloat dW = 0;
    for(int i = 0; i < 4; ++i){
        if ( i == 1 || i == 2 ) {
            CGContextSetStrokeColorWithColor(context, [UIColor RGBColorWithR:255 G:255 B:255 alpha:0.7].CGColor);

        } else {
            CGContextSetStrokeColorWithColor(context, [UIColor RGBColorWithR:255 G:255 B:255 alpha:0.7].CGColor);
        }
        CGContextMoveToPoint(context, rct.origin.x+dW, rct.origin.y);
        CGContextAddLineToPoint(context, rct.origin.x+dW, rct.origin.y+rct.size.height);
        dW += _clippingRect.size.width/3;
        CGContextStrokePath(context);
    }
    
    dW = 0;
    for(int i = 0; i < 4; ++i){
        if ( i == 1 || i == 2 ) {
            CGContextSetStrokeColorWithColor(context, [UIColor RGBColorWithR:255 G:255 B:255 alpha:0.7].CGColor);
        } else {

            CGContextSetStrokeColorWithColor(context, [UIColor RGBColorWithR:255 G:255 B:255 alpha:0.7].CGColor);
        }
        CGContextMoveToPoint(context, rct.origin.x, rct.origin.y+dW);
        CGContextAddLineToPoint(context, rct.origin.x+rct.size.width, rct.origin.y+dW);
        dW += rct.size.height/3;
        
        CGContextStrokePath(context);
    }
}


@end
