

//
//  FITRemindWeekView.m
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/10.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import "FITRemindWeekView.h"

@interface FITRemindWeekView()


@property (nonatomic, strong) NSMutableArray *subViewArray;


@end

@implementation FITRemindWeekView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        

    }
    return self;
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat leftPadding = dp(24);
    
    CGFloat rightPadding = dp(W - (self.contentArray.count - 1) * 21 - leftPadding - self.contentArray.count * 25);
    
    if (self.subViewArray.count == 0) {
        return;
    }else if (self.subViewArray.count == 1){
        
        [self.subViewArray.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(dp(27));
            make.top.equalTo(self).offset(dp(3));
        }];

    } else{

        [self.subViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:kIsiPhone4S ? 10 : 21 leadSpacing:leftPadding tailSpacing:rightPadding];
        
        [self.subViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
            UILabel *label = self.subViewArray.firstObject;
            make.height.mas_equalTo(label.mas_width);
            make.top.equalTo(self);
        }];
    }
}

- (void)setContentArray:(NSArray *)contentArray{
    
    _contentArray = contentArray;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self setupUI];
}


- (void)setupUI{
    
    self.subViewArray = [NSMutableArray array];
    
    [self.contentArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont sfProDisplayRegularFontWithSize:15];
        [label setTextColor: self.labelColor];
        label.text = obj;
        [self addSubview:label];
        [self.subViewArray addObject:label];
    }];
}

@end
