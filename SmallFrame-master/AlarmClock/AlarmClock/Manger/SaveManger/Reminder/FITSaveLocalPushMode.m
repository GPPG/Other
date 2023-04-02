



//
//  FITSaveLocalPushMode.m
//  AlarmClockNotice
//
//  Created by 郭鹏 on 2018/8/8.
//  Copyright © 2018年 郭鹏. All rights reserved.
//

#import "FITSaveLocalPushMode.h"
#import "NSDate+JKUtilities.h"


@implementation FITSaveLocalPushTotalMode

- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
@end


@implementation FITSaveLocalPushSubTotalMode
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }

@end

@implementation FITSaveLocalPushMode
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
@end
