//
//  GPReminderController.m
//  AlarmClock
//
//  Created by 郭鹏 on 2019/12/23.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GPReminderController.h"
#import "FITReminderCell.h"
#import "GPSetReminderController.h"

#import "FITLocalPushMode.h"
#import "FITLocalPushManger.h"
#import "FITSaveLocalPushModeManger.h"
#import "FITLocalNotificationTool.h"

#import "FITReminderData.h"
#import "FITPopCantainerTool.h"
#import "UITableView+PlaceHolderView.h"
#import "FITNoReminderView.h"
#import "FITRemindNoAuthorView.h"
#import "FITWorkoutReminderViewStatusMode.h"
#import "FITRemindSwitchView.h"
#import "FITRemindViewStatus.h"
#import "FITPushAuthorizationTool.h"

#import "FITBaseReminderTool.h"
@interface GPReminderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) FITPopCantainerTool *popcantainTool;

@property (nonatomic, strong) GPSetReminderController *setReminderController;

@property (nonatomic, strong) FITReminderData *reminderData;

@property (nonatomic, strong) FITSaveLocalPushModeManger *savePushManger;

@property (nonatomic, strong) NSIndexPath *deleteIndexPath;

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, assign) BOOL loaclNotificationState;

@property (nonatomic, strong) FITPushAuthorizationTool *pushAuthorTool;

@end

static NSString * const FITReminderCellID = @"FITReminderCellID";


@implementation GPReminderController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updatePushAuthorization];
    
    [self setupNav];
    [self setupUI];
    [self updateUI];
    [self loadData];


}


#pragma mark - Set Up

- (void)updatePushAuthorization{
    
    WS(ws);
    [self.pushAuthorTool acquirePushAuthorizationStatus:^{
        ws.loaclNotificationState = YES;
    } registerPushFailureBlock:^{
        ws.loaclNotificationState = NO;
    }];
}


- (void)setupNav{
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"setting_reminder_list_icon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(addAction)];
    self.navigationItem.title = @"闹钟";
    NSDictionary *attr = @{NSFontAttributeName: sfMedium(18), NSForegroundColorAttributeName: color(0x424242)};
    [self.navigationController.navigationBar setTitleTextAttributes:attr];
    
}

- (void)setupUI{
    

    WS(ws);
    FITNoReminderView *reminderView = [[FITNoReminderView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    reminderView.setReminderBlock = ^{
        [ws addAction];
    };

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.enablePlaceHolderView = YES;
    self.tableView.yh_PlaceHolderView = reminderView;
    self.tableView.rowHeight = 132;
    [self.tableView registerClass:[FITReminderCell class] forCellReuseIdentifier:FITReminderCellID];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =  [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    self.tableView.contentInset = UIEdgeInsetsMake(12, 0, 0, 0);


    if (IOS_VERSION_10_OR_Below) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}
- (void)loadData{
    
    self.reminderData = [[FITReminderData alloc]init];
    
    // 第一次开关状态
    if ( [FITRemindViewStatus getReminderShowStatus] == NO) {
        [FITRemindViewStatus updateRminderSwitchStatus:YES];

        [FITRemindViewStatus updateRminderShowStatus:YES];
    }
    
    [self.tableView reloadData];
    
}
- (void)updateUI{
    
    WS(ws);
    // Save 回调
    self.setReminderController.saveActionBlock = ^{
        [ws.popcantainTool disappear:nil];
        ws.tableView.scrollEnabled = YES;
        
        if (!ws.loaclNotificationState) {
            [ws showLocalAlertView];
        }
    };
    // cancel 回调
    self.setReminderController.cancelActionBlock = ^{
        [ws.popcantainTool disappear:nil];
        ws.tableView.scrollEnabled = YES;
    };
    
    // 删除闹钟的回调
    self.savePushManger.deleteNotificationSBlcok = ^(NSArray<UILocalNotification *> *localArray) {
        
        if ([FITRemindViewStatus getReminderSwitchStatus]) {
            [FITLocalPushManger deleteLocalNotificationS:localArray];
        }
        
        
        [ws.tableView deleteRowsAtIndexPaths:@[ws.deleteIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ws.tableView reloadData];
        });
        

        if (ws.reminderData.totalArray.count < 8) {
            ws.navigationItem.rightBarButtonItem.enabled = YES;
        }

    };
    
    // 添加闹钟的回调
    self.savePushManger.addNotificationSBlcok = ^(NSArray<UILocalNotification *> *localArray) {
        
        if (ws.reminderData.totalArray.count == 1) {
            [FITRemindViewStatus updateRminderSwitchStatus:YES];
        }
        
        if ([FITRemindViewStatus getReminderSwitchStatus] && ws.loaclNotificationState) {
            [FITLocalPushManger addLocalNotificationS:localArray];
        }
        

        [ws.tableView reloadData];
        if (ws.reminderData.totalArray.count == 8) {
            ws.navigationItem.rightBarButtonItem.enabled = NO;
        }
    };

    // 更新闹钟状态回调
    self.savePushManger.updateLocalNotificationStrikeTimeBlock = ^(NSArray<UILocalNotification *> *oldLocalArray, NSArray<UILocalNotification *> *localArray) {
        
        if ([FITRemindViewStatus getReminderSwitchStatus]) {
            [FITLocalPushManger updateLocalOldNotificationTime:oldLocalArray notificationArray:localArray];
        }
        
        [ws.tableView reloadData];
    };
    
    /**************************************过期方法***************************************************/
    // 更新闹钟开关的回调
    self.savePushManger.updateLocalNotificationSectionSwitchBlock = ^(NSArray<UILocalNotification *> *onLocalArray, BOOL switchState) {
        [FITLocalPushManger updateLocalNotificationSwitchState:onLocalArray switchState:switchState];
        [ws.tableView reloadData];
        
        NSInteger localState = [[NSUserDefaults standardUserDefaults] integerForKey:@"RegisterUserNotificationSettings"];

        if (localState == LocalNotificationFailState && switchState ) {
            [ws showLocalAlertView];
        }
    };
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.reminderData.totalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WS(ws);
    FITReminderCell *cell = [tableView dequeueReusableCellWithIdentifier:FITReminderCellID forIndexPath:indexPath];
    
    cell.reminderSubData = self.reminderData.totalArray[indexPath.row];
    
    
    cell.switchActionBlock = ^(BOOL switchState) {
        
        [ws.savePushManger updateLocalNotificationSwitchStateSection:indexPath.row switchState:switchState];

    };
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WS(ws);
    FITRemindSwitchView *view = [[FITRemindSwitchView alloc]init];
    view.switchStatus = [FITRemindViewStatus getReminderSwitchStatus];
    view.switchActionBlock = ^(BOOL switchState) {
        
        FITBaseReminderTool *baseTool = [FITBaseReminderTool baseReminderTool];
        baseTool.selectTraingSwitch = YES;
        
        if (!ws.loaclNotificationState) {
            [ws.tableView reloadData];
            [ws showLocalAlertView];
            return;
        }
        
        [FITRemindViewStatus updateRminderSwitchStatus:switchState];
        NSArray *tempArray = [ws.savePushManger getSaveTotalLocalNOtification];
        // 添加
        if (switchState) {
            [FITLocalPushManger addLocalNotificationS:tempArray];
        }else{
            // 删除
            [FITLocalPushManger deleteLocalNotificationS:tempArray];
        }
    };
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.reminderData.totalArray.count) {
        return 100;
    }else{
        return 0;
    }
}


- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:NSLocalizedString(@"Delete",nil)handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        self.deleteIndexPath = indexPath;

        [self.savePushManger deleteLocalNotificationS:indexPath.row];
        
    }];

    return @[deleteRowAction];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.setReminderController.reminderSubData = self.reminderData.totalArray[indexPath.row];
    self.setReminderController.setReminderType = setRemindUpdateType;
    self.setReminderController.savePushManger = self.savePushManger;
    [self.popcantainTool popup:nil];
    self.tableView.scrollEnabled = NO;
}


#pragma mark - Action
- (void)addAction{
    
    [self addsetReminder];
}

- (void)addsetReminder{
    self.setReminderController.setReminderType = setRemindAddType;
    self.setReminderController.savePushManger = self.savePushManger;
    [self.popcantainTool popup:nil];
    self.tableView.scrollEnabled = NO;
}

#pragma mark - Private
- (void)showLocalAlertView{
    
    RIButtonItem *openlItem = [RIButtonItem itemWithLabel:@"打开设置" action:^{
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }

    }];
    
    RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:@"取消" action:^{
        
    }];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"获取通知权限,才能发起推送"
                                               cancelButtonItem:cancelItem
                                               otherButtonItems:openlItem,nil];
    [alertView show];
}

#pragma mark - Lazy
- (GPSetReminderController *)setReminderController
{
    if (!_setReminderController) {
        _setReminderController = [[GPSetReminderController alloc]init];
        CGFloat Y =  kMainScreenHeight * 0.5;
        if (IOS_VERSION_10_OR_Below) {
            Y -= 64;
        }
        _setReminderController.view.frame = CGRectMake(0,Y, kMainScreenWidth, kMainScreenHeight * 0.5);
    }
    return _setReminderController;
}

- (FITPopCantainerTool *)popcantainTool
{
    if (!_popcantainTool) {
        _popcantainTool = [[FITPopCantainerTool alloc]initWithSuperController:self popController:self.setReminderController];
        _popcantainTool.hideNavigationBar = YES;
        _popcantainTool.blankExit = YES;
    }
    return _popcantainTool;
}

- (FITSaveLocalPushModeManger *)savePushManger
{
    if (!_savePushManger) {
        _savePushManger = [[FITSaveLocalPushModeManger alloc]init];
    }
    return _savePushManger;
}

- (FITPushAuthorizationTool *)pushAuthorTool
{
    if (!_pushAuthorTool) {
        _pushAuthorTool = [[FITPushAuthorizationTool alloc]init];
    }
    return _pushAuthorTool;
}

@end
