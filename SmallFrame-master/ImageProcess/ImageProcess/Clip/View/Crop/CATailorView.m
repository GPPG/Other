
//
//  CATailorView.m
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/24.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "CATailorView.h"
#import "CATailorGridLayer.h"
#import "CATailorCornerView.h"
#import "UIColor+SWCustomMethod.h"
#import "UIView+HXExtension.h"
#import "CATailorLineView.h"
#import "UIImage+CARotate.h"

@interface CATailorView()<CAAnimationDelegate>

@property (strong, nonatomic) UIImageView *imageView;

@property (nonatomic, strong) UIView *maskView;

@property (strong, nonatomic) CATailorGridLayer *gridLayer;

@property (strong, nonatomic) CATailorCornerView *leftTopView;
@property (strong, nonatomic) CATailorCornerView *rightTopView;
@property (strong, nonatomic) CATailorCornerView *leftBottomView;
@property (strong, nonatomic) CATailorCornerView *rightBottomView;


@property (assign, nonatomic) CGRect clippingRect;

@property (nonatomic, strong) CAShapeLayer *tempLayer;
@property (nonatomic, strong) CATailorLineView *lineView;

@property (strong, nonatomic) UIPanGestureRecognizer *imagePanGesture;
@property (assign, nonatomic) BOOL isSelectRatio;

@property (nonatomic, assign) CGFloat ratio;

@end



@implementation CATailorView


- (instancetype) initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
     
        [self setup];
        
        [self addView];
        
        [self layout];
    }
    return self;
}


#pragma mark - set up
- (void)setup{
    self.ratio = 0.0;
    self.backgroundColor = [UIColor blackColor];

}

- (void)addView{
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.maskView];
    [self addSubview:self.imageView];
    [self addSubview:self.leftTopView];
    [self addSubview:self.leftBottomView];
    [self addSubview:self.rightTopView];
    [self addSubview:self.rightBottomView];
    self.gridLayer.layer.mask = self.tempLayer;
    [self.imageView addSubview:self.lineView];
    
}

#pragma mark - layout

- (void)layout{
    
    self.bgImageView.frame = self.bounds;
    self.maskView.frame = self.bounds;
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
            self.lineView.frame = self.gridLayer.bounds;
        } completion:^(BOOL finished) {
            [self clippingRatioDidChange:animated];
        }];
    }else {
        self.imageView.frame = imageFrame;
        self.gridLayer.frame = self.imageView.bounds;
        self.lineView.frame = self.gridLayer.bounds;
        [self clippingRatioDidChange:animated];
    }
}

#pragma mark - private
// 切换裁剪比例
- (void)switchClippingScale{
    
    if (self.ratio == 0) {
        [self clippingRatioDidChange:YES];
//        [self didRestoreClick];
        
    }else{
        [self clippingRatioDidChange:YES];
    }
}
- (void)didRestoreClick {
    
    self.imageView.image = self.originalImage;
    CGRect imageRect = [self getImageFrame];
    self.gridLayer.frame = CGRectMake(0, 0, imageRect.size.width, imageRect.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.frame = imageRect;
    } completion:^(BOOL finished) {
        [self clippingRatioDidChange:YES];
    }];
}

// 计算裁剪范围
- (void)clippingRatioDidChange:(BOOL)animated {
    CGRect rect = self.imageView.bounds;
    if (self.ratio && self.ratio != 0) {
        CGFloat H = rect.size.width * self.ratio;
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
// 是否需要过渡动画
- (void)setClippingRect:(CGRect)clippingRect animated:(BOOL)animated {
    self.clippingRect = clippingRect;
}

// 开始绘制裁剪范围
- (void)startClipping{
    
    if (self.isSelectRatio) {
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.gridLayer.bounds];
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.clippingRect];
        [rectPath appendPath:path];
        
        pathAnimation.toValue = (id)rectPath.CGPath;
        pathAnimation.duration = 0.25;
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.delegate = self;
        [self.tempLayer addAnimation:pathAnimation forKey:nil];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.lineView.frame = self.clippingRect;
            
            self.leftTopView.center = [self convertPoint:CGPointMake(self.clippingRect.origin.x, self.clippingRect.origin.y) fromView:self.imageView];
            
            self.leftBottomView.center = [self convertPoint:CGPointMake(self.clippingRect.origin.x, self.clippingRect.origin.y+self.clippingRect.size.height) fromView:self.imageView];
            self.rightTopView.center = [self convertPoint:CGPointMake(self.clippingRect.origin.x+self.clippingRect.size.width, self.clippingRect.origin.y) fromView:self.imageView];
            self.rightBottomView.center = [self convertPoint:CGPointMake(self.clippingRect.origin.x+self.clippingRect.size.width, self.clippingRect.origin.y+self.clippingRect.size.height) fromView:self.imageView];
        }completion:^(BOOL finished) {
            self.isSelectRatio = NO;
        }];
        
    }else{
        
        self.leftTopView.center = [self convertPoint:CGPointMake(self.clippingRect.origin.x, self.clippingRect.origin.y) fromView:self.imageView];
        self.leftBottomView.center = [self convertPoint:CGPointMake(self.clippingRect.origin.x, self.clippingRect.origin.y+self.clippingRect.size.height) fromView:self.imageView];
        self.rightTopView.center = [self convertPoint:CGPointMake(self.clippingRect.origin.x+self.clippingRect.size.width, self.clippingRect.origin.y) fromView:self.imageView];
        self.rightBottomView.center = [self convertPoint:CGPointMake(self.clippingRect.origin.x+self.clippingRect.size.width, self.clippingRect.origin.y+self.clippingRect.size.height) fromView:self.imageView];

        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.gridLayer.bounds];
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.clippingRect];
        [rectPath appendPath:path];
        self.tempLayer.path = [rectPath CGPath];

        self.lineView.frame = self.clippingRect;
        self.lineView.clippingRect = self.clippingRect;
        [self.lineView setNeedsDisplay];

    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.gridLayer.bounds];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.clippingRect];
    [rectPath appendPath:path];
    self.tempLayer.path = rectPath.CGPath;
    [self.tempLayer removeAllAnimations];
}


- (CGRect)getImageFrame{
    
    CGFloat bottomMargin = hxBottomMargin;
    CGFloat leftRightMargin = 50;
    CGFloat imageY = HX_IS_IPhoneX_All ? 120 : 64;
    if (HX_IS_IPhoneX_All) {
        bottomMargin = 21;
        leftRightMargin = 80;
//        imageY = 20;
    }
    CGFloat width = self.hx_w - leftRightMargin;
    CGFloat height = self.frame.size.height - imageY - 10;
    CGFloat imgWidth = self.originalImage.size.width;
    CGFloat imgHeight = self.originalImage.size.height;
    CGFloat w;
    CGFloat h;
    
    if (imgWidth > width) {
        imgHeight = width / imgWidth * imgHeight;
    }
    if (imgHeight > height) {
        w = height / self.originalImage.size.height * imgWidth;
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


- (CGRect)getShowImageFrame:(UIImage *)image{
    
    CGFloat bottomMargin = hxBottomMargin;
    CGFloat leftRightMargin = 50;
    CGFloat imageY = HX_IS_IPhoneX_All ? 120 : 64;
    if (HX_IS_IPhoneX_All) {
        bottomMargin = 21;
        leftRightMargin = 80;
        //        imageY = 20;
    }
    CGFloat width = self.hx_w - leftRightMargin;
    CGFloat height = self.frame.size.height - imageY - 10;
    CGFloat imgWidth = image.size.width;
    CGFloat imgHeight = image.size.height;
    CGFloat w;
    CGFloat h;
    
    if (imgWidth > width) {
        imgHeight = width / imgWidth * imgHeight;
    }
    if (imgHeight > height) {
        w = height / image.size.height * imgWidth;
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


- (void)setImageviewImage{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.imageView.layer addAnimation:transition forKey:nil];
    self.imageView.image = self.originalImage;
}

// 裁剪图片
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
    
    UIImage *sss = self.imageView.image;
    [sss drawAtPoint:origin];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

//- (UIImage *)screenshotAsImage{
//    UIGraphicsImageRenderer *gg = [[UIGraphicsImageRenderer alloc]initWithSize:self.imageView.bounds.size];
//
//    return [gg imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
//        [self.gridLayer.layer renderInContext:CFBridgingRetain(rendererContext)];
//    }];
//
//}

//func screenshotAsImage() -> UIImage {
//    let renderer = UIGraphicsImageRenderer(bounds: bounds)
//    return renderer.image { rendererContext in
//        layer.render(in: rendererContext.cgContext)
//    }
//}
// 获取垂直翻转后的图片
- (UIImage *)getVerticalFlipImage{
    
    return [self.imageView.image hx_rotationImage:UIImageOrientationUpMirrored];
}

#pragma mark - public
- (CGRect)getCurrentShowImageFrame{
    return [self getShowImageFrame:self.imageView.image];
}
- (void)rotateClick{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.gridLayer.alpha = 0;
        self.leftTopView.alpha = 0;
        self.leftBottomView.alpha = 0;
        self.rightTopView.alpha = 0;
        self.rightBottomView.alpha = 0;
        self.lineView.alpha = 0;
    
    } completion:^(BOOL finished) {
        
        UIImage *image = [self.imageView.image hx_rotationImage:UIImageOrientationLeft];

        CGRect imageRect = [self getShowImageFrame:image];
        self.gridLayer.frame = CGRectMake(0, 0, imageRect.size.width, imageRect.size.height);
        
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.transform = CGAffineTransformMakeRotation(-M_PI_2);
            self.imageView.frame = imageRect;
        } completion:^(BOOL finished) {
            self.imageView.transform = CGAffineTransformIdentity;
            self.imageView.image = image;
            self.imageView.frame = imageRect;
            [self clippingRatioDidChange:YES];
            
            self.gridLayer.alpha = 1;
            self.leftTopView.alpha = 1;
            self.leftBottomView.alpha = 1;
            self.rightTopView.alpha = 1;
            self.rightBottomView.alpha = 1;
            self.lineView.alpha = 1;
        }];
    }];
}

- (void)verticalFlipAction{
    
    CATransform3D transform = self.imageView.layer.transform;

    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    
    __weak typeof(self) wSelf = self;
    void (^animateBlock)(CATransform3D aTransform) = ^(CATransform3D aTransform){
        __strong typeof(wSelf) sSelf = wSelf;
        if (!sSelf) return;
        sSelf.imageView.layer.transform = aTransform;
        
    };
    
    self.imageView.layer.zPosition = -400;
    transform.m34 = 1.0 / 1500.0;
    
    [UIView animateWithDuration:0.45 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.maskView.alpha = 0;
        self.gridLayer.alpha = 0;
        self.lineView.alpha = 0;
        self.leftTopView.hidden = YES;
        self.leftBottomView.hidden = YES;
        self.rightTopView.hidden = YES;
        self.rightBottomView.hidden = YES;
        
        animateBlock(transform);
    } completion:^(BOOL finished) {
        self.imageView.layer.zPosition = 0;
        self.maskView.alpha = 1;
        self.leftTopView.hidden = NO;
        self.leftBottomView.hidden = NO;
        self.rightTopView.hidden = NO;
        self.rightBottomView.hidden = NO;
        self.lineView.alpha = 1;
        self.gridLayer.alpha = 1;
        
        self.imageView.image = [self getVerticalFlipImage];
        self.imageView.layer.transform = CATransform3DIdentity;
        [self clippingRatioDidChange:YES];

    }];
}

- (void)resizeWHScale:(CGFloat)width height:(CGFloat)height{
    
    CGFloat clippingRatio;
    
    if (width == 0 || height == 0) {
        clippingRatio = 0;
    }else{
        clippingRatio =  width / height;
    }
    
    self.isSelectRatio = YES;
    
    if (self.ratio != clippingRatio) {
        self.ratio = clippingRatio;
        [self switchClippingScale];
    }else{
        if (self.ratio == 0) {
            [self clippingRatioDidChange:YES];
        }
    }
}

- (UIImage *)getTailorImage{
    
    return [self clipImage];
}

- (UIImage *)getCurrentShowImage{

    return self.imageView.image;
}

- (CGRect)getTailorImageRect{
    return self.clippingRect;
}


#pragma mark - set
- (void)setOriginalImage:(UIImage *)originalImage{
    _originalImage = originalImage;
    
    [self changeSubviewFrame:NO];
    
    [self setImageviewImage];

}
// 裁剪
- (void)setClippingRect:(CGRect)clippingRect {
    _clippingRect = clippingRect;
    
    [self startClipping];
}



#pragma mark - gesture action

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
        
    }else {

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
    
    CGFloat ratio = (sender.view.tag == 1 || sender.view.tag==2) ? -self.ratio : self.ratio;

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

    }else {

    }
}

#pragma mark - lazy

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor colorWithRed:0.92 green:0.91 blue:0.91 alpha:1.00];
//        [UIColor RGBColorWithR:0 G:0 B:0 alpha:0.7];
    }
    return _maskView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = YES;
        [_imageView addSubview:self.gridLayer];
        self.imagePanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGridView:)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:self.imagePanGesture];
    }
    return _imageView;
}

- (CATailorGridLayer *)gridLayer {
    if (!_gridLayer) {
        _gridLayer = [[CATailorGridLayer alloc] init];
        _gridLayer.backgroundColor  = [[UIColor blackColor] colorWithAlphaComponent:.5];;
    }
    return _gridLayer;
}

- (CATailorLineView *)lineView
{
    if (!_lineView) {
        _lineView = [[CATailorLineView alloc]init];
        _lineView.backgroundColor = [UIColor clearColor];
    }
    return _lineView;
}

- (CAShapeLayer *)tempLayer
{
    if (!_tempLayer) {
        _tempLayer = [CAShapeLayer layer];
        _tempLayer.fillRule = kCAFillRuleEvenOdd;
    }
    return _tempLayer;
}

- (CATailorCornerView *)leftTopView {
    if (!_leftTopView) {
        _leftTopView = [self editCornerViewWithTag:0];
    }
    return _leftTopView;
}
- (CATailorCornerView *)leftBottomView {
    if (!_leftBottomView) {
        _leftBottomView = [self editCornerViewWithTag:1];
    }
    return _leftBottomView;
}
- (CATailorCornerView *)rightTopView {
    if (!_rightTopView) {
        _rightTopView = [self editCornerViewWithTag:2];
    }
    return _rightTopView;
}
- (CATailorCornerView *)rightBottomView {
    if (!_rightBottomView) {
        _rightBottomView = [self editCornerViewWithTag:3];
    }
    return _rightBottomView;
}

- (CATailorCornerView *)editCornerViewWithTag:(NSInteger)tag {
    CATailorCornerView *view = [[CATailorCornerView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view.backgroundColor = [UIColor clearColor];
    view.bgColor = [UIColor whiteColor];
    view.tag = tag;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCircleView:)];
    [view addGestureRecognizer:panGesture];
    [panGesture requireGestureRecognizerToFail:self.imagePanGesture];
    return view;
}

@end
