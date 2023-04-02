//
//  GPSetReminderController.m
//  AlarmClock
//
//  Created by 郭鹏 on 2019/12/23.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GPSetReminderController.h"
#import "FITSetMindWeekView.h"
#import "FITLocalPushMode.h"
#import "FITLocalNotificationTool.h"
#import "FITAlarmTitleTool.h"
#import "FITAlarmClockDataPickView.h"
@interface GPSetReminderController ()

@property (nonatomic, strong) FITAlarmClockDataPickView *alermPickDataView;

@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, strong) FITSetMindWeekView *weekdayView;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) NSArray *weekStrArray;

@end

@implementation GPSetReminderController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self addView];
    
    [self callBack];

}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self setLayout];
}

#pragma mark - Set Up

- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10,10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path = maskPath.CGPath;
    self.view.layer.mask = maskLayer;
}
- (void)addView{
    
    [self.view addSubview:self.alermPickDataView];
}


#pragma mark - Set

- (void)setSetReminderType:(SetReminderType)setReminderType{
    
    _setReminderType = setReminderType;
    if (setReminderType == setRemindAddType) {
        [self.alermPickDataView sethour:19 min:0];
        self.weekdayView.weekdayStateArray =  [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",nil];
    }else{
        self.weekdayView.weekdayStateArray = [NSMutableArray arrayWithArray:self.reminderSubData.allWeekdayStateArray];
    }
}

- (void)setReminderSubData:(FITReminderSubData *)reminderSubData{
    _reminderSubData = reminderSubData;
    
    NSLog(@"选中的时间:%ld---%ld",reminderSubData.strikeDate.jk_hour,reminderSubData.strikeDate.jk_minute);
    
    [self.alermPickDataView sethour:reminderSubData.strikeDate.jk_hour min:reminderSubData.strikeDate.jk_minute];
}

#pragma mark - Action
- (void)saveAction{
        
    // 添加新闹钟
    if (self.setReminderType == setRemindAddType) {

        [self addAlarmClock];
    }

    // 更新旧闹钟
    if (self.setReminderType == setRemindUpdateType) {
        
        [self updateAlarmClock];
    }
    
    if (self.saveActionBlock) {
        self.saveActionBlock();
    }

}


- (void)cancelAction{
        
    if (self.cancelActionBlock) {
        self.cancelActionBlock();
    }
}

#pragma mark - Private
- (void)addAlarmClock{
    
    NSInteger hourInt = self.alermPickDataView.selectHour;
    
    NSInteger minInt = self.alermPickDataView.selecMin;

    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 1; i <= 7; i ++) {
        
        FITLocalPushMode *pushMode = [[FITLocalPushMode alloc]init];
        FITAlarmTitleMode *mode = [FITAlarmTitleTool getLocalTitleMode];
        pushMode.localTitle = mode.localTitle;
        pushMode.localContent = mode.localContent;
        NSLog(@"标题:%@---内容:%@",mode.localTitle, mode.localContent);
        pushMode.localweekday = i;
        pushMode.localHour = hourInt;
        pushMode.localMin = minInt;
        [tempArray addObject:pushMode];
    }
    
    NSArray *array =  [FITLocalNotificationTool creationLocalLocalNotifictionS:tempArray];
    
    [self.savePushManger addLocalNotificationS:array selectWeekday:self.weekdayView.weekdayStateArray
     ];
}

- (void)updateAlarmClock{
    
    NSInteger hourInt = self.alermPickDataView.selectHour;
    
    NSInteger minInt = self.alermPickDataView.selecMin;
    
    [self.savePushManger updateLocalNotificationStrikeTime:self.reminderSubData.rowInt hour:hourInt min:minInt selectStateArray:self.weekdayView.weekdayStateArray];
}




#pragma mark - Call Back
- (void)callBack{
    WS(ws);
     self.weekdayView.noChoiceWeekBlock = ^(BOOL choiceState) {
         if (!choiceState) {
             ws.saveBtn.userInteractionEnabled = NO;
             [ws.saveBtn setTitleColor:[UIColor colorWithHexString:@"#aaaaaa"] forState:UIControlStateNormal];
         }else{
             ws.saveBtn.userInteractionEnabled = YES;
             [ws.saveBtn setTitleColor:[UIColor colorWithHexString:@"#13de96"] forState:UIControlStateNormal];

         }
     };
    
}

#pragma mark - Layout
- (void)setLayout{
    
    [self.weekdayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(dp(-60));
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(dp(36));
    }];

    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(dp(12));
        make.top.equalTo(self.view).offset(dp(24));
    }];

    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(dp(-12));
        make.bottom.equalTo(self.cancelBtn.mas_bottom);
    }];
        
    [self.alermPickDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.weekdayView.mas_top).offset(kIsiPhone4S ? dp(-10) : dp(-40));
        make.height.mas_offset(kIsiPhoneX ? dp(180) :dp(130));
        make.width.mas_offset(dp(260));
        make.centerX.equalTo(self.view);
    }];
}
#pragma mark - Lazy

- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc]init];
        [_saveBtn setTitle:@"储存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor colorWithHexString:@"#13de96"] forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [UIFont sfProDisplayRegularFontWithSize:18];
        [_saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_saveBtn];
    }
    return _saveBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]init];
        [_cancelBtn setTitle:@"取消"forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#aaaaaa"] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont sfProDisplayRegularFontWithSize:18];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (FITAlarmClockDataPickView *)alermPickDataView
{
    if (!_alermPickDataView) {
        _alermPickDataView = [[FITAlarmClockDataPickView alloc]init];
    }
    return _alermPickDataView;
}

- (FITSetMindWeekView *)weekdayView
{
    if (!_weekdayView) {
        _weekdayView = [[FITSetMindWeekView alloc]init];
        [self.view addSubview:_weekdayView];
    }
    return _weekdayView;
}

- (NSArray *)weekStrArray
{
    if (!_weekStrArray) {
        _weekStrArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    return _weekStrArray;
}
@end
