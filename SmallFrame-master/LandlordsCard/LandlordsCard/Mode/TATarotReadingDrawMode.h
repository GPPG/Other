//
//  TATarotReadingDrawMode.h
//  Tarot
//
//  Created by 郭鹏 on 2018/12/29.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TADrawLocationMode.h"

NS_ASSUME_NONNULL_BEGIN

@interface TATarotReadingDrawMode : NSObject

@property (nonatomic, strong) NSMutableArray <TADrawLocationMode *>*drawLOctionModeArray;

@property (nonatomic, copy) NSString *tarotReadingName;

@end

NS_ASSUME_NONNULL_END
