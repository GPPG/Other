//
//  GABasic19Mode.h
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/17.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GABasic19Mode : NSObject

- (instancetype)initWithPn:(NSInteger)pn;

//累计用户打开次数
@property (nonatomic, assign) NSInteger uo;

- (NSString*)getType;
+ (NSString *)getType;

@end

