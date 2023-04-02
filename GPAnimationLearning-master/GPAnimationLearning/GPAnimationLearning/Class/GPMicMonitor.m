//
//  GPMicMonitor.m
//  GPAnimationLearning
//
//  Created by 郭鹏 on 2017/6/14.
//  Copyright © 2017年 郭鹏. All rights reserved.
//

#import "GPMicMonitor.h"
#import <AVFoundation/AVFoundation.h>

@interface GPMicMonitor()

@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSDictionary *settingDic;

@property (nonatomic, strong) AVAudioSession *audioSession;
@end


@implementation GPMicMonitor

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.audioSession = [AVAudioSession sharedInstance];
    
    if (self.audioSession.recordPermission != AVAudioSessionRecordPermissionGranted) {
        [self.audioSession requestRecordPermission:^(BOOL granted) {
            NSLog(@"%d",granted);
        }];
    }else{
        
        
    }
    
    
}


#pragma mark - set
- (NSDictionary *)settingDic
{
    if (!_settingDic) {
        _settingDic = @{
                        AVSampleRateKey : @(44100.0),
                        AVNumberOfChannelsKey : @(1),
                        AVFormatIDKey : @(kAudioFormatAppleLossless),
                        AVEncoderAudioQualityKey : @(AVAudioQualityMin),
                        };
    }
    return _settingDic;
}
@end
