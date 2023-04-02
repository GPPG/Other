

//
//  TADrawCardCollectionView.m
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/12.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import "TADrawCardCollectionView.h"
#import "TADarwCardCollectionViewCell.h"
#import "UIView+LayoutMethods.h"
#import "TADrawCardLayout.h"
#import "TADarwCardCollectionViewLayoutAttributes.h"
#import "UIView+AnimationExtension.h"

#define TImeDuration 0.25

@interface TADrawCardCollectionView()<CAAnimationDelegate, UIGestureRecognizerDelegate>

@property (assign, nonatomic) CGPoint originalCenter;

@property (nonatomic, strong) UIView *drawView;

@property (nonatomic, assign) NSInteger drawTagInt;

@property (nonatomic, assign) NSInteger moveLocationIndex;

@property (nonatomic, strong) TADarwCardCollectionViewLayoutAttributes *selectAttributes;

@property (nonatomic,strong) NSMutableArray *selectArray;

@end

@implementation TADrawCardCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.panGestureRecognizer.delegate = self;
        
        if (@available(iOS 10.0, *)) {
            [self setPrefetchingEnabled:NO];
        } else {
            // Fallback on earlier versions
        }
    }
    return self;
}


#pragma mark - UIGestureRecognizerDelegate -

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.panGestureRecognizer) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        if (ABS([pan velocityInView:self].y) > ABS([pan velocityInView:self].x)) {
            //上划或者下划
            return NO;
        }
    }
    return YES;
}

#pragma mark - Touches function

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    if (self.drawView) {
        return;
    }
    
    UITouch *touche = [touches anyObject];
    UIView *drawView = touche.view;
    if ([drawView isKindOfClass:[UIImageView class]]) {
        
        NSLog(@"滑点之后");

        self.drawView = drawView;
        self.drawTagInt = self.drawView.tag;
        self.scrollEnabled =  NO;
        self.originalCenter = touche.view.center;
        CGPoint point = [touche locationInView:self.drawView];
        [self startRotateAnimation:point];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(nullable UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    UIView *drawView = touch.view;

    
    if (!self.drawView || touch.view.tag != self.drawTagInt) {
        NSLog(@"拖拽View:%@",drawView);

        return;
    }
    CGPoint curP = [touch locationInView:self];
    CGPoint preP = [touch previousLocationInView:self];
    [self moveViewAnimation:curP preP:preP];
    //    CGPoint point = [touch locationInView:self.drawView];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(nullable UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    if (!self.drawView || touch.view.tag != self.drawTagInt) {
        return;
    }
    CGPoint point = [touch locationInView:self];

    if (point.y < 0) {
        [self callBack];
        [self moveLocation];
    }else{
        [self touchEndReset];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if (!self.drawView || touch.view.tag != self.drawTagInt) {
        return;
    }
    NSLog(@"手势取消了");
    [self touchEndReset];
    
}

#pragma mark - Animation function

// 点击旋转动画
- (void)startRotateAnimation:(CGPoint)point{
    
    TADrawCardLayout *layout = (TADrawCardLayout *)self.collectionViewLayout;
    self.selectAttributes = layout.attributesArray[self.drawView.tag];
    
    self.drawView.transform = CGAffineTransformMakeRotation(-self.selectAttributes.angle);
    
    [UIView animateWithDuration:0.2 animations:^{
//        self.drawView.center = CGPointMake(self.drawView.x - point.x, self.drawView.y + point.y - self.drawView.height);

        self.drawView.center = CGPointMake(self.drawView.centerX, self.drawView.centerY + point.y - self.drawView.height);
    }];

}

// 拖拽移动动画
- (void)moveViewAnimation:(CGPoint)curP preP:(CGPoint)preP{
    
    CGFloat offsetX = curP.x - preP.x;
    CGFloat offsetY = curP.y - preP.y;
    self.drawView.center = CGPointMake(self.drawView.centerX + offsetX, self.drawView.centerY + offsetY);
}

// 复位旋转动画
- (void)finishRotateAnimation{
    
    CGAffineTransform currentTransform = self.drawView.transform;
    self.drawView.transform = CGAffineTransformRotate(currentTransform, self.selectAttributes.angle);
}

// 复位移动动画
- (void)touchEndReset{

    [UIView animateWithDuration:0.2 animations:^{
        self.drawView.center = self.originalCenter;
    } completion:^(BOOL finished) {
        [self finishRotateAnimation];
        [self resetData];
    }];
}

// 移动到指定位置动画
- (void)moveLocation{
    
    if (self.moveLocationIndex <= self.goalLocationArray.count - 1) {
        TADrawLocationMode *mode = self.goalLocationArray[self.moveLocationIndex];
        
        CGPoint point = [self.drawView.superview convertPoint:mode.centerPoint fromView:self.superview.superview];

        [self TA_tipAnimation:self.drawView toPoint:point angle:angle2Rad(mode.angle) - self.selectAttributes.angle scale:self.scaleValue animationDelegate:self];

        
        self.moveLocationIndex ++;
    }else{
        self.moveLocationIndex = self.goalLocationArray.count + 1;
        [self touchEndReset];
    }
}

// 恢复数据
- (void)resetData{
    self.scrollEnabled =  YES;
    [self.drawView.layer removeAllAnimations];
    self.drawView = nil;
    self.drawTagInt = 0;
    self.originalCenter = CGPointZero;
    self.selectAttributes = nil;
}

#pragma mark - Animation delegate

// 移动指定位置动画结束回调
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    BOOL finishDraw = NO;

    [self.selectArray addObject:@(self.drawView.tag)];

    if (self.moveLocationIndex == self.goalLocationArray.count) {

        finishDraw = YES;

        if (self.drawCardFinishBlock) {
            self.drawCardFinishBlock([self.selectArray copy]);
        }
    }

    if (self.drawCardSucceedBlock) {
        self.drawCardSucceedBlock(self.moveLocationIndex,finishDraw);
    }

    if (self.drawCardTagSucceedBlock) {
        self.drawCardTagSucceedBlock(self.drawView.tag);
    }
    

    self.drawView.superview.superview.userInteractionEnabled = NO;
    self.drawView.hidden = YES;
    [self touchEndReset];
    [self resetData];
}


#pragma mark - GestureRecognizer delegate


#pragma mark - callBack
- (void)callBack{
    
    NSLog(@"选卡回调:%ld",(long)self.drawTagInt);
    if (self.drawCardStartBlock){
        self.drawCardStartBlock(self.moveLocationIndex, self.drawTagInt);
    }
}


#pragma mark - lazy
- (NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

@end
