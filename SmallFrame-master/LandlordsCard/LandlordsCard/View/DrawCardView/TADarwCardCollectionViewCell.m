


//
//  TADarwCardCollectionViewCell.m
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/12.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import "TADarwCardCollectionViewCell.h"
#import "TADarwCardCollectionViewLayoutAttributes.h"
#import "UIImage+Clip.h"

@interface TADarwCardCollectionViewCell()


@end

@implementation TADarwCardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self addView];
        
    }
    return self;
}



#pragma mark - set up
- (void)addView{
    
    [self.contentView addSubview:self.bgImageView];
    
    [self.contentView addSubview:self.cardNumberLabel];
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    
    TADarwCardCollectionViewLayoutAttributes *attributes = (TADarwCardCollectionViewLayoutAttributes *)layoutAttributes;
    
    self.layer.anchorPoint = attributes.anchorPoint;
    
    CGFloat centerY = (attributes.anchorPoint.y - 0.5) *CGRectGetHeight(self.bounds);
    
    CGPoint center = self.center;
    
    center.y += centerY;
    
    self.center = center;
}



#pragma mark - layout

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bgImageView.frame = self.contentView.frame;
    self.cardNumberLabel.frame = CGRectMake(20, 20, 30, 30);
}

#pragma mark - lazy

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"card_back"] antiAlias]];
        _bgImageView.layer.cornerRadius = 5;
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.layer.allowsEdgeAntialiasing = YES;
//        _bgImageView.layer.shouldRasterize = YES;
    }
    return _bgImageView;
}

- (UILabel *)cardNumberLabel
{
    if (!_cardNumberLabel) {
        _cardNumberLabel = [[UILabel alloc]init];
        _cardNumberLabel.text = @"1";
    }
    return _cardNumberLabel;
}
@end
