//
//  TATarReadingDrawContentMode.h
//  Tarot
//
//  Created by 郭鹏 on 2019/1/9.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TATarReadingDrawCardMode;
NS_ASSUME_NONNULL_BEGIN

@interface TATarReadingDrawContentMode : NSObject

@property (nonatomic, strong) NSArray<TATarReadingDrawCardMode *> *cardModeArray;

@property (nonatomic, assign) NSInteger spreadId;

@property (nonatomic, copy) NSString *topicId;

@property (nonatomic, copy) NSString *topicName;


- (instancetype)initWithMode;

@end



@interface TATarReadingDrawCardMode : NSObject

@property (nonatomic, assign) BOOL cardType;

@property (nonatomic, copy) NSString *cardID;

@end




NS_ASSUME_NONNULL_END
