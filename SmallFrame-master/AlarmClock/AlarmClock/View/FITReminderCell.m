


//
//  FITReminderCell.m
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/10.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import "FITReminderCell.h"
#import "FITRemindWeekView.h"


@interface FITReminderCell()

@property (nonatomic, strong) UILabel *timerLabel;

@property (nonatomic, strong) UILabel *timeUnitLabel;

@property (nonatomic, strong) UISwitch *onOffSwitch;

@property (nonatomic, strong) FITRemindWeekView *remindWeekView;

@property (nonatomic, strong) UIView *centerView;

@end


@implementation FITReminderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        
    }
    return self;
}


- (void)setupUI{
    
    self.contentView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.onOffSwitch.hidden = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.and.right.and.bottom.equalTo(self.contentView);
    }];
    
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView).offset(dp(24));
        make.left.equalTo(self.centerView).offset(dp(24));
    }];
    
    [self.timeUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timerLabel.mas_right).offset(dp(12));
        make.bottom.equalTo(self.timerLabel.mas_bottom).offset(dp(-6));
    }];
    
    [self.onOffSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timerLabel);
        make.right.equalTo(self.centerView).offset(dp(-18));
    }];
    
    [self.remindWeekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timerLabel.mas_bottom).offset(dp(10));
        make.left.equalTo(self.centerView);
        make.right.equalTo(self.centerView);
    }];
}

#pragma mark - set
- (void)setReminderSubData:(FITReminderSubData *)reminderSubData{
    
    _reminderSubData = reminderSubData;
    
    
    if (reminderSubData.switchState) {
        
        [self.timeUnitLabel setTextColor:[UIColor colorWithHexString:@"#aaaaaa"]];
        [self.timerLabel setTextColor:[UIColor colorWithHexString:@"#424242"]];
        self.remindWeekView.labelColor = [UIColor colorWithHexString:@"#424242"];
        
    }else{

        [self.timerLabel setTextColor:[UIColor colorWithHexString:@"#aaaaaa"]];
        [self.timeUnitLabel setTextColor:[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00]];
        self.remindWeekView.labelColor = [UIColor colorWithHexString:@"#aaaaaa"];
    }
    
    self.timerLabel.text = reminderSubData.timeStr;
    self.timeUnitLabel.text = reminderSubData.timeUnitStr;
    self.onOffSwitch.on = reminderSubData.switchState;
    self.remindWeekView.contentArray = reminderSubData.weekdayArray;
    
}

-(void)setFrame:(CGRect)frame
{
    if (frame.size.height == 120) {
        
    }else{
        frame.size.height -= 12;
    }
    [super setFrame:frame];
}

#pragma mark - Action
- (void)switchAction:(UISwitch *)onOffSwitch{
    
    if (self.switchActionBlock) {
        self.switchActionBlock(onOffSwitch.on);
    }

}

#pragma mark - lazy

- (FITRemindWeekView *)remindWeekView
{
    if (!_remindWeekView) {
        _remindWeekView = [[FITRemindWeekView alloc]init];
        [self.centerView addSubview:_remindWeekView];
    }
    return _remindWeekView;
}

- (UIView *)centerView
{
    if (!_centerView) {
        _centerView = [[UIView alloc]init];
        _centerView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_centerView];
    }
    return _centerView;
}

- (UILabel *)timerLabel
{
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc]init];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
        _timerLabel.font = [UIFont sfProDisplayBoldFontWithSize:39];
        [self.centerView addSubview:_timerLabel];
    }
    return _timerLabel;
}

- (UILabel *)timeUnitLabel
{
    if (!_timeUnitLabel) {
        _timeUnitLabel = [[UILabel alloc]init];
        _timeUnitLabel.textAlignment = NSTextAlignmentCenter;
        _timeUnitLabel.font = [UIFont sfProDisplayBoldFontWithSize:18];
        [self.centerView addSubview:_timeUnitLabel];
    }
    return _timeUnitLabel;
}

- (UISwitch *)onOffSwitch
{
    if (!_onOffSwitch) {
        _onOffSwitch = [[UISwitch alloc]init];
        [_onOffSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [self.centerView addSubview:_onOffSwitch];
    }
    return _onOffSwitch;
}
@end
