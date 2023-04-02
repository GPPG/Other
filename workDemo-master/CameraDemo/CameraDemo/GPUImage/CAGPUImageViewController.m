//
//  CAGPUImageViewController.m
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/27.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "CAGPUImageViewController.h"
#import <GPUImage.h>


typedef NS_ENUM(NSInteger,FilterType){
    exposureType = 0,
    contrastType = 1,
    saturationType = 2,
    sharpenType = 3,
    toneType = 4,
    highlightsType = 5,
    shadowsType = 6,
};


@interface CAGPUImageViewController ()
- (IBAction)sliderAction:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)exposureAction:(id)sender;
- (IBAction)contrastAction:(id)sender;
- (IBAction)saturationAction:(id)sender;
- (IBAction)sharpenAction:(id)sender;
- (IBAction)toneAction:(id)sender;
- (IBAction)highlightsAction:(id)sender;
- (IBAction)shadowsAction:(id)sender;

@property (nonatomic, assign) FilterType filterType;

@property (nonatomic, strong) GPUImagePicture *pic;

//亮度滤镜
@property (nonatomic, weak) GPUImageBrightnessFilter *brightnessFilter;

// 对比度滤镜
@property (nonatomic, strong) GPUImageContrastFilter *contrastFilter;

// 饱和度滤镜
@property (nonatomic, strong) GPUImageSaturationFilter *saturationFilter;

// 曝光度滤镜
@property (nonatomic, strong) GPUImageExposureFilter *exposureFilter;

// 锐度滤镜
@property (nonatomic, strong) GPUImageSharpenFilter *sharpenFilter;

//色调滤镜
@property (nonatomic, strong) GPUImageWhiteBalanceFilter *whiteBalanceFilter;




@end

@implementation CAGPUImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}


// 曝光度
- (IBAction)exposureAction:(id)sender {
    
    self.slider.minimumValue = -10.0;
    self.slider.maximumValue = 10.0;
    self.slider.value = 0;
    
    self.filterType = exposureType;
    
    
    UIImage *image = [UIImage imageNamed:@"Lotus"];
    
    self.exposureFilter = [[GPUImageExposureFilter alloc]init];
    [self.exposureFilter forceProcessingAtSize:image.size];
    
    [self.exposureFilter useNextFrameForImageCapture];
    
    
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image smoothlyScaleOutput:YES];
    _pic = pic;
    
    //   创建最终预览的view
    GPUImageView *gpuView = [[GPUImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view insertSubview:gpuView atIndex:0];
    //    设置GPUImage响应链，从数据源 => 滤镜 => 最终界面效果
    [pic addTarget:self.exposureFilter]; //   ① 添加上滤镜
    [self.exposureFilter addTarget:gpuView]; // ② 添加效果界面
    
    self.exposureFilter.exposure = self.slider.value;
    
    [pic processImage];


    
    
    
}
// 对比度
- (IBAction)contrastAction:(id)sender {
    self.slider.minimumValue = 0.0;
    self.slider.maximumValue = 4.0;
    self.slider.value = 1;
    
    self.filterType = contrastType;

    
    UIImage *image = [UIImage imageNamed:@"Lotus"];

    self.contrastFilter = [[GPUImageContrastFilter alloc]init];
    [self.contrastFilter forceProcessingAtSize:image.size];
    
    [self.contrastFilter useNextFrameForImageCapture];


    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image smoothlyScaleOutput:YES];
    _pic = pic;
    
    //   创建最终预览的view
    GPUImageView *gpuView = [[GPUImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view insertSubview:gpuView atIndex:0];
    //    设置GPUImage响应链，从数据源 => 滤镜 => 最终界面效果
    [pic addTarget:self.contrastFilter]; //   ① 添加上滤镜
    [self.contrastFilter addTarget:gpuView]; // ② 添加效果界面
    
    self.contrastFilter.contrast = self.slider.value;

    [pic processImage];

    
}
// 饱和度
- (IBAction)saturationAction:(id)sender {
    
    self.slider.minimumValue = 0.0;
    self.slider.maximumValue = 2.0;
    self.slider.value = 1;
    
    self.filterType = saturationType;
    
    
    UIImage *image = [UIImage imageNamed:@"Lotus"];
    
    self.saturationFilter = [[GPUImageSaturationFilter alloc]init];
    [self.saturationFilter forceProcessingAtSize:image.size];
    
    [self.saturationFilter useNextFrameForImageCapture];
    
    
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image smoothlyScaleOutput:YES];
    _pic = pic;
    
    //   创建最终预览的view
    GPUImageView *gpuView = [[GPUImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view insertSubview:gpuView atIndex:0];
    //    设置GPUImage响应链，从数据源 => 滤镜 => 最终界面效果
    [pic addTarget:self.saturationFilter]; //   ① 添加上滤镜
    [self.saturationFilter addTarget:gpuView]; // ② 添加效果界面
    
    self.saturationFilter.saturation = self.slider.value;
    
    [pic processImage];
    
    
}
// 锐化
- (IBAction)sharpenAction:(id)sender {
    
    
    self.slider.minimumValue = -4.0;
    self.slider.maximumValue = 4.0;
    self.slider.value = 0;
    
    self.filterType = sharpenType;
    
    UIImage *image = [UIImage imageNamed:@"Lotus"];
    
    self.sharpenFilter = [[GPUImageSharpenFilter alloc]init];
    [self.sharpenFilter forceProcessingAtSize:image.size];
    
    [self.sharpenFilter useNextFrameForImageCapture];
    
    
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image smoothlyScaleOutput:YES];
    _pic = pic;
    
    //   创建最终预览的view
    GPUImageView *gpuView = [[GPUImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view insertSubview:gpuView atIndex:0];
    //    设置GPUImage响应链，从数据源 => 滤镜 => 最终界面效果
    [pic addTarget:self.sharpenFilter]; //   ① 添加上滤镜
    [self.sharpenFilter addTarget:gpuView]; // ② 添加效果界面
    
    self.sharpenFilter.sharpness = self.slider.value;
    
    [pic processImage];


    
}
// 色调
- (IBAction)toneAction:(id)sender {
    
    
    self.whiteBalanceFilter = [[GPUImageWhiteBalanceFilter alloc]init];
    
    
    
}
// 亮度
- (IBAction)highlightsAction:(id)sender {
    
    self.filterType = highlightsType;
    
    self.slider.minimumValue = 0.0;
    self.slider.maximumValue = 1.0;
    self.slider.value = 0;
    
    
    UIImage *image = [UIImage imageNamed:@"Lotus"];

    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    _brightnessFilter = brightnessFilter;
    
    //    设置亮度调整范围为整张图像
    [brightnessFilter forceProcessingAtSize:image.size];
    [brightnessFilter useNextFrameForImageCapture];
    
    //    获取数据源
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image smoothlyScaleOutput:YES];
    _pic = pic;

    //   创建最终预览的view
    GPUImageView *gpuView = [[GPUImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view insertSubview:gpuView atIndex:0];
    //    设置GPUImage响应链，从数据源 => 滤镜 => 最终界面效果
    [pic addTarget:brightnessFilter]; //   ① 添加上滤镜
    [brightnessFilter addTarget:gpuView]; // ② 添加效果界面

    brightnessFilter.brightness = self.slider.value;
    //    数据源处理图像，开始渲染
    [pic processImage];
    
}



// 阴影
- (IBAction)shadowsAction:(id)sender {
 
    
    
}





- (IBAction)sliderAction:(UISlider *)sender {
    
    switch (self.filterType) {
        case highlightsType:
            
            _brightnessFilter.brightness = sender.value;
            //    数据源，给我重新处理下图片
            [_pic processImage];
            
            break;
        case contrastType:
            
            self.contrastFilter.contrast = sender.value;
            [_pic processImage];

            break;
        case saturationType:
            
            self.saturationFilter.saturation = sender.value;
            [_pic processImage];
            
            break;
        case exposureType:
            
            self.exposureFilter.exposure = sender.value;
            [_pic processImage];
            
            break;
        case sharpenType:
            
            self.sharpenFilter.sharpness = sender.value;
            [_pic processImage];
            
            break;

            
        default:
            break;
    }
    
    }


@end
