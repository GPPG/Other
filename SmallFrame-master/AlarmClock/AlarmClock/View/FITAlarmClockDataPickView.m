//
//  FITAlarmClockDataPickView.m
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/20.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import "FITAlarmClockDataPickView.h"

@interface FITAlarmClockDataPickView()<PGPickerViewDelegate, PGPickerViewDataSource>

@property (nonatomic, strong) NSArray *hourArray;

@property (nonatomic, strong) NSArray *minArray;

@property (nonatomic, strong) NSArray *amPmArray;

@property (nonatomic, strong) PGPickerView *pickerView;

@property (nonatomic, copy) NSString *lastHourStr;

@property (nonatomic, copy) NSString *lastMinStr;

@property (nonatomic, assign) NSInteger lastPM;

@end

@implementation FITAlarmClockDataPickView


#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.pickerView = [[PGPickerView alloc]init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.type = PGPickerViewType1;
    self.pickerView.rowHeight = kIsiPhone4S ? 30 : 45;
    self.pickerView.isHiddenMiddleText = false;
    self.pickerView.lineBackgroundColor = [UIColor lightGrayColor];
    self.pickerView.textColorOfSelectedRow = [UIColor colorWithHexString:@"#424242"];
    self.pickerView.textColorOfOtherRow = [UIColor colorWithHexString:@"#BBBBBB"];
    self.pickerView.textFontOfOtherRow = [UIFont sfProDisplayBoldFontWithSize:20];
    self.pickerView.textFontOfSelectedRow = [UIFont sfProDisplayBoldFontWithSize:30];
    [self addSubview:self.pickerView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).offset(0);
    }];
}

#pragma mark - 公共方法
- (void)sethour:(NSInteger)hourInt min:(NSInteger)minInt{
    
    NSInteger amRow = 0;
    
    if (hourInt > 12 || hourInt == 0) {
        hourInt = hourInt - 12;
        amRow = 1;
    }
    if (hourInt < 0) {
        hourInt = 12;
    }
    self.lastPM = amRow;
    self.lastHourStr = [NSString stringWithFormat:@"%ld",hourInt];
    self.lastMinStr = [NSString stringWithFormat:@"%ld",minInt];
    
    NSLog(@"选中的时间---小时:%ld--%ld---%ld",hourInt,minInt,amRow);
    
    [self.pickerView selectRow:hourInt - 1 inComponent:0 animated:NO];
    [self.pickerView selectRow:minInt inComponent:1 animated:NO];
    [self.pickerView selectRow:amRow inComponent:2 animated:NO];
}

#pragma UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(PGPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(PGPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSInteger rowInt = 0;
    if (component == 0) {
        rowInt = self.hourArray.count;
    }
    if (component == 1) {
        rowInt = self.minArray.count;
    }
    if (component == 2) {
        rowInt = self.amPmArray.count;
    }
    return rowInt;
}

#pragma UIPickerViewDelegate
- (nullable NSString *)pickerView:(PGPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *str;
    if (component == 0) {
        str = self.hourArray[row];
    }
    if (component == 1) {
        str = self.minArray[row];
    }
    if (component == 2) {
        str = self.amPmArray[row];
    }
    return str;
}

- (void)pickerView:(PGPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            self.lastHourStr = self.hourArray[row];
            break;
        case 1:
            self.lastMinStr = self.minArray[row];
            break;
        case 2:
            self.lastPM = row;
            break;
        default:
            break;
    }
    [self handleData:self.lastHourStr minStr:self.lastMinStr pm:self.lastPM];
}

#pragma mark - private
- (void)handleData:(NSString *)hourStr minStr:(NSString *)minStr pm:(BOOL)pm{
    
    NSInteger hourInt = [hourStr integerValue];
    NSInteger minInt = [minStr integerValue];
    
    if (pm) {
        hourInt = hourInt + 12;
        if (hourInt == 24) {
            hourInt = 00;
        }
    }
    
    if (self.selectTimeBlcok) {
        self.selectTimeBlcok(hourInt, minInt);
    }
    
    self.selectHour = hourInt;
    self.selecMin = minInt;
    
    NSLog(@"小时:%ld---分钟:%ld",hourInt,minInt);
}

#pragma mark - lazy
- (NSArray *)hourArray
{
    if (!_hourArray) {
        _hourArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    }
    return _hourArray;
}

- (NSArray *)minArray
{
    if (!_minArray) {
        _minArray = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59" ];
    }
    return _minArray;
}

- (NSArray *)amPmArray
{
    if (!_amPmArray) {
        _amPmArray = @[@"上午",@"下午"];
    }
    return _amPmArray;
}
@end
