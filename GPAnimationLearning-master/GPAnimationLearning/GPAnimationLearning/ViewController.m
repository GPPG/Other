//
//  ViewController.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/3/30.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "ViewController.h"
#import "GPViewAnimationViewController.h"
#import "GPAirLoginViewController.h"
#import "GPPackingListViewController.h"
#import "GPLayerAnimationViewController.h"
#import "GPTwoLayerAnimationViewController.h"
#import "GPThreeLayerAnimationViewController.h"
#import "GPShapeViewController.h"
#import "GPGrabienAnimationViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *rootTableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *subVcArray;
@property (nonatomic, strong) NSArray *subVcIDArray;
@end

@implementation ViewController
static NSString * const oneCellID = @"oneCellID";
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self addView];
    [self regisCell];
}
#pragma mark - 初始化方法
- (void)setNav
{    
    self.navigationItem.title = @"iOS_Animations_by_Tutorials";
}
- (void)addView
{
    [self.view addSubview:({
        self.rootTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.rootTableView.backgroundColor = GPBGColor;
        self.rootTableView.delegate = self;
        self.rootTableView.dataSource = self;
        self.rootTableView.rowHeight = SCREEN_HEIGHT * 0.12;
        self.rootTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        self.rootTableView;
    })];
}
- (void)regisCell
{
    [self.rootTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:oneCellID];
}
#pragma mark - 表格数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:oneCellID];
    oneCell.backgroundColor = GPBGColor;
    oneCell.textLabel.text = self.titleArray[indexPath.row];
    return oneCell;
}
#pragma mark - 表格代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *tempVc = SBVC(self.subVcArray[indexPath.row]);
    tempVc.navTitle = self.titleArray[indexPath.row];
    [self.navigationController pushViewController:tempVc animated:YES];
}
#pragma mark - 懒加载
- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"01-View&Spring&Transitions",@"02-View&KeyFrame",@"03-auto-layout",@"04-Layer-CABasic-CAKeyframe",@"05-Layer-Group",@"06-Layer-Spring",@"07-Shapes&Masks",@"08-GPGrabienAnimation"];
    }
    return _titleArray;
}
#pragma mark - 懒加载
- (NSArray *)subVcArray
{
    if (!_subVcArray) {
        _subVcArray = @[[GPViewAnimationViewController class],[GPAirLoginViewController class],[GPPackingListViewController class],[GPLayerAnimationViewController class],[GPTwoLayerAnimationViewController class],[GPThreeLayerAnimationViewController class],[GPShapeViewController class],[GPGrabienAnimationViewController class]];
    }
    return _subVcArray;
}
- (NSArray *)subVcIDArray
{
    if (!_subVcIDArray) {
        _subVcIDArray = @[[GPViewAnimationViewController class]];
    }
    return _subVcIDArray;
}
@end
