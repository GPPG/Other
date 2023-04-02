
//
//  FITPopCantainerTool.m
//  popView
//
//  Created by 郭鹏 on 2018/8/1.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import "FITPopCantainerTool.h"
#import "UIView+LayoutMethods.h"

@interface FITPopCantainerTool()

@property (nonatomic, strong) UIViewController *containerController;

@property (nonatomic, weak) UIViewController *superController;

@property (nonatomic, strong) UIViewController *popController;

@property (nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UIView *bgView;


@end

@implementation FITPopCantainerTool


#pragma mark - 初始化
- (instancetype)initWithSuperController:(UIViewController *)superController popController:(UIViewController *)popController{
    if (self = [super init]) {
        
        self.superController = superController;
        self.popController = popController;
    }
    return self;
}

- (void)addView{
    
    [self.containerController addChildViewController:self.popController];
    [self.containerController.view addSubview:self.popController.view];
    [self.superController addChildViewController:self.containerController];
    [self.superController.view addSubview:self.containerController.view];
    
    if (self.hideNavigationBar) {
        self.bgView.backgroundColor = [UIColor clearColor];
        [self.containerController.view insertSubview:self.bgView belowSubview:self.popController.view];
    }
}

#pragma mark - public
- (void)popup:(PopCompleteBlock)popCompleteBlock{
    
    self.containerController.view.backgroundColor = [UIColor clearColor];
    
    if (self.hideNavigationBar) {
        
        self.navView.backgroundColor = [UIColor clearColor];
        UIWindow *window = [[UIApplication sharedApplication].delegate window];

        [window addSubview: self.navView];
        
    }

    if (popCompleteBlock) {
        popCompleteBlock();
    }
    
    [self addView];
    
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    self.containerController.view.y = H;

 
    [UIView animateWithDuration:0.2 animations:^{
        self.containerController.view.y = 0;
    } completion:^(BOOL finished) {
        
        
        [UIView animateWithDuration:0.2 animations:^{
            
            if (self.hideNavigationBar) {
                self.navView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
                self.bgView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
            }

            if (!self.hideNavigationBar) {
                self.containerController.view.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
            }

        }];
    }];
}

- (void)disappear:(PopDismissBlock)popDismissBlock{
    
    
    if (popDismissBlock) {
        popDismissBlock();
    }
    
    [UIView animateWithDuration: 0.1 animations:^{
        
        if (!self.hideNavigationBar) {
            self.containerController.view.backgroundColor = [UIColor clearColor];
        }

        if (self.hideNavigationBar) {
            self.navView.backgroundColor = [UIColor clearColor];
            self.bgView.backgroundColor = [UIColor clearColor];
            [self.navView removeFromSuperview];
        }
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration: 0.2 animations:^{
            self.containerController.view.y = [UIScreen mainScreen].bounds.size.height;
        } completion:^(BOOL finished) {
            [self.containerController.view removeFromSuperview];
            [self.containerController removeFromParentViewController];
                    }];
        
    }];
}

- (void)dealloc{
    
    NSLog(@"pop dealloc: %s",__func__);
}


- (void)tapGestureAction{
    
    if (self.blankExit) {
        [self disappear:nil];
    }
}

#pragma mark - lazy
- (UIViewController *)containerController
{
    if (!_containerController) {
        _containerController = [[UIViewController alloc]init];

    }
    return _containerController;
}

- (UIView *)navView
{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - self.popController.view.height)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction)];
        [_navView addGestureRecognizer:tapGesture];
        //        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth,kIsiPhoneX ? 88 : 64)];
    }
    return _navView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:self.popController.view.frame];
    }
    return _bgView;
}

@end
