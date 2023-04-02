//
//  TADrawCardView.m
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/19.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import "TADrawCardView.h"
#import "TADrawCardCollectionView.h"
#import "TADrawCardLayout.h"
#import "TADarwCardCollectionViewCell.h"


static NSString * const TADarwCardCollectionViewCellID = @"TADarwCardCollectionViewCellID";


@interface TADrawCardView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic) TADrawCardCollectionView *collectionview;

@property (nonatomic, strong) NSMutableArray *cardStatusArray;

@end


@implementation TADrawCardView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
     
        [self setup];
        
        [self addView];
        
        [self regisCell];
        
        [self callback];
    }
    return self;
}

#pragma mark - set up
- (void)setup{
    self.collectionview.clipsToBounds = NO;
}


- (void)addView{    
    [self addSubview:self.collectionview];
}


- (void)regisCell{
    
    [self.collectionview registerClass:[TADarwCardCollectionViewCell class] forCellWithReuseIdentifier:TADarwCardCollectionViewCellID];
}

- (void)setGoalLocationArray:(NSArray<TADrawLocationMode *> *)goalLocationArray{
    _goalLocationArray = goalLocationArray;
    self.collectionview.goalLocationArray = goalLocationArray;
}

- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.collectionview.backgroundColor = bgColor;
}


#pragma mark - set
- (void)setScaleValue:(CGFloat)scaleValue{
    _scaleValue = scaleValue;
    self.collectionview.scaleValue = scaleValue;
}

#pragma mark - callback
- (void)callback{
    
    WS(ws);
    self.collectionview.drawCardStartBlock = ^(NSInteger moveLocationIndex, NSInteger drawCardIndex) {
        if (ws.drawCardStartBlock) {
            ws.drawCardStartBlock(moveLocationIndex, drawCardIndex);
        }
    };
    
    self.collectionview.drawCardFinishBlock = ^(NSArray *finishSelectArray) {
      
        if (ws.drawCardFinishBlock) {
            ws.drawCardFinishBlock(finishSelectArray);
        }
    };

    // 抽牌成功回调
    
    self.collectionview.drawCardSucceedBlock = ^(NSInteger moveLocationIndex, BOOL finishDraw) {
        if (ws.drawCardSucceedBlock) {
            ws.drawCardSucceedBlock(moveLocationIndex, finishDraw);
        }
    };
    
    self.collectionview.drawCardTagSucceedBlock = ^(NSInteger tagIndex) {
        [ws.cardStatusArray replaceObjectAtIndex:tagIndex withObject:@"1"];

    };
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 22;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger cardStatus = [self.cardStatusArray[indexPath.row] integerValue];
    
    TADarwCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TADarwCardCollectionViewCellID forIndexPath:indexPath];
    cell.bgImageView.tag = indexPath.row;
    cell.bgImageView.hidden = cardStatus;
    
    cell.cardNumberLabel.hidden = YES;

    return  cell;
}



#pragma mark - UICollectionViewDelagate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了");
}

#pragma mark - lazy

- (TADrawCardCollectionView *)collectionview
{
    if (!_collectionview) {
        
        TADrawCardLayout *layout = [[TADrawCardLayout alloc]init];
        layout.itemSize = CGSizeMake(90 * 1.2, 150 * 1.2);
        layout.radius = 600;
        layout.anglePerItem = M_PI / 40;
        _collectionview = [[TADrawCardCollectionView alloc]initWithFrame:CGRectMake(0,0,self.width,self.height) collectionViewLayout:layout];
        _collectionview.dataSource = self;
        _collectionview.delegate = self;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.backgroundColor = [UIColor colorWithRed:0.19 green:0.15 blue:0.29 alpha:1.00];
        CGFloat maxOffsetX = layout.collectionViewContentSize.width - CGRectGetWidth(_collectionview.bounds);
        [_collectionview setContentOffset:CGPointMake(maxOffsetX * 0.5, 0) animated:NO];
    }
    return _collectionview;
}

- (NSMutableArray *)cardStatusArray
{
    if (!_cardStatusArray) {
        _cardStatusArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    }
    return _cardStatusArray;
}





@end
