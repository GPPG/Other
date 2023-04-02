
//
//  GPPackingListViewController.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/4/6.
//  Copyright © 2017年 郭鹏. All rights reserved.
//
#import "GPPackingListViewController.h"
#import "GPHorizontalItemListView.h"

@interface GPPackingListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addbtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *rootTableView;
@property (nonatomic, strong) GPHorizontalItemListView *horizonListView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *cellTitleArray;
@property (nonatomic, assign,getter=isMenuOpen) BOOL menuOpen;
// 约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleCenterY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewH;
@end

@implementation GPPackingListViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
#pragma mark - 初始化
- (void)setNav
{
    self.rootTableView.rowHeight = SCREEN_HEIGHT * 0.13;
}
#pragma mark - 内部方法
- (IBAction)addbtnClick:(id)sender {
 
    self.menuOpen = !self.menuOpen;
    // 更新标题动画
    self.titleCenterX.constant = self.isMenuOpen ? -100.0 : 0.0;
    self.titleCenterY.constant = self.isMenuOpen ? -25 : 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    // 更新标题视图动画
    self.topViewH.constant = self.isMenuOpen ? 200.0 : 60.0;
    self.titleLabel.text = self.isMenuOpen ? @"选择物品" : @"购物列表";

    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGFloat angle = self.isMenuOpen ? M_PI * 0.25 : 0.0;
        self.addBtn.transform = CGAffineTransformMakeRotation(angle);
        [self.view layoutIfNeeded];
    } completion:nil];
    
    // 添加选择栏
    if (self.isMenuOpen) {
        GPWeakSelf(self);
        [self.view addSubview:({
            GPHorizontalItemListView *listView = [[GPHorizontalItemListView alloc]initWithView:self.view];
            listView.didSelectItemBlock = ^(NSInteger index) {
                NSString *tempStr = [NSString stringWithFormat:@"%ld",index];
                [weakself.cellTitleArray addObject:tempStr];
                [weakself.rootTableView reloadData];
                [weakself addbtnClick:self.addBtn];
            };
            self.horizonListView = listView;
        })];
    }else{
        [self.horizonListView removeFromSuperview];
    }
}

#pragma mark - 动画相关
- (void)showItem:(NSString *)indexStr
{
    NSString *tempStr = [NSString stringWithFormat:@"summericons_100px_0%@",indexStr];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:tempStr]];
    [self.view addSubview:({
        imageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        imageView.layer.cornerRadius = 5.0;
        imageView.layer.masksToBounds = YES;
        imageView;
    })];
    
    imageView.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.view, -150).widthRatioToView(self.view, 0.3).heightEqualToWidth();
    [imageView updateLayout];

    [UIView animateWithDuration:0.8 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        imageView.sd_layout.bottomSpaceToView(self.view, 50).widthRatioToView(self.view, 0.4);
        [imageView updateLayout];
    } completion:nil];
    
    [UIView animateWithDuration:0.8 delay:1.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        imageView.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.view, -150).widthRatioToView(self.view, 0.3).heightEqualToWidth();
        [imageView updateLayout];
    } completion:nil];
}
#pragma mark - 表格数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellTitleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.titleArray[[self.cellTitleArray[indexPath.row] integerValue]];
    NSString *tempStr = [NSString stringWithFormat:@"summericons_100px_0%@",self.cellTitleArray[indexPath.row]];
    cell.imageView.image = [UIImage imageNamed:tempStr];
    return cell;
}
#pragma mark - 表格代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showItem:self.cellTitleArray[indexPath.row]];
}
#pragma mark - 懒加载
- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"冰淇淋",@"晴天",@"沙滩排球",@"男士泳衣",@"女士泳衣",@"沙滩游戏",@"冲浪板",@"鸡尾酒",@"太阳镜",@"人字拖"];
    }
    return _titleArray;
}
- (NSMutableArray *)cellTitleArray
{
    if (!_cellTitleArray) {
        _cellTitleArray = [NSMutableArray arrayWithObjects:@"5",@"6",@"7",nil];
    }
    return _cellTitleArray;
}

@end
