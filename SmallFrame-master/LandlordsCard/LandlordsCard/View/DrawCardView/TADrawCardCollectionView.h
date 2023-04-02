//
//  TADrawCardCollectionView.h
//  DrawCard
//
//  Created by 郭鹏 on 2018/12/12.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TADrawLocationMode.h"

typedef void(^DrawCardSucceedBlock)(NSInteger moveLocationIndex,BOOL finishDraw);


typedef void(^DrawCardTagSucceedBlock)(NSInteger tagIndex);

typedef void(^DrawCardFinishBlock)(NSArray *finishSelectArray);

typedef void(^DrawCardStartBlock)(NSInteger moveLocationIndex,NSInteger drawCardIndex);



NS_ASSUME_NONNULL_BEGIN

@interface TADrawCardCollectionView : UICollectionView

// 移动指定位置成功回调
@property (nonatomic, copy) DrawCardSucceedBlock drawCardSucceedBlock;

@property (nonatomic, copy) DrawCardTagSucceedBlock drawCardTagSucceedBlock;


// 选完牌回调
@property (nonatomic, copy) DrawCardFinishBlock drawCardFinishBlock;

// 选牌开始回调
@property (nonatomic, copy) DrawCardStartBlock drawCardStartBlock;

// 放大缩小倍数
@property (nonatomic, assign) CGFloat scaleValue;


@property (nonatomic, strong) NSArray <TADrawLocationMode *> *goalLocationArray;




@end




NS_ASSUME_NONNULL_END
