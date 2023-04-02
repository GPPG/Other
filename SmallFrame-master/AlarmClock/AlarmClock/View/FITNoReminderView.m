
//
//  FITNoReminderView.m
//  fitness
//
//  Created by 郭鹏 on 2018/8/13.
//  Copyright © 2018年 supergeek. All rights reserved.
//

#import "FITNoReminderView.h"

@interface FITNoReminderView()

@property (nonatomic, strong) UIView *centerView;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *topHintLabel;

@property (nonatomic, strong) UILabel *bottomHintlabel;

@property (nonatomic, strong) UIButton *setBtn;


@end



@implementation FITNoReminderView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutSubView];
}


- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    self.setBtn.layer.cornerRadius = dp(25);
    self.setBtn.layer.masksToBounds = YES;
}

- (void)layoutSubView{
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self).offset(dp(-64));
        make.height.mas_offset(dp(335));
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerView);
        make.top.equalTo(self.centerView);
        make.height.mas_offset(dp(163));
        make.width.mas_offset(dp(163));
    }];
    
    [self.topHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerView);
        make.top.equalTo(self.headImageView.mas_bottom).offset(dp(27));
    }];
    
    [self.bottomHintlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerView);
        make.top.equalTo(self.topHintLabel.mas_bottom).offset(dp(9));
    }];
    
    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerView);
        make.top.equalTo(self.bottomHintlabel.mas_bottom).offset(dp(60));
        make.height.mas_offset(dp(50));
        make.width.mas_offset(dp(240));
    }];
    
}

#pragma mark - Action
- (void)setclockAction{
    
    if (self.setReminderBlock) {
        self.setReminderBlock();
    }
    
}

#pragma mark - lazy
- (UIView *)centerView
{
    if (!_centerView) {
        _centerView = [[UIView alloc]init];
        [self addSubview:_centerView];
    }
    return _centerView;
}

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"setting_reminder_empty"]];
        [self.centerView addSubview:_headImageView];
    }
    return _headImageView;
}

- (UILabel *)topHintLabel
{
    if (!_topHintLabel) {
        _topHintLabel = [[UILabel alloc]init];
        _topHintLabel.textAlignment = NSTextAlignmentCenter;
        _topHintLabel.font = [UIFont sfProDisplayBoldFontWithSize:18];
        [_topHintLabel setText:@"没有闹钟"];
        [_topHintLabel setTextColor:[UIColor colorWithHexString:@"#424242"]];
        [self.centerView addSubview:_topHintLabel];
        
    }
    return _topHintLabel;
}

- (UILabel *)bottomHintlabel
{
    if (!_bottomHintlabel) {
        _bottomHintlabel = [[UILabel alloc]init];
        _bottomHintlabel.textAlignment = NSTextAlignmentCenter;
        _bottomHintlabel.font = [UIFont sfProDisplayRegularFontWithSize:16];
        [_bottomHintlabel setText:@"赶快去设置一个闹钟吧"];
        [_bottomHintlabel setTextColor:[UIColor colorWithHexString:@"#aaaaaa"]];
        [self.centerView addSubview:_bottomHintlabel];
        
    }
    return _bottomHintlabel;
}

- (UIButton *)setBtn
{
    if (!_setBtn) {
        _setBtn = [[UIButton alloc]init];
        [_setBtn setTitle:@"设置闹钟" forState:UIControlStateNormal];
        [_setBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        _setBtn.titleLabel.font = [UIFont sfProDisplayBoldFontWithSize:17];
        _setBtn.backgroundColor = [UIColor colorWithRed:0.15 green:0.88 blue:0.56 alpha:1.00];
        [_setBtn addTarget:self action:@selector(setclockAction) forControlEvents:UIControlEventTouchUpInside];
        [self.centerView addSubview:_setBtn];
    }
    return _setBtn;
}


@end
