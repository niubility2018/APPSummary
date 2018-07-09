//
//  LZPlayerManager.m
//  LZMusicPlayerDemo
//
//  Created by 栗子 on 2017/12/20.
//  Copyright © 2017年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/. All rights reserved.
//

#import "LZPlayerManager.h"

static LZPlayerManager *_lzPlayerManager = nil;

@implementation LZPlayerManager

+(instancetype)lzPlayerManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _lzPlayerManager = [[LZPlayerManager alloc]init];
        
    });
    return _lzPlayerManager;
}
/*初始化播放器*/
- (instancetype)init
{
    if (self = [super init]) {
        _player = [[AVPlayer alloc] init];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session  setCategory:AVAudioSessionCategoryPlayback error:nil];
        [session setActive:YES error:nil];
    }
    return self;
}

// 播放
- (void)playerPlay
{
    [_player play];
    _isPlay = YES;
    
}
//暂停
- (void)playerPause
{
    [_player pause];
    _isPlay = NO;
  
}
//播放和暂停
- (void)playAndPause
{
    if (self.isPlay) {
        [self playerPause];
        if (self.isStartPlayer) {
            self.isStartPlayer(1);
        }
    }else{
        [self playerPlay];
        if (self.isStartPlayer) {
            self.isStartPlayer(0);
        }
    }
}
//前一首
- (void)playPrevious
{
    if (self.index == 0) {
        self.index = self.musicArray.count - 1;
    }else{
        self.index--;
    }
}
//下一首
- (void)playNext
{
    if (self.index == self.musicArray.count - 1) {
        self.index = 0;
    }else{
        self.index++;
    }
}

//音量
- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat
{
    self.player.volume = volumeFloat;
}
//进度
- (void)playerProgressWithProgressFloat:(CGFloat)progressFloat
{
    [self.player seekToTime:CMTimeMakeWithSeconds(progressFloat, 1) completionHandler:^(BOOL finished) {
        [self playerPlay];
    }];
}
//当前播放
- (void)replaceItemWithUrlString:(NSString *)urlString
{
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlString]];
    [self.player replaceCurrentItemWithPlayerItem:item];
    [self playerPlay];
}

@end
