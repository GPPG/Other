//
//  TADarwCardCollectionViewLayoutAttributes.h
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/12.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TADarwCardCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes
///锚点
@property(assign,nonatomic)CGPoint anchorPoint;

///角度
@property(assign,nonatomic)CGFloat angle;

@end

NS_ASSUME_NONNULL_END
