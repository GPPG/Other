//
//  CACorpRatio.m
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/23.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "CACorpRatio.h"

@implementation CACorpRatio{
    CGFloat _longSide;
    CGFloat _shortSide;
}

- (id)initWithValue1:(CGFloat)value1 value2:(CGFloat)value2 {
    self = [super init];
    if(self){
        _value1 = value1;
        _value2 = value2;
    }
    return self;
}
- (NSString*)description {
    NSString *format = (self.titleFormat) ? self.titleFormat : @"%g : %g";
    
    if(self.isLandscape){
        return [NSString stringWithFormat:format, _longSide, _shortSide];
    }
    return [NSString stringWithFormat:format, _shortSide, _longSide];
}
- (CGFloat)ratio {
    if(_value2==0 || _value1==0){
        return 0;
    }
    return _value2 / (CGFloat)_value1;
}


@end
