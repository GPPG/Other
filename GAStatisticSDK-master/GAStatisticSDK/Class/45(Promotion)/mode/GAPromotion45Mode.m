//
//  GAPromotion45Mode.m
//  GAStatisticSDK
//
//  Created by heyongwen on 2019/4/17.
//  Copyright © 2019年 郭鹏. All rights reserved.
//

#import "GAPromotion45Mode.h"
#import "GAGeneralModel.h"

@interface GAPromotion45Mode ()

@property (nonatomic, strong) GAGeneralModel *generalModel;
@end

@implementation GAPromotion45Mode
//@synthesize fmbdId;

- (instancetype)initWithPn:(NSInteger)pn af:(NSString *)af aa:(NSString *)aa ga:(NSString *)ga re:(NSString *)re {
    if (self = [super init]) {
        self.af = af;
        self.aa = aa;
        self.ga = ga;
        self.re = re;
        self.generalModel = [[GAGeneralModel alloc] initWithPn:pn];
    }
    return self;
}



@end
