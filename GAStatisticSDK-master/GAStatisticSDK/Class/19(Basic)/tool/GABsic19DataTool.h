//
//  GABsic19DataTool.h
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/18.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GABsic19DataTool : NSObject

+ (instancetype)shareTool;

- (void)updateUserOpenCountWithComplete:(void(^ __nullable)(BOOL success))complete;
- (void)uploadWithComplete:(void(^ __nullable)(BOOL success))complete;

@end

