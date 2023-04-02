//
//  GPFlighData.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/4/5.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "GPFlighData.h"

@interface GPFlighData()
@property (nonatomic, strong) NSArray *flightArrray;
@end

@implementation GPFlighData
- (instancetype)initWithIsBeiJing:(BOOL)IsBeiJing
{
    if (self = [super init]) {
        [self getFlighData:IsBeiJing];
    }
    return self;
}

- (void)getFlighData:(BOOL)IsBeiJing
{
    NSArray *tempDataArray;
    if (IsBeiJing) {
        tempDataArray = self.flightArrray.firstObject;
    }else{
        tempDataArray = self.flightArrray.lastObject;
    }
    
    self.summaryStr = tempDataArray[0];
    self.flightNrStr = tempDataArray[1];
    self.gateNrStr = tempDataArray[2];
    self.departingFromStr = tempDataArray[3];
    self.arrivingToStr = tempDataArray[4];
    self.weatherImageNameStr = tempDataArray[5];
    self.showWeatherEffects = [tempDataArray[6] integerValue];
    self.TakingOff = [tempDataArray[7] integerValue];
    
    self.flightStatusStr = tempDataArray[8];
}
#pragma mark - 懒加载
- (NSArray *)flightArrray
{
    if (!_flightArrray) {
        _flightArrray = @[@[@"2017 04 10:47",@"NH 2",@"A33",@"北京",@"上海",@"bg-snowy",@"1",@"1",@"飞行"],@[@"2017 04 18:40",@"AE 1",@"045",@"上海",@"广州",@"bg-sunny",@"0",@"0",@"延迟"]];
    }
    return _flightArrray;
}
@end
