//
//  TATarReadingDrawContentMode.m
//  Tarot
//
//  Created by 郭鹏 on 2019/1/9.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "TATarReadingDrawContentMode.h"

@implementation TATarReadingDrawContentMode

- (instancetype)initWithMode{
    
    if (self = [super init]) {
        [self setup];
    }
    return self;
    
}

- (void)setup{
    
    self.spreadId = 1;
    self.topicId =  @"12";
    self.topicName = @"加油";
    
    NSArray *tempCardArray = SUPPORT_SPREAD_LIST;
    
    // 假数据
    NSInteger idVaule = arc4random() % 11;
    self.spreadId = [tempCardArray[idVaule] integerValue];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    TATarReadingDrawCardMode *mode = [[TATarReadingDrawCardMode alloc]init];
    mode.cardType = YES;
    mode.cardID = @"1";
    TATarReadingDrawCardMode *mode1 = [[TATarReadingDrawCardMode alloc]init];
    mode1.cardType = YES;
    mode1.cardID = @"6";
    
    TATarReadingDrawCardMode *mode2 = [[TATarReadingDrawCardMode alloc]init];
    mode2.cardType = YES;
    mode2.cardID = @"8";
    
    TATarReadingDrawCardMode *mode3 = [[TATarReadingDrawCardMode alloc]init];
    mode3.cardType = NO;
    mode3.cardID = @"9";
    TATarReadingDrawCardMode *mode4 = [[TATarReadingDrawCardMode alloc]init];
    mode4.cardType = NO;
    mode4.cardID = @"10";
    TATarReadingDrawCardMode *mode5 = [[TATarReadingDrawCardMode alloc]init];
    mode5.cardType = NO;
    mode5.cardID = @"11";
    TATarReadingDrawCardMode *mode6 = [[TATarReadingDrawCardMode alloc]init];
    mode5.cardType = NO;
    mode5.cardID = @"13";
    
    [tempArray addObject:mode];
    [tempArray addObject:mode1];
    [tempArray addObject:mode2];
    [tempArray addObject:mode3];
    [tempArray addObject:mode4];
    [tempArray addObject:mode5];
    [tempArray addObject:mode6];
    self.cardModeArray = [tempArray copy];
}

@end


@implementation TATarReadingDrawCardMode

@end
