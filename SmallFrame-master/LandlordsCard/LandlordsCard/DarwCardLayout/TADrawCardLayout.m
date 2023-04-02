//
//  TADrawCardLayout.m
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/12.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import "TADrawCardLayout.h"
#import "TADarwCardCollectionViewLayoutAttributes.h"

@interface TADrawCardLayout ()

@end


@implementation TADrawCardLayout

- (void)prepareLayout{
    
    [super prepareLayout];
    
    [self setupAttributes];
}

- (void)setupAttributes{
    [self.attributesArray  removeAllObjects];
    CGFloat centerX = self.collectionView.contentOffset.x  + (CGRectGetWidth(self.collectionView.bounds)/2.0);
    CGFloat anchorPointY = (self.radius + self.itemSize.height * 0.5)/self.itemSize.height;
    NSInteger startIndex = 0;
    NSInteger endIndex = [self.collectionView numberOfItemsInSection:0] - 1;
    for (NSInteger i = startIndex; i<= endIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取每一个item
        TADarwCardCollectionViewLayoutAttributes *attributes =   (TADarwCardCollectionViewLayoutAttributes *)[TADarwCardCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.size = self.itemSize;
        ///每个item都在collectionview的正中间
        attributes.center = CGPointMake(centerX, CGRectGetMidY(self.collectionView.bounds) * 0.5);
        ///每个item 都transform旋转angle
        attributes.angle = self.angle + self.anglePerItem * (CGFloat)i;
        ///锚点
        CGPoint anchorPoint = CGPointMake(0.5, anchorPointY);
        ///设置锚点
        attributes.anchorPoint = anchorPoint;
        
        //将每一个item属性添加到展示item的数组中
        [self.attributesArray addObject:attributes];
    }
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attributesArray;
}


- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.attributesArray[indexPath.item];
}


-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    CGPoint finalContentOffset = proposedContentOffset;
    //    ///最大的偏移量X
    CGFloat maxOffsetX = [self collectionViewContentSize].width - CGRectGetWidth(self.collectionView.bounds);
    
    CGFloat proposedAngle = -self.angleAtExtreme* (proposedContentOffset.x/maxOffsetX);
    
    CGFloat ratio = proposedAngle/self.anglePerItem;
    
    CGFloat multiplier = 0.0;
    CGFloat padding = 0;
    if (velocity.x > 0) {
        multiplier = ceil(ratio);
        padding = -100;
    } else if (velocity.x < 0) {
        multiplier = floor(ratio);
        padding = 100;
    } else {
        multiplier = round(ratio);
    }
    
    
    finalContentOffset.x = multiplier * self.anglePerItem *maxOffsetX /(-self.angleAtExtreme) + padding;

    return finalContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}

-(CGSize)collectionViewContentSize{
    return CGSizeMake(self.itemSize.width * [self.collectionView numberOfItemsInSection:0], 300);
}

// LSDWheelCollectionLayoutAttributes
+(Class)layoutAttributesClass{

    return [TADarwCardCollectionViewLayoutAttributes class];
}


//初始化属性数组
-(NSMutableArray *)attributesArray{
    if (_attributesArray == nil) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

-(void)setRadius:(CGFloat)radius
{
    
    _radius = radius;
    
    [self invalidateLayout];
}

//-(CGFloat)anglePerItem
//{
//    return atan(self.itemSize.width / self.radius)- 0.05;
//}

-(CGFloat)angleAtExtreme
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    return count > 0? -(CGFloat)((count - 1)*self.anglePerItem):0;
}

-(CGFloat)angle
{
    
    return self.angleAtExtreme * self.collectionView.contentOffset.x/([self collectionViewContentSize].width - CGRectGetWidth(self.collectionView.bounds));
}




@end
