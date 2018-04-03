//
//  ZhuanAnimationController.m
//  APPSummary
//
//  Created by xubojoy on 2018/4/3.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "ZhuanAnimationController.h"

@interface ZhuanAnimationController ()

@end

@implementation ZhuanAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    // 这里最重要的是计算锚点(左上角：(0,0) 右上角:(1,0) 中心:(0.5,0.5) 左下角:(0,1) 右下角:(1,1)) 如果不是上述中的任何一个点也没有关系 可以根据比例来计算就行
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(100, 400, 100, 50);
    startBtn.backgroundColor = [UIColor orangeColor];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    endBtn.frame = CGRectMake(300, 400, 100, 50);
    endBtn.backgroundColor = [UIColor orangeColor];
    [endBtn setTitle:@"结束" forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(endBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endBtn];
    
    
    self.playingstatusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.playingstatusImageView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.playingstatusImageView];
}

- (void)startBtnClick{
    CGPoint oldOrigin = self.playingstatusImageView.frame.origin;
    self.playingstatusImageView.layer.anchorPoint = CGPointMake(0.8, 12 / 70.0);
    CGPoint newOrigin = self.playingstatusImageView.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    self.playingstatusImageView.center = CGPointMake (self.playingstatusImageView.center.x - transition.x, self.playingstatusImageView.center.y - transition.y);
    [UIView animateWithDuration:0.5 animations:^{
        self.playingstatusImageView.transform = CGAffineTransformMakeRotation(-M_PI * 5/12);
    }];
}

- (void)endBtnClick{
    CGPoint oldOrigin = self.playingstatusImageView.frame.origin;
    // 锚点可以根据宽高比例算出来
    self.playingstatusImageView.layer.anchorPoint = CGPointMake(0.8, 12 / 70.0);
    CGPoint newOrigin = self.playingstatusImageView.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    self.playingstatusImageView.center = CGPointMake (self.playingstatusImageView.center.x - transition.x, self.playingstatusImageView.center.y - transition.y);
    [UIView animateWithDuration:0.5 animations:^{
        self.playingstatusImageView.transform = CGAffineTransformMakeRotation(0);
    }];
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
