//
//  ViewController.m
//  GAStatisticSDKTest
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "ViewController.h"
#import <GAStatisticSDK/StatisticSDK.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
//    [GAStatisticsUploadManger.operateCode(@"111") upload104];
    [GAStatisticsUploadManger.operateCode(@"21").tab(@"sd").operateResult(@"8786").enter(@"3") upload59];
    [GAStatisticsUploadManger.operateCode(@"21").tab(@"sd") upload101];

    // Do any additional setup after loading the view, typically from a nib.
}


@end
