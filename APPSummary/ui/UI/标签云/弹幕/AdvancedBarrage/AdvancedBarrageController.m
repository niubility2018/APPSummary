//
//  AdvancedBarrageController.m
//  BarrageRendererDemo
//
//  Created by UnAsh on 15/11/18.
//  Copyright (c) 2015年 ExBye Inc. All rights reserved.
//

#import "AdvancedBarrageController.h"
#import <BarrageRenderer/BarrageRenderer.h>
#import "UIImage+Barrage.h"
#import "BarrageWalkImageTextSprite.h"

@interface AdvancedBarrageController()<BarrageRendererDelegate>
{
    BarrageRenderer * _renderer;
    NSTimer * _timer;
    NSInteger _index;
    NSDate * _startTime;
    NSTimeInterval _predictedTime; //快进时间
}

@end

@implementation AdvancedBarrageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initBtnView];
    _index = 0;
    _predictedTime = 0.0f;
    [self initBarrageRenderer];
}

- (void)initBtnView{
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.backgroundColor = [UIColor cyanColor];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(screen_width/6, 40));
    }];
    
    UIButton *loadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loadBtn.backgroundColor = [UIColor cyanColor];
    [loadBtn setTitle:@"加载" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(load:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    [loadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(startBtn.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(screen_width/6, 40));
    }];
    
    UIButton *hybridABtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hybridABtn.backgroundColor = [UIColor cyanColor];
    [hybridABtn setTitle:@"混排A" forState:UIControlStateNormal];
    [hybridABtn addTarget:self action:@selector(hybridA:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hybridABtn];
    [hybridABtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(loadBtn.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(screen_width/6, 40));
    }];
    
    UIButton *hybridBBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hybridBBtn.backgroundColor = [UIColor cyanColor];
    [hybridBBtn setTitle:@"混排B" forState:UIControlStateNormal];
    [hybridBBtn addTarget:self action:@selector(hybridB:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hybridBBtn];
    [hybridBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hybridABtn.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(screen_width/6, 40));
    }];
    
    UIButton *backwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backwardBtn.backgroundColor = [UIColor cyanColor];
    [backwardBtn setTitle:@"快退5s" forState:UIControlStateNormal];
    [backwardBtn addTarget:self action:@selector(backward:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backwardBtn];
    [backwardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hybridBBtn.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(screen_width/6, 40));
    }];
    
    UIButton *forewardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forewardBtn.backgroundColor = [UIColor cyanColor];
    [forewardBtn setTitle:@"快进5s" forState:UIControlStateNormal];
    [forewardBtn addTarget:self action:@selector(foreward:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forewardBtn];
    [forewardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backwardBtn.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(screen_width/6, 40));
    }];
    
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.textAlignment = NSTextAlignmentLeft;
    self.infoLabel.font = [UIFont systemFontOfSize:font_14_size];
    [self.view addSubview:self.infoLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(screen_width-60, 40));
    }];
    
}

- (void)initBarrageRenderer
{
    _renderer = [[BarrageRenderer alloc]init];
    _renderer.delegate = self;
    _renderer.redisplay = YES;
    [self.view addSubview:_renderer.view];
    [self.view sendSubviewToBack:_renderer.view];
}

- (void)dealloc
{
    [_renderer stop];
}

#pragma mark - Action
- (IBAction)start:(id)sender
{
    _startTime = [NSDate date];
    [_renderer start];
}

- (IBAction)load:(id)sender
{
    NSInteger const number = 10;
    NSMutableArray * descriptors = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < number; i++) {
        [descriptors addObject:[self walkTextSpriteDescriptorWithDelay:i*2+1]];
    }
    [_renderer load:descriptors];
}

- (IBAction)hybridA:(id)sender
{
    [_renderer receive:[self walkImageTextSpriteDescriptorAWithDirection:BarrageWalkDirectionR2L]];
}

- (IBAction)hybridB:(id)sender
{
    [_renderer receive:[self walkImageTextSpriteDescriptorBWithDirection:BarrageWalkDirectionL2R]];
}

- (IBAction)backward:(id)sender
{
    _predictedTime -= 5.0f;
}

- (IBAction)foreward:(id)sender
{
    _predictedTime += 5.0f;
}

#pragma mark - 弹幕描述符生产方法

/// 生成精灵描述 - 延时文字弹幕
- (BarrageDescriptor *)walkTextSpriteDescriptorWithDelay:(NSTimeInterval)delay
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
    descriptor.params[@"text"] = [NSString stringWithFormat:@"延时弹幕(延时%.0f秒):%ld",delay,(long)_index++];
    descriptor.params[@"textColor"] = [UIColor blueColor];
    descriptor.params[@"speed"] = @(100 * (double)random()/RAND_MAX+50);
    descriptor.params[@"direction"] = @(1);
    descriptor.params[@"delay"] = @(delay);
    return descriptor;
}

/// 图文混排精灵弹幕 - 过场图文弹幕A
- (BarrageDescriptor *)walkImageTextSpriteDescriptorAWithDirection:(NSInteger)direction
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = NSStringFromClass([BarrageWalkImageTextSprite class]);
    descriptor.params[@"text"] = [NSString stringWithFormat:@"AA-图文混排/::B过场弹幕:%ld",(long)_index++];
    descriptor.params[@"textColor"] = [UIColor greenColor];
    descriptor.params[@"speed"] = @(100 * (double)random()/RAND_MAX+50);
    descriptor.params[@"direction"] = @(direction);
    return descriptor;
}

/// 图文混排精灵弹幕 - 过场图文弹幕B
- (BarrageDescriptor *)walkImageTextSpriteDescriptorBWithDirection:(NSInteger)direction
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
    descriptor.params[@"text"] = [NSString stringWithFormat:@"AA-图文混排/::B过场弹幕:%ld",(long)_index++];
    descriptor.params[@"textColor"] = [UIColor greenColor];
    descriptor.params[@"speed"] = @(100 * (double)random()/RAND_MAX+50);
    descriptor.params[@"direction"] = @(direction);
    
    NSTextAttachment * attachment = [[NSTextAttachment alloc]init];
    attachment.image = [[UIImage imageNamed:@"avatar"]barrageImageScaleToSize:CGSizeMake(25.0f, 25.0f)];
    NSMutableAttributedString * attributed = [[NSMutableAttributedString alloc]initWithString:
                                              [NSString stringWithFormat:@"BB-图文混排过场弹幕:%ld",(long)_index++]];
    [attributed insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:7];
    
    descriptor.params[@"attributedText"] = attributed;
    descriptor.params[@"textColor"] = [UIColor magentaColor];
    descriptor.params[@"speed"] = @(100 * (double)random()/RAND_MAX+50);
    descriptor.params[@"direction"] = @(direction);
    return descriptor;
}

- (void)updateMockVideoProgress
{
    NSTimeInterval interval = [[NSDate date]timeIntervalSinceDate:_startTime];
    interval += _predictedTime;
    self.infoLabel.text = [NSString stringWithFormat:@"视频进度：%.1fs",interval];
}

#pragma mark - BarrageRendererDelegate

- (NSTimeInterval)timeForBarrageRenderer:(BarrageRenderer *)renderer
{
    [self updateMockVideoProgress]; // 仅为演示
    NSTimeInterval interval = [[NSDate date]timeIntervalSinceDate:_startTime];
    interval += _predictedTime;
    return interval;
}

@end
