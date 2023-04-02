//
//  CATailoringImageView.m
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/22.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "CATailoringImageView.h"
#import "JPImageresizer.h"


@interface CATailoringImageView()

@property (nonatomic, strong) UIImage *originalImage;

@property (nonatomic, strong) JPImageresizerConfigure *imageConfigure;

@property (nonatomic, strong) JPImageresizerView *imageresizerView;

@end

@implementation CATailoringImageView

#pragma mark - init
- (instancetype)initWithOriginalImage:(UIImage *)originalImage{
    
    if (self = [super init]) {
        
        self.originalImage = originalImage;
        
        
        [self setupImageresizerConfigure];
        
        [self addView];
    }
    return self;
}

#pragma mark - set up


- (void)setupImageresizerConfigure{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(50, 0, (40 + 30 + 30 + 10), 0);

    self.imageConfigure = [JPImageresizerConfigure blurMaskTypeConfigureWithResizeImage:self.originalImage isLight:NO make:^(JPImageresizerConfigure *configure) {
        configure.jp_contentInsets(contentInsets).jp_strokeColor([UIColor whiteColor]).        jp_frameType(JPClassicFrameType);
    }];
}

- (void)addView{
    self.backgroundColor = self.imageConfigure.bgColor;

    
    __weak typeof(self) wSelf = self;
    JPImageresizerView *imageresizerView = [JPImageresizerView imageresizerViewWithConfigure:self.imageConfigure imageresizerIsCanRecovery:^(BOOL isCanRecovery) {
        __strong typeof(wSelf) sSelf = wSelf;
        if (!sSelf) return;
        // 当不需要重置设置按钮不可点

    } imageresizerIsPrepareToScale:^(BOOL isPrepareToScale) {
        __strong typeof(wSelf) sSelf = wSelf;
        if (!sSelf) return;

    }];

    self.imageresizerView = imageresizerView;
    
    [self addSubview:imageresizerView];
}

#pragma mark - public
- (void)resizeWHScale:(CGFloat)scale{
    self.imageresizerView.resizeWHScale = scale;
}

@end
