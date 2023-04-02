//
//  GPAssistant.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/6/14.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "GPAssistant.h"
#import <AVFoundation/AVFoundation.h>

@interface GPAssistant()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) NSArray *strArray;

@property (nonatomic, strong) AVSpeechSynthesizer *synth;

@end

@implementation GPAssistant

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc]init];
    synth.delegate = self;
    self.synth = synth;
}
- (void)speak:(NSString *)phrase com:(completionBlock)completionBlock
{
    self.completionBlock = completionBlock;
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:phrase];
    utterance.rate = AVSpeechUtteranceDefaultSpeechRate;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    utterance.volume = 1.0;
    [self.synth speakUtterance:utterance];
}
- (NSString *)randomAnswer
{
    int temp = (int)self.strArray.count;
    return self.strArray[arc4random_uniform(temp)];
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    if (self.completionBlock) {
        self.completionBlock();
    }
}
- (NSArray *)strArray
{
    if (!_strArray) {
        _strArray = @[@"你瞅啥",@"瞅你咋的",@"来，你过来咱俩唠唠…………"];
    }
    return _strArray;
}
@end
