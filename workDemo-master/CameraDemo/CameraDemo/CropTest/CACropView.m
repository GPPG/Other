//
//  CACropView.m
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/23.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "CACropView.h"
#import "CACorpGridLayer.h"
#import "CACorpCornerView.h"
#import "CACorpRatio.h"
#import "UIColor+SWCustomMethod.h"
#import "UIView+HXExtension.h"
#import <Masonry.h>







@interface CACropView()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *tempImageView;
@property (assign, nonatomic) BOOL orientationDidChange;
@property (strong, nonatomic) CACorpGridLayer *gridLayer;

@property (strong, nonatomic) CACorpCornerView *leftTopView;
@property (strong, nonatomic) CACorpCornerView *rightTopView;
@property (strong, nonatomic) CACorpCornerView *leftBottomView;
@property (strong, nonatomic) CACorpCornerView *rightBottomView;

@property (assign, nonatomic) CGRect clippingRect;
@property (strong, nonatomic) CACorpRatio *clippingRatio;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) CGFloat imageWidth;
@property (assign, nonatomic) CGFloat imageHeight;
@property (strong, nonatomic) UIImage *originalImage;
@property (strong, nonatomic) UIPanGestureRecognizer *imagePanGesture;
@property (assign, nonatomic) BOOL isSelectRatio;

@property (nonatomic, strong) UIImage *tailoringImage;

@end



@implementation CACropView

#pragma mark - init

- (instancetype)initWith:(CACropConfigureManger *)manger tailoringImage:(UIImage *)tailoringImage{
    
    if (self = [super init]) {
        self.manger = manger;
        self.tailoringImage = tailoringImage;
        [self setup];

        NSLog(@"初始化");

    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"初始化--几次");

}

#pragma mark - set up
- (void)setup{

    [self setupUI];
    
    [self changeSubviewFrame:NO];
    
}

- (void)setupManger{
    
    self.originalImage = self.tailoringImage;
    self.imageWidth = self.tailoringImage.size.width;
    self.imageHeight = self.tailoringImage.size.height;
    
    
    CACorpRatio *ratio = [[CACorpRatio alloc] initWithValue1:self.manger.movableCropBoxCustomRatio.x value2:self.manger.movableCropBoxCustomRatio.y];
    if (self.manger.movableCropBoxCustomRatio.x > self.manger.movableCropBoxCustomRatio.y) {
        ratio.isLandscape = YES;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.alpha = 1;
        self.gridLayer.alpha = 1;
//        if (self.manger.movableCropBoxEditSize) {
            self.leftTopView.alpha = 1;
            self.leftBottomView.alpha = 1;
            self.rightTopView.alpha = 1;
            self.rightBottomView.alpha = 1;
//        }
    }];

}

- (void)setupUI{
    
    [self addSubview:self.bgImageView];
    //70%黑色的蒙层
    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor RGBColorWithR:0 G:0 B:0 alpha:0.7];
    [self addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.imageView];
    [self addSubview:self.leftTopView];
    [self addSubview:self.leftBottomView];
    [self addSubview:self.rightTopView];
    [self addSubview:self.rightBottomView];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    self.imageView.image = self.tailoringImage;
    
    [self setupManger];

}

#pragma mark - set

- (void)setClippingRatio:(CACorpRatio *)clippingRatio {
    if(clippingRatio != self.clippingRatio){
        _clippingRatio = clippingRatio;
        [self clippingRatioDidChange:YES];
    }
}

#pragma mark - public

- (UIImage *)editImage{
    
    return [self clipImage];
}

- (void)setWidth:(CGFloat)W height:(CGFloat)H{
    
    CACorpRatio *ratio = [[CACorpRatio alloc] initWithValue1:W value2:H];
    self.isSelectRatio = YES;

    if (ratio.ratio == 0) {
        [self bottomViewDidRestoreClick];
    }else{
        self.clippingRatio = ratio;
    }
    self.manger.movableCropBoxCustomRatio = CGPointMake(ratio.value1, ratio.value2);

}

- (UIImage *)getCurrentImage{
    
    return self.imageView.image;
}

- (CGRect)getImageFrame{
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat bottomMargin = hxBottomMargin;
    CGFloat leftRightMargin = 50;
    CGFloat imageY = HX_IS_IPhoneX_All ? 120 : 84;
    if (HX_IS_IPhoneX_All && (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)) {
        bottomMargin = 21;
        leftRightMargin = 80;
        imageY = 20;
    }
    CGFloat width = self.hx_w - leftRightMargin;
    CGFloat height = self.frame.size.height - imageY - 10;
    CGFloat imgWidth = self.imageWidth;
    CGFloat imgHeight = self.imageHeight;
    CGFloat w;
    CGFloat h;
    
    if (imgWidth > width) {
        imgHeight = width / imgWidth * imgHeight;
    }
    if (imgHeight > height) {
        w = height / self.imageHeight * imgWidth;
        h = height;
    }else {
        if (imgWidth > width) {
            w = width;
        }else {
            w = imgWidth;
        }
        h = imgHeight;
    }
    
    return CGRectMake((width - w) / 2 + leftRightMargin / 2, imageY + (height - h) / 2, w, h);
}





#pragma mark - private
- (void)bottomViewDidRestoreClick {
    self.clippingRatio = [[CACorpRatio alloc] initWithValue1:0 value2:0];

//    if (self.manger.movableCropBox) {
//        if (CGPointEqualToPoint(self.manger.movableCropBoxCustomRatio, CGPointZero)) {
//        }
//    }else {
//        if (CGSizeEqualToSize(self.clippingRect.size, self.originalImage.size)) {
////            [self stopTimer];
//            return;
//        }
//        if (!self.originalImage || self.imageView.image == self.originalImage) {
////            [self stopTimer];
//            return;
//        }
//    }
////    [self stopTimer];
    self.clippingRatio = nil;
    
    [UIView animateWithDuration:0.2 animations:^{
//        self.gridLayer.alpha = 0;
//        self.leftTopView.alpha = 0;
//        self.leftBottomView.alpha = 0;
//        self.rightTopView.alpha = 0;
//        self.rightBottomView.alpha = 0;
    } completion:^(BOOL finished) {
        self.imageView.image = self.originalImage;
        self.imageWidth = self.tailoringImage.size.width;
        self.imageHeight = self.tailoringImage.size.height;
        CGRect imageRect = [self getImageFrame];
        self.gridLayer.frame = CGRectMake(0, 0, imageRect.size.width, imageRect.size.height);
        
        [UIView animateWithDuration:0.3 animations:^{
            self.imageView.frame = imageRect;
        } completion:^(BOOL finished) {
            [self clippingRatioDidChange:YES];
        }];
    }];
}


- (void)changeSubviewFrame:(BOOL)animated {
    
    CGFloat bottomMargin = hxBottomMargin;
    if (HX_IS_IPhoneX_All) {
        bottomMargin = 21;
    }
    CGRect imageFrame = [self getImageFrame];
    if (animated) {
        self.gridLayer.frame = CGRectMake(0, 0, imageFrame.size.width, imageFrame.size.height);
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.frame = imageFrame;
        } completion:^(BOOL finished) {
            [self clippingRatioDidChange:animated];
        }];
    }else {
        self.imageView.frame = imageFrame;
        //        self.imageView.center = CGPointMake(self.view.hx_w / 2, imageY + height / 2);
        self.gridLayer.frame = self.imageView.bounds;
        [self clippingRatioDidChange:animated];
    }
}

- (void)clippingRatioDidChange:(BOOL)animated {
    CGRect rect = self.imageView.bounds;
    if (self.clippingRatio && self.clippingRatio.ratio != 0) {
        CGFloat H = rect.size.width * self.clippingRatio.ratio;
        if (H <= rect.size.height) {
            rect.size.height = H;
        } else {
            rect.size.width *= rect.size.height / H;
        }
        
        rect.origin.x = (self.imageView.bounds.size.width - rect.size.width) / 2;
        rect.origin.y = (self.imageView.bounds.size.height - rect.size.height) / 2;
    }
    [self setClippingRect:rect animated:animated];
}

- (void)setClippingRect:(CGRect)clippingRect {
    _clippingRect = clippingRect;
    
    self.leftTopView.center = [self convertPoint:CGPointMake(_clippingRect.origin.x, _clippingRect.origin.y) fromView:_imageView];
    self.leftBottomView.center = [self convertPoint:CGPointMake(_clippingRect.origin.x, _clippingRect.origin.y+_clippingRect.size.height) fromView:_imageView];
    self.rightTopView.center = [self convertPoint:CGPointMake(_clippingRect.origin.x+_clippingRect.size.width, _clippingRect.origin.y) fromView:_imageView];
    self.rightBottomView.center = [self convertPoint:CGPointMake(_clippingRect.origin.x+_clippingRect.size.width, _clippingRect.origin.y+_clippingRect.size.height) fromView:_imageView];
    
    self.gridLayer.clippingRect = clippingRect;
    [self.gridLayer setNeedsDisplay];
}

- (void)setClippingRect:(CGRect)clippingRect animated:(BOOL)animated {
    if (animated) {
        if (self.isSelectRatio) {
            [UIView animateWithDuration:0.1 animations:^{
                self.clippingRect = clippingRect;
            } completion:^(BOOL finished) {
                [self clippingRectComplete:clippingRect];
            }];
        }else {
            self.clippingRect = clippingRect;
            [self clippingRectComplete:clippingRect];
        }
    } else {
        self.clippingRect = clippingRect;
    }
}

- (void)clippingRectComplete:(CGRect)clippingRect {
    
    self.imageView.alpha = 1;
    
    if (self.isSelectRatio) {
        if (CGPointEqualToPoint(self.manger.movableCropBoxCustomRatio, CGPointMake(0, 0))) {
            _clippingRatio = nil;
        }
        if (!self.manger.movableCropBox) {
            [self changeClipImageView];
        }
        self.isSelectRatio = NO;
        return;
    }
    
    [self.tempImageView removeFromSuperview];
    self.tempImageView = nil;
    [UIView animateWithDuration:0.2 animations:^{
        self.leftTopView.alpha = 1;
        self.leftBottomView.alpha = 1;
        self.rightTopView.alpha = 1;
        self.rightBottomView.alpha = 1;
        self.gridLayer.alpha = 1;
    }];
}

- (void)changeClipImageView {
    if (CGSizeEqualToSize(self.clippingRect.size, self.imageView.hx_size)) {
//        [self stopTimer];
        return;
    }
    UIImage *image = [self clipImage];
    self.imageWidth = image.size.width;
    self.imageHeight = image.size.height;
    CGRect imageRect = [self getImageFrame];
    
    
    self.tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Lotus"]];
    CGFloat imgW = self.rightTopView.center.x - self.leftTopView.center.x;
    CGFloat imgH = self.leftBottomView.center.y - self.leftTopView.center.y;
    self.tempImageView.frame = CGRectMake(self.leftTopView.center.x, self.leftTopView.center.y, imgW, imgH);
    [self insertSubview:self.tempImageView aboveSubview:self.imageView];
    
    [UIView animateWithDuration:0.2f animations:^{
        self.leftTopView.alpha = 0;
        self.leftBottomView.alpha = 0;
        self.rightTopView.alpha = 0;
        self.rightBottomView.alpha = 0;
        self.imageView.alpha = 0.f;
        self.gridLayer.alpha = 0.f;
    } completion:^(BOOL finished) {
        self.gridLayer.frame = CGRectMake(0, 0, imageRect.size.width, imageRect.size.height);
        
        [UIView animateWithDuration:0.3f animations:^{
            self.tempImageView.frame = imageRect;
        } completion:^(BOOL finished) {
            self.imageView.image = image;
            self.imageView.frame = imageRect;
            [self clippingRatioDidChange:YES];
        }];
    }];
//    [self stopTimer];
}
- (UIImage *)clipImage {
    CGFloat zoomScale = self.imageView.bounds.size.width / self.imageView.image.size.width;
    CGFloat widthScale = self.imageView.image.size.width / self.imageView.hx_w;
    CGFloat heightScale = self.imageView.image.size.height / self.imageView.hx_h;
    
    CGRect rct = self.clippingRect;
    rct.size.width  *= widthScale;
    rct.size.height *= heightScale;
    rct.origin.x    /= zoomScale;
    rct.origin.y    /= zoomScale;
    
    CGPoint origin = CGPointMake(-rct.origin.x, -rct.origin.y);
    UIImage *img = nil;
    
    UIGraphicsBeginImageContextWithOptions(rct.size, NO, self.imageView.image.scale);
    [self.imageView.image drawAtPoint:origin];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - action
- (void)panGridView:(UIPanGestureRecognizer*)sender {
    static BOOL dragging = NO;
    static CGRect initialRect;
    
    if (sender.state==UIGestureRecognizerStateBegan) {
        CGPoint point = [sender locationInView:self.imageView];
        dragging = CGRectContainsPoint(self.clippingRect, point);
        initialRect = self.clippingRect;
    } else if(dragging) {
        CGPoint point = [sender translationInView:self.imageView];
        CGFloat left  = MIN(MAX(initialRect.origin.x + point.x, 0), self.imageView.frame.size.width-initialRect.size.width);
        CGFloat top   = MIN(MAX(initialRect.origin.y + point.y, 0), self.imageView.frame.size.height-initialRect.size.height);
        
        CGRect rct = self.clippingRect;
        rct.origin.x = left;
        rct.origin.y = top;
        self.clippingRect = rct;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
//        [self startTimer];
    }else {
//        [self stopTimer];
    }
}
- (void)panCircleView:(UIPanGestureRecognizer*)sender {
    CGPoint point = [sender locationInView:self.imageView];
    CGPoint dp = [sender translationInView:self.imageView];
    
    CGRect rct = self.clippingRect;
    if (self.imageView.hx_w <= 200 &&
        self.imageView.hx_h <= 200) {
        return;
    }
    
    const CGFloat W = self.imageView.frame.size.width;
    const CGFloat H = self.imageView.frame.size.height;
    CGFloat minX = 0;
    CGFloat minY = 0;
    CGFloat maxX = W;
    CGFloat maxY = H;
    
    CGFloat ratio = (sender.view.tag == 1 || sender.view.tag==2) ? -self.clippingRatio.ratio : self.clippingRatio.ratio;
    
    switch (sender.view.tag) {
        case 0: // upper left
        {
            maxX = MAX((rct.origin.x + rct.size.width)  - 0.1 * W, 0.1 * W);
            maxY = MAX((rct.origin.y + rct.size.height) - 0.1 * H, 0.1 * H);
            
            if (ratio!=0) {
                CGFloat y0 = rct.origin.y - ratio * rct.origin.x;
                CGFloat x0 = -y0 / ratio;
                minX = MAX(x0, 0);
                minY = MAX(y0, 0);
                
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
                
                if(-dp.x * ratio + dp.y > 0){
                    point.x = (point.y - y0) / ratio;
                } else{
                    point.y = point.x * ratio + y0;
                }
            } else {
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
            }
            
            rct.size.width  = rct.size.width  - (point.x - rct.origin.x);
            rct.size.height = rct.size.height - (point.y - rct.origin.y);
            rct.origin.x = point.x;
            rct.origin.y = point.y;
            break;
        }
        case 1: // lower left
        {
            maxX = MAX((rct.origin.x + rct.size.width)  - 0.1 * W, 0.1 * W);
            minY = MAX(rct.origin.y + 0.1 * H, 0.1 * H);
            
            if (ratio!=0) {
                CGFloat y0 = (rct.origin.y + rct.size.height) - ratio* rct.origin.x ;
                CGFloat xh = (H - y0) / ratio;
                minX = MAX(xh, 0);
                maxY = MIN(y0, H);
                
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
                
                if(-dp.x*ratio + dp.y < 0){ point.x = (point.y - y0) / ratio; }
                else{ point.y = point.x * ratio + y0; }
            } else {
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
            }
            
            rct.size.width  = rct.size.width  - (point.x - rct.origin.x);
            rct.size.height = point.y - rct.origin.y;
            rct.origin.x = point.x;
            break;
        }
        case 2: // upper right
        {
            minX = MAX(rct.origin.x + 0.1 * W, 0.1 * W);
            maxY = MAX((rct.origin.y + rct.size.height) - 0.1 * H, 0.1 * H);
            
            if (ratio!=0) {
                CGFloat y0 = rct.origin.y - ratio * (rct.origin.x + rct.size.width);
                CGFloat yw = ratio * W + y0;
                CGFloat x0 = -y0 / ratio;
                maxX = MIN(x0, W);
                minY = MAX(yw, 0);
                
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
                
                if(-dp.x*ratio + dp.y > 0){ point.x = (point.y - y0) / ratio; }
                else{ point.y = point.x * ratio + y0; }
            } else {
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
            }
            
            rct.size.width  = point.x - rct.origin.x;
            rct.size.height = rct.size.height - (point.y - rct.origin.y);
            rct.origin.y = point.y;
            break;
        }
        case 3: // lower right
        {
            minX = MAX(rct.origin.x + 0.1 * W, 0.1 * W);
            minY = MAX(rct.origin.y + 0.1 * H, 0.1 * H);
            
            if (ratio!=0) {
                CGFloat y0 = (rct.origin.y + rct.size.height) - ratio * (rct.origin.x + rct.size.width);
                CGFloat yw = ratio * W + y0;
                CGFloat xh = (H - y0) / ratio;
                maxX = MIN(xh, W);
                maxY = MIN(yw, H);
                
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
                
                if(-dp.x*ratio + dp.y < 0){ point.x = (point.y - y0) / ratio; }
                else{ point.y = point.x * ratio + y0; }
            } else {
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
            }
            
            rct.size.width  = point.x - rct.origin.x;
            rct.size.height = point.y - rct.origin.y;
            break;
        }
        default:
            break;
    }
    self.clippingRect = rct;
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
//        [self startTimer];
    }else {
//        [self stopTimer];
    }
}

#pragma mark - lazy

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.alpha = 0;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [_imageView addSubview:self.gridLayer];
        self.imagePanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGridView:)];
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:self.imagePanGesture];
    }
    return _imageView;
}

- (CACorpGridLayer *)gridLayer {
    if (!_gridLayer) {
        _gridLayer = [[CACorpGridLayer alloc] init];
        _gridLayer.bgColor   = [[UIColor blackColor] colorWithAlphaComponent:.5];
        _gridLayer.gridColor = [UIColor RGBColorWithR:149 G:109 B:255 alpha:1.0];
        _gridLayer.alpha = 0.f;
    }
    return _gridLayer;
}

- (CACorpCornerView *)leftTopView {
    if (!_leftTopView) {
        _leftTopView = [self editCornerViewWithTag:0];
    }
    return _leftTopView;
}
- (CACorpCornerView *)leftBottomView {
    if (!_leftBottomView) {
        _leftBottomView = [self editCornerViewWithTag:1];
    }
    return _leftBottomView;
}
- (CACorpCornerView *)rightTopView {
    if (!_rightTopView) {
        _rightTopView = [self editCornerViewWithTag:2];
    }
    return _rightTopView;
}
- (CACorpCornerView *)rightBottomView {
    if (!_rightBottomView) {
        _rightBottomView = [self editCornerViewWithTag:3];
    }
    return _rightBottomView;
}

- (CACorpCornerView *)editCornerViewWithTag:(NSInteger)tag {
    CACorpCornerView *view = [[CACorpCornerView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view.backgroundColor = [UIColor clearColor];
    view.bgColor = [UIColor whiteColor];
    view.tag = tag;
    view.alpha = 0;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCircleView:)];
    [view addGestureRecognizer:panGesture];
    [panGesture requireGestureRecognizerToFail:self.imagePanGesture];
    return view;
}




@end
