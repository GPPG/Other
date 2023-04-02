//
//  TADrawCardLayout.h
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/12.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TADrawCardLayout : UICollectionViewLayout
///item尺寸
@property(assign,nonatomic)CGSize itemSize;

///圆弧半径
@property(assign,nonatomic)CGFloat radius;

///每个item之间的角度
@property(assign,nonatomic)CGFloat anglePerItem;

///最后的角度
@property(assign,nonatomic)CGFloat angleAtExtreme;

///当前的角度
@property(assign,nonatomic)CGFloat angle;

/**
 *  存放所有显示item属性的数组
 */
@property(nonatomic,strong)NSMutableArray *attributesArray;

@end

NS_ASSUME_NONNULL_END
