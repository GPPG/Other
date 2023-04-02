
//
//  FITRemindNoAuthorView.m
//  fitness
//
//  Created by 郭鹏 on 2018/8/20.
//  Copyright © 2018年 supergeek. All rights reserved.
//

#import "FITRemindNoAuthorView.h"

@interface FITRemindNoAuthorView()

@property (nonatomic, strong) UILabel *contentLabel;

@end


@implementation FITRemindNoAuthorView

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(dp(24));
        make.right.equalTo(self).offset(dp(0));
        make.top.equalTo(self).offset(dp(18));
        make.bottom.equalTo(self).offset(dp(-18));
    }];
}


- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.text = NSLocalizedString(@"KeepFit does not have access to your notifications.Please go to Settings -> Notifications and enable access to KeepFit.",nil);
        _contentLabel.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont sfProDisplayRegularFontWithSize:16];
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
