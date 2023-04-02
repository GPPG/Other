//
//  CACorpCornerView.m
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/23.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "CACorpCornerView.h"
#import "UIColor+SWCustomMethod.h"
#import "UIView+HXExtension.h"

@implementation CACorpCornerView

- (void)drawRect:(CGRect)rect {
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    bezier.lineWidth = 2.5f;
    bezier.lineCapStyle = kCGLineCapButt;
    if (self.tag == 0) {
        [bezier addArcWithCenter:CGPointMake(self.hx_w / 2, self.hx_h / 2) radius:6 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
    }else if (self.tag == 1) {
        [bezier addArcWithCenter:CGPointMake(self.hx_w / 2, self.hx_h / 2) radius:6 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }else if (self.tag == 2) {
        [bezier addArcWithCenter:CGPointMake(self.hx_w / 2, self.hx_h / 2) radius:6 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }else {
        [bezier addArcWithCenter:CGPointMake(self.hx_w / 2, self.hx_h / 2) radius:6 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }
    
    [[UIColor RGBColorWithR:149 G:109 B:255 alpha:1.0] set];
    [[UIColor RGBColorWithR:149 G:109 B:255 alpha:1.0] setFill];
    [bezier stroke];
    [bezier fill];//此方法为填充圆的方法
}

@end
