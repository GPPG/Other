//
//  CAShowViewController.m
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/23.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "CAShowViewController.h"

@interface CAShowViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CAShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)setImage:(UIImage *)image{
    
    _image = image;

    
    self.imageView = [[UIImageView alloc]initWithImage:image];
    self.imageView.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:self.imageView];

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
