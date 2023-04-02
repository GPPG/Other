

//
//  TATarotReadingCardView.m
//  Tarot
//
//  Created by 郭鹏 on 2019/1/2.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "TATarotReadingCardView.h"
#import "TACardRippleView.h"


@interface TATarotReadingCardView()

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, assign) CardStatus cardStatus;

@property (nonatomic, strong) TACardRippleView *rippleView;

@end



@implementation TATarotReadingCardView


- (instancetype)initWithCardStatus:(CardStatus)cardStatus{
    
    if (self = [super init]) {
        self.cardStatus = cardStatus;
    }
    return self;
}

#pragma mark - set up

- (void)addView{
    [self addSubview:self.bgImageView];
    [self addSubview:self.rippleView];
    [self addSubview:self.topLabel];
    [self addSubview:self.bottomLabel];
}

- (void)setupUI{
    self.topLabel.hidden = YES;
    self.bottomLabel.hidden = YES;
}



#pragma mark - public
- (void)setup{
    
    [self addView];
    [self setupUI];

    

}

- (void)updateCardStatus:(CardStatus)cardStatus{
    
    self.cardStatus = cardStatus;
}



#pragma mark - set
- (void)setCardStatus:(CardStatus)cardStatus{
    _cardStatus = cardStatus;
    
    [self updateUI];
}

- (void)updateUI{
    
    switch (self.cardStatus) {
            
        case CardBlankStatus:
            
            [self blankStatus];
            
            break;
            
        case CardDragStatus:
            
            [self dragStatus];
            
            break;
            
        case CardPlaceholderStatus:
            
            [self placeholderStatus];
            break;
            
        case CardNormalStatus:
            
            [self normalStatus];
            break;

        default:
            break;
    }
}

- (void)blankStatus{

    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor colorWithHexString:@"#7f6ff6"].CGColor;
    self.bgImageView.hidden = YES;
    self.topLabel.hidden = YES;
    self.bottomLabel.hidden = YES;
}

- (void)dragStatus{
    if (self.width > self.height) {
        self.backgroundColor = [UIColor colorWithHexString:@"#312348" alpha:0.95];
    }
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor colorWithHexString:@"#7f6ff6"].CGColor;
    self.bgImageView.hidden = YES;
    self.topLabel.hidden = NO;
    self.bottomLabel.hidden = NO;
    [self.rippleView startAnimation];
}

- (void)placeholderStatus{
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 0;
    self.layer.masksToBounds = NO;
    self.layer.borderWidth = 0;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.bgImageView.hidden = NO;
    self.topLabel.hidden = YES;
    self.bottomLabel.hidden = YES;
    [self.rippleView removeFromSuperview];
}

- (void)normalStatus{
    self.layer.cornerRadius = 0;
    self.layer.masksToBounds = NO;
    self.layer.borderWidth = 0;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.bgImageView.hidden = NO;
    self.topLabel.hidden = YES;
    self.bottomLabel.hidden = YES;
    [self.rippleView removeFromSuperview];
}


#pragma mark - layout
- (void)layoutSubviews{
    [super layoutSubviews];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11) {
        self.bgImageView.frame = CGRectMake(0, 0, self.tempSize.width, self.tempSize.height);
        self.topLabel.width = self.tempSize.width;
        self.topLabel.height = 20;
        self.topLabel.center = CGPointMake(self.tempSize.width * 0.5, self.tempSize.height * 0.5 - 13);
        
        self.bottomLabel.height = 20;
        self.bottomLabel.width = self.tempSize.width;
        self.bottomLabel.center = CGPointMake(self.tempSize.width * 0.5, self.tempSize.height * 0.5 + 13);
        
    }else{

        [self.bgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        [self.topLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_centerY).mas_equalTo(-3);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];
        
        [self.bottomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_centerY).mas_equalTo(3);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];

        
    }
    
    
}

#pragma mark - lazy
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card_back"]];
        _bgImageView.layer.cornerRadius = 5;
        _bgImageView.layer.masksToBounds = YES;

    }
    return _bgImageView;
}

- (UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
//        _topLabel.text = kString(@"today_showCardCell_centerTopLabel_title");
        _topLabel.font = [UIFont systemFontOfSize:17];
        _topLabel.textColor = [UIColor colorWithHexString:@"#7d65ac"];
    }
    return _topLabel;
}

- (UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
//        _bottomLabel.text = kString(@"today_showCardCell_centerBottomLabel_title");
        _bottomLabel.font = [UIFont systemFontOfSize:17];
        _bottomLabel.textColor = [UIColor colorWithHexString:@"#7d65ac"];
    }
    return _bottomLabel;
}

- (TACardRippleView *)rippleView
{
    if (!_rippleView) {

        _rippleView = [[TACardRippleView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    }
    return _rippleView;
}

@end
