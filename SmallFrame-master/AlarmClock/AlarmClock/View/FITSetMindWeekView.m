
//
//  FITSetMindWeekView.m
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/10.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import "FITSetMindWeekView.h"
#import "FITHightBtn.h"

@interface FITSetMindWeekView()

@property (nonatomic, strong) NSMutableArray *subArray;




@end

@implementation FITSetMindWeekView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    
    self.subArray = [NSMutableArray array];
    
    NSArray *titleArray = @[NSLocalizedString(@"Su",nil),NSLocalizedString(@"Mo",nil),NSLocalizedString(@"Tu",nil),NSLocalizedString(@"We",nil),NSLocalizedString(@"Th",nil),NSLocalizedString(@"Fr",nil),NSLocalizedString(@"Sa",nil)];
    
    for (int i = 0; i < 7; i ++) {
        
        FITHightBtn *btn = [[FITHightBtn alloc]init];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#424242"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage createImageHexColor:@"#13de96" size:CGSizeMake(36, 36)] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage createImageHexColor:@"#ffffff" size:CGSizeMake(36, 36)] forState:UIControlStateNormal];

        btn.tag = i;
        [btn addTarget:self action:@selector(weekAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 18;
        btn.layer.masksToBounds = YES;
        [self addSubview:btn];
        [self.subArray addObject:btn];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat padding = ([UIScreen mainScreen].bounds.size.width - 7 * 36) / 8;
    
    [self.subArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:36 leadSpacing:padding tailSpacing:padding];
    
    [self.subArray mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *tempView = self.subArray[0];
        make.height.equalTo(tempView.mas_width);
        make.centerY.equalTo(self);
    }];
}

- (void)setWeekdayStateArray:(NSMutableArray *)weekdayStateArray{
    
    _weekdayStateArray = weekdayStateArray;
    
    [weekdayStateArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSInteger tempState = [obj integerValue];
        
        FITHightBtn *btn = self.subArray[idx];
        
        if (tempState) {
            btn.selected = YES;
            btn.titleLabel.font =[UIFont sfProDisplayBoldFontWithSize:14];
        }else{
            btn.selected = NO;
            btn.titleLabel.font =[UIFont sfProDisplayRegularFontWithSize:14];

        }
    }];
    
}


#pragma mark - Action
- (void)weekAction:(UIButton *)weekBtn{

    weekBtn.selected = !weekBtn.selected;
    
    if (weekBtn.selected) {
        weekBtn.titleLabel.font =[UIFont sfProDisplayBoldFontWithSize:14];
        [self.weekdayStateArray replaceObjectAtIndex:weekBtn.tag withObject:@"1"];
    }else{
        weekBtn.titleLabel.font =[UIFont sfProDisplayRegularFontWithSize:14];
        [self.weekdayStateArray replaceObjectAtIndex:weekBtn.tag withObject:@"0"];
    }
    NSLog(@"%@",self.weekdayStateArray);
    
   __block BOOL choiceState = NO;

    [self.weekdayStateArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj integerValue] == 1) {
            choiceState = YES;
        }
    }];
    
    if (self.noChoiceWeekBlock) {
        self.noChoiceWeekBlock(choiceState);
    }
}

- (NSString *)statisticalStr{
    
    
    return _statisticalStr;
}

@end
