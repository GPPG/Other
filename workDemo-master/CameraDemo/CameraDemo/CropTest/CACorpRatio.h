//
//  CACorpRatio.h
//  CameraDemo
//
//  Created by 郭鹏 on 2019/5/23.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CACorpRatio : UIView

@property (nonatomic, assign) BOOL isLandscape;
@property (nonatomic, readonly) CGFloat ratio;
@property (nonatomic, strong) NSString *titleFormat;
@property (nonatomic, readonly) CGFloat value1;
@property (nonatomic, readonly) CGFloat value2;
- (id)initWithValue1:(CGFloat)value1 value2:(CGFloat)value2;

@end

NS_ASSUME_NONNULL_END
