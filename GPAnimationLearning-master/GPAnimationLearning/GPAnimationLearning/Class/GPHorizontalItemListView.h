//
//  GPHorizontalItemList.h
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/4/7.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didSelectItemBlock)(NSInteger index);

@interface GPHorizontalItemListView : UIScrollView
@property (nonatomic, copy) didSelectItemBlock didSelectItemBlock;
- (instancetype)initWithView:(UIView *)view;
- (void)didMoveToSuperview;
@end
