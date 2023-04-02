


//
//  FITRemindSwitchView.m
//  fitness
//
//  Created by 郭鹏 on 2018/10/10.
//  Copyright © 2018 supergeek. All rights reserved.
//

#import "FITRemindSwitchView.h"

@interface FITRemindSwitchView()

@property (nonatomic, strong) UISwitch *onOffSwitch;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *containerView;

@end

@implementation FITRemindSwitchView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addView];
    }
    return self;
}


- (void)addView{
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.onOffSwitch];
    [self.containerView addSubview:self.contentLabel];
}


- (void)setSwitchStatus:(BOOL)switchStatus{
    _switchStatus = switchStatus;
    self.onOffSwitch.on = switchStatus;
}

- (void)switchAction:(UISwitch *)onOffSwitch{
    
    if (self.switchActionBlock) {
        self.switchActionBlock(onOffSwitch.on);
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.mas_equalTo(-12);
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];
    
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.containerView);
        make.left.equalTo(self.containerView).offset(dp(24));
    }];
    
    [self.onOffSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentLabel);
        make.right.equalTo(self.containerView).offset(dp(-18));
    }];

    
}

- (UISwitch *)onOffSwitch
{
    if (!_onOffSwitch) {
        _onOffSwitch = [[UISwitch alloc]init];
        [_onOffSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _onOffSwitch;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.text = NSLocalizedString(@"Training Reminder", nil);
        _contentLabel.font = [UIFont sfProDisplayBoldFontWithSize:20];
    }
    return _contentLabel;
}

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

@end
