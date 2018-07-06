//
//  LaunchImageController.m
//  RuntimeTest
//
//  Created by xubojoy on 2018/2/9.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "LaunchImageController.h"
#import <lottie-ios/Lottie/Lottie.h>
#import "NSObject+ZJUIExtension.h"
#import "UIView+ZJExtension.h"

@interface LaunchImageController ()<UIScrollViewDelegate>{
    CGFloat _phoneWidth;
    CGFloat _phoneHeight;
    CGFloat _phoneContentWidth;
    CGFloat _phoneContentHeight;
}
@property (nonatomic, strong) UIImageView *launchMask;
@property (nonatomic, strong) LOTAnimationView *launchAnimation;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIImageView *bubbleImgView;
@property (nonatomic, strong) UIImageView *phoneImgView;
@property (nonatomic, strong) UIImageView *phoneContentImgView;
@property (nonatomic, strong) UIView *phoneContentMaskView;
@property (nonatomic, strong) NSArray *page2Ads;
@property (nonatomic, strong) NSArray *page3Ads;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *startBtn;

@end

@implementation LaunchImageController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    [self setupSubViews];
    
    if (self.isShowLaunchAnimation) {
        [self setupLaunchMask];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (_launchMask && _launchAnimation) {
        WeakObj(self);
        [_launchAnimation playWithCompletion:^(BOOL animationFinished) {
            
            [UIView animateWithDuration:0.3 animations:^{
                selfWeak.launchMask.alpha = 0;
            } completion:^(BOOL finished) {
                [selfWeak.launchAnimation removeFromSuperview];
                selfWeak.launchAnimation = nil;
                [selfWeak.launchMask removeFromSuperview];
                selfWeak.launchMask = nil;
            }];
        }];
    }
}

#pragma mark - private
- (void)setupLaunchMask{
    _launchMask = [UIImageView imageViewWithFrame:self.view.bounds image:[UIImage imageNamed:@"launchAnimationBg"]];
    
    [self.view addSubview:_launchMask];
    
    _launchAnimation = [LOTAnimationView animationNamed:@"launchAnimation"];
    _launchAnimation.cacheEnable = NO;
    _launchAnimation.frame = self.view.bounds;
    _launchAnimation.contentMode = UIViewContentModeScaleAspectFill;
    _launchAnimation.animationSpeed = 1.2;
    
    [_launchMask addSubview:_launchAnimation];
}


- (void)setupSubViews{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(BAScreenWidth * 3, 0);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    
    [self.view addSubview:_scrollView];
    
    _bgImgView = [UIImageView imageViewWithFrame:CGRectMake(0, 0, BAScreenWidth * 3, BAScreenHeight) image:[UIImage imageNamed:@"guideBg1"]];
    
    [self.view addSubview:_bgImgView];
    
    _bubbleImgView = [UIImageView imageViewWithFrame:CGRectMake(0, 0, BAScreenWidth * 3, BAScreenHeight) image:[UIImage imageNamed:@"guideBg2"]];
    
    [self.view addSubview:_bubbleImgView];
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.byValue = [NSNumber numberWithFloat:M_PI * 2];
    rotationAnimation.duration = 220;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    [_bubbleImgView.layer addAnimation:rotationAnimation forKey:nil];
    
    CGFloat bottomPadding = Screen58inch ? 9 * BAPadding : 4 * BAPadding;
    
    _phoneWidth = 0.71 * BAScreenWidth;
    _phoneHeight = _phoneWidth * 996 / 497;
    _phoneImgView = [UIImageView imageViewWithFrame:CGRectMake(BAScreenWidth / 2 - _phoneWidth / 2, BAScreenHeight - bottomPadding - _phoneHeight, _phoneWidth, _phoneHeight) image:[UIImage imageNamed:@"guidePhone"]];
    
    [self.view addSubview:_phoneImgView];
    
    UIImage *guideContentImg = [UIImage imageNamed:@"guideContent"];
    _phoneContentWidth = _phoneWidth * 0.88;
    _phoneContentHeight = _phoneContentWidth * guideContentImg.size.height / (guideContentImg.size.width / 3);
    _phoneContentMaskView = [[UIView alloc] initWithFrame:CGRectMake(_phoneWidth / 2 - _phoneContentWidth / 2 + 1, 0.09 * _phoneHeight, _phoneContentWidth, _phoneContentHeight)];
    _phoneContentMaskView.layer.masksToBounds = YES;
    
    [_phoneImgView addSubview:_phoneContentMaskView];
    
    _phoneContentImgView = [UIImageView imageViewWithFrame:CGRectMake(- 1, 0, _phoneContentWidth * 3, _phoneContentHeight) image:guideContentImg];
    
    [_phoneContentMaskView addSubview:_phoneContentImgView];
    
    NSMutableArray *temp2Array = [NSMutableArray array];
    CGFloat page2Width = BAScreenWidth - _phoneWidth * 0.75 - 3 * BAPadding;
    CGFloat page2Height = page2Width * 81 / 298;
    for (NSInteger i = 0; i < 5; i++) {
        CGFloat x = BAScreenWidth + _phoneWidth * 0.75 + 2.5 * BAPadding;
        CGFloat y = _phoneImgView.y + 0.2 * _phoneHeight + _phoneContentHeight / 5 * i * 0.75;
        NSString *imgName = [NSString stringWithFormat:@"ad%zd", i + 1];
        UIImageView *ad = [UIImageView imageViewWithFrame:CGRectMake(x, y, page2Width, page2Height) image:[UIImage imageNamed:imgName]];
        ad.alpha = 0;
        
        [_bgImgView addSubview:ad];
        [temp2Array addObject:ad];
    }
    _page2Ads = temp2Array;
    
    NSMutableArray *temp3Array = [NSMutableArray array];
    CGFloat page3Width = BAScreenWidth - _phoneWidth * 0.75 - 3 * BAPadding;
    CGFloat page3Height = page3Width * 235 / 298;
    for (NSInteger i = 0; i < 2; i++) {
        CGFloat x = 2 * BAScreenWidth + BAPadding;
        CGFloat y = _phoneImgView.y + 0.2 * _phoneHeight + _phoneContentHeight / 2 * i * 0.75;
        NSString *imgName = [NSString stringWithFormat:@"ad%zd", i + 6];
        UIImageView *ad = [UIImageView imageViewWithFrame:CGRectMake(x, y, page3Width, page3Height) image:[UIImage imageNamed:imgName]];
        ad.alpha = 0;
        
        [_bgImgView addSubview:ad];
        [temp3Array addObject:ad];
    }
    _page3Ads = temp3Array;
    
    CGFloat topPadding = Screen58inch ? 9 * BAPadding : 3 * BAPadding;
    
    _titleLabel = [UILabel labelWithFrame:CGRectMake(0, topPadding, BAScreenWidth, 28) text:@"房间搜索" color:BAWhiteColor font:[UIFont boldSystemFontOfSize:20] textAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:_titleLabel];
    
    _detailLabel = [UILabel labelWithFrame:CGRectMake(0, _titleLabel.bottom, BAScreenWidth, 43) text:@"一键搜索主播房间, 分析数据" color:BAWhiteColor font:[UIFont boldSystemFontOfSize:18] textAlignment:NSTextAlignmentCenter];
    _detailLabel.numberOfLines = 0;
    
    [self.view addSubview:_detailLabel];
    
    _startBtn = [UIButton buttonWithFrame:CGRectMake(BAScreenWidth / 2 - 211.5 / 2, BAScreenHeight - 68 - 3 * BAPadding, 211.5, 68) title:nil color:nil font:nil backgroundImage:[UIImage imageNamed:@"startNow"] target:self action:@selector(start)];
    _startBtn.alpha = 0;
    
    [self.view addSubview:_startBtn];
}


#pragma mark - animation
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if (offsetX < 0) {
        
        CGFloat bgScale = - offsetX / BAScreenWidth + 1;
        _bgImgView.transform = CGAffineTransformMakeScale(bgScale, bgScale);
        _bubbleImgView.transform = CGAffineTransformMakeScale(bgScale, bgScale);
        _bgImgView.x = 0;
        _bubbleImgView.x = 0;
        
        _phoneContentImgView.x = - 1;
        
    } else if (offsetX > BAScreenWidth * 2) {
        
        CGFloat bgScale = (offsetX - BAScreenWidth * 2) / BAScreenWidth + 1;
        _bgImgView.transform = CGAffineTransformMakeScale(bgScale, bgScale);
        _bubbleImgView.transform = CGAffineTransformMakeScale(bgScale, bgScale);
        _bgImgView.x = - BAScreenWidth * 2;
        _bubbleImgView.x = - BAScreenWidth;
        
        _phoneContentImgView.x = - 1 - 2 * _phoneContentWidth;
        
    } else {
        
        if (offsetX == 0) {
            if (![_titleLabel.text isEqualToString:@"房间搜索"]) {
                [UIView transitionWithView:_titleLabel duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
                    self.titleLabel.text = @"房间搜索";
                    self.detailLabel.text = nil;
                } completion: ^(BOOL isFinished) {
                    [UIView transitionWithView:self.detailLabel duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
                        self.detailLabel.text = @"一键搜索主播房间, 分析数据";
                    } completion: ^(BOOL isFinished) {
                        
                    }];
                }];
            }
        } else if (offsetX == BAScreenWidth) {
            if (![_titleLabel.text isEqualToString:@"弹幕列表"]) {
                [UIView transitionWithView:_titleLabel duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
                    self.titleLabel.text = @"弹幕列表";
                    self.detailLabel.text = nil;
                } completion: ^(BOOL isFinished) {
                    [UIView transitionWithView:self.detailLabel duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
                        self.detailLabel.text = @"速度控制/语义分析/\n节奏屏蔽/土豪关注";
                    } completion: ^(BOOL isFinished) {
                        
                    }];
                }];
            }
        } else if (offsetX == 2 * BAScreenWidth) {
            if (![_titleLabel.text isEqualToString:@"分析报告"]) {
                [UIView transitionWithView:_titleLabel duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
                    self.titleLabel.text = @"分析报告";
                    self.detailLabel.text = nil;
                } completion: ^(BOOL isFinished) {
                    [UIView transitionWithView:self.detailLabel duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
                        self.detailLabel.text = @"全方位监控直播状态\n实时弹幕、礼物分析";
                    } completion: ^(BOOL isFinished) {
                        
                    }];
                }];
            }
            
            [UIView animateWithDuration:0.8 animations:^{
                self.startBtn.alpha = 1;
            }];
        } else {
            [UIView animateWithDuration:0.8 animations:^{
                self.startBtn.alpha = 0;
            }];
        }
        
        //背景图
        _bgImgView.transform = CGAffineTransformIdentity;
        _bgImgView.x = - offsetX;
        _bubbleImgView.x = - offsetX / 2;
        
        //手机框
        if (offsetX < BAScreenWidth) {
            CGFloat delta = BAScreenWidth - offsetX;
            CGFloat phoneSacle = delta * 0.25 / BAScreenWidth + 0.75;
            CGFloat phoneMove = - (1 - phoneSacle) * _phoneWidth;
            
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(phoneSacle, phoneSacle);
            CGAffineTransform moveTansnform = CGAffineTransformMakeTranslation(phoneMove, 0);
            _phoneImgView.transform = CGAffineTransformConcat(scaleTransform, moveTansnform);
            
        } else if (offsetX < BAScreenWidth * 2) {
            
            CGFloat delta = 2 * BAScreenWidth - offsetX;
            CGFloat phoneMove =  (1 - delta / BAScreenWidth) * (0.5 * _phoneWidth) - 0.25 * _phoneWidth;
            
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.75, 0.75);
            CGAffineTransform moveTansnform = CGAffineTransformMakeTranslation(phoneMove, 0);
            _phoneImgView.transform = CGAffineTransformConcat(scaleTransform, moveTansnform);
            
        }
        
        //手机内容
        _phoneContentImgView.x = - 1 - offsetX * _phoneContentWidth / BAScreenWidth;
        
        //广告2
        CGFloat page2Delta = fabs(offsetX - BAScreenWidth);
        for (UIImageView *ad in _page2Ads) {
            CGFloat alpha =  1 - page2Delta / (BAScreenWidth / 2);
            ad.alpha = alpha;
        }
        
        //广告3
        CGFloat page3Delta = fabs(offsetX - 2 * BAScreenWidth);
        for (UIImageView *ad in _page3Ads) {
            CGFloat alpha =  1 - page3Delta / (BAScreenWidth / 2);
            ad.alpha = alpha;
        }
    }
}


- (void)start{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
