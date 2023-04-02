//
//  TATarotView.m
//  Tarot
//
//  Created by 李亚洲 on 2018/12/14.
//  Copyright © 2018 郭鹏. All rights reserved.
//

#import "TATarotView.h"

@interface TATarotView ()

@property (nonatomic, strong) UIImage *frontImage;
@property (nonatomic, strong) UIImage *rearImage;

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation TATarotView

- (instancetype)initWithFrontImageNamed:(NSString *)frontImageName realImageNamed:(NSString *)rearImageName {
    if (self = [super init]) {
        self.frontImage = [UIImage imageNamed:frontImageName];
        self.rearImage = [UIImage imageNamed:rearImageName];
        [self customInit];
    }
    return self;
}

- (void)customInit {
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.image = self.rearImage;
    [self addSubview:imageView];
    self.imageView = imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setFront:(BOOL)front {
    _front = front;
    
    self.imageView.image = front ? self.frontImage : self.rearImage;
}

@end
