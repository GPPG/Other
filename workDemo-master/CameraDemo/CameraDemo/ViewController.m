//
//  ViewController.m
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/22.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "ViewController.h"
#import "CATailoringImageView.h"
#import "CACropView.h"
#import "CAShowViewController.h"
#import "CATailorView.h"



@interface ViewController ()

@property (nonatomic, strong) CACropView *cropView;
@property (nonatomic, strong) CATailorView *tailorView;
- (IBAction)verAction:(id)sender;

- (IBAction)freeAction:(id)sender;
- (IBAction)oneAction:(id)sender;
- (IBAction)threeAction:(id)sender;
- (IBAction)fourAction:(id)sender;
- (IBAction)sixteenAction:(id)sender;
- (IBAction)nineAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *rotaAction;
- (IBAction)rotaAction:(id)sender;

- (IBAction)save:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // exposure 曝光
    // contrast 对比
    // saturation 饱和度
    // sharpen  锐化
    // tone 色调
    // highlights 高光
    // shadows 阴影

    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 150);
    
    self.tailorView = [[CATailorView alloc]initWithFrame:rect];
    self.tailorView.originalImage = [UIImage imageNamed:@"Lotus"];
    [self.view addSubview:self.tailorView];
}




// free
- (IBAction)verAction:(id)sender {
    
    [self.tailorView verticalFlipAction];
}

- (IBAction)freeAction:(id)sender {
    
    [self.tailorView resizeWHScale:0.0 height:0.0];
}

// 1:1
- (IBAction)oneAction:(id)sender {
    [self.tailorView resizeWHScale:1.0 height:1.0];
    
}

// 3:2
- (IBAction)threeAction:(id)sender {
    [self.tailorView resizeWHScale:3.0 height:2.0];
}

// 4:3
- (IBAction)fourAction:(id)sender {
    [self.tailorView resizeWHScale:4.0 height:3.0];
}

// 16:9
- (IBAction)sixteenAction:(id)sender {

    [self.tailorView resizeWHScale:16.0 height:9.0];
}
// 9:16
- (IBAction)nineAction:(id)sender {

    [self.tailorView resizeWHScale:9.0 height:16.0];

}

- (IBAction)rotaAction:(id)sender {
    
    [self.tailorView rotateClick];
}

- (IBAction)save:(id)sender {
    
    CAShowViewController *showVC = [[CAShowViewController alloc]init];
    
    showVC.image = [self.tailorView getTailorImage];
    
    [self presentViewController:showVC animated:YES completion:nil];
    
}




@end
