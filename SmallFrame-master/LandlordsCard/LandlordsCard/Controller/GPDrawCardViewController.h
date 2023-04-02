//
//  GPDrawCardViewController.h
//  LandlordsCard
//
//  Created by 郭鹏 on 2019/12/24.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TATarotReadinDrawModeManger.h"
#import "TATarReadingDrawContentMode.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^CardFinishBlock)(UIImage *cardImage);

@interface GPDrawCardViewController : UIViewController

@property (nonatomic, assign) TarotReadingType tarotReadingType;

@property (nonatomic, copy) CardFinishBlock cardFinishBlock;

@property (nonatomic, strong) TATarReadingDrawContentMode *cardContentMode;

@end

NS_ASSUME_NONNULL_END
