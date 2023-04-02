//
//  CATailorCornerView.m
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/24.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "CATailorCornerView.h"
#import "UIColor+SWCustomMethod.h"
#import "UIView+HXExtension.h"

@implementation CATailorCornerView

- (void)drawRect:(CGRect)rect {
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    bezier.lineWidth = 2.5f;
    bezier.lineCapStyle = kCGLineCapButt;
    CGFloat margin = bezier.lineWidth / 2.f;
    if (self.tag == 0) {
        [bezier moveToPoint:CGPointMake(self.hx_w / 2 - margin, self.hx_h)];
        [bezier addLineToPoint:CGPointMake(self.hx_w / 2 - margin, self.hx_h / 2 - margin)];
        [bezier addLineToPoint:CGPointMake(self.hx_w, self.hx_h / 2 - margin)];
    }else if (self.tag == 1) {
        [bezier moveToPoint:CGPointMake(self.hx_w / 2 - margin, 0)];
        [bezier addLineToPoint:CGPointMake(self.hx_w / 2 - margin, self.hx_h / 2 + margin)];
        [bezier addLineToPoint:CGPointMake(self.hx_w, self.hx_h / 2 + margin)];
    }else if (self.tag == 2) {
        [bezier moveToPoint:CGPointMake(0, self.hx_h / 2 - margin)];
        [bezier addLineToPoint:CGPointMake(self.hx_w / 2 + margin, self.hx_h / 2 - margin)];
        [bezier addLineToPoint:CGPointMake(self.hx_w / 2 + margin, self.hx_h)];
    }else {
        [bezier moveToPoint:CGPointMake(0, self.hx_h / 2 + margin)];
        [bezier addLineToPoint:CGPointMake(self.hx_w / 2 + margin, self.hx_h / 2 + margin)];
        [bezier addLineToPoint:CGPointMake(self.hx_w / 2 + margin, 0)];
    }
    
    [[UIColor whiteColor] set];
    [bezier stroke];
    
}

@end
