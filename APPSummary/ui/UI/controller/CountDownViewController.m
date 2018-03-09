//
//  CountDownViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/23.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "CountDownViewController.h"
#import "APPSummary-Swift.h"
@interface CountDownViewController ()

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initCHWButton];
    [self initCountdownLabel];
}

- (void)initCHWButton{
    CHWButton *btn = [[CHWButton alloc] initWithCount:5 frame:CGRectMake(50, 100, 100, 50) color:nil];
    btn.animaType = CountBtnTypeCHWBtnTypeScale;
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
    
    CHWButton *btn2 = [[CHWButton alloc] initWithCount:5 frame:CGRectMake(200, 100, 100, 50) color:[UIColor cyanColor]];
    btn2.animaType = CountBtnTypeCHWBtnTypeRotate;
    btn2.enabled_bgColor = [UIColor greenColor];
    btn2.layer.cornerRadius = 5;
    btn2.layer.masksToBounds = YES;
    [self.view addSubview:btn2];
    
    //    let btn = CHWButton(count: 5, frame: CGRect(x: 50,y: 100,width: 100,height: 50), color:nil)
    //    btn.animaType = CountBtnType.CHWBtnTypeScale
    //    btn.layer.masksToBounds = true
    //    btn.layer.cornerRadius = 5
    //    self.view.addSubview(btn)
    //
    //    let btn2 = CHWButton(count: 5, frame: CGRect(x :200,y: 100,width: 100,height: 50), color:UIColor.cyan)
    //    btn2.enabled_bgColor = UIColor.green
    //    btn2.animaType = CountBtnType.CHWBtnTypeRotate
    //    btn2.layer.masksToBounds = true
    //    btn2.layer.cornerRadius = 5
    //    self.view.addSubview(btn2)
}

//倒计时动画Swift版本
- (void)initCountdownLabel{
    CountDownLabel *countdownLabel = [[CountDownLabel alloc] initWithFrame:CGRectMake(0, 150, 100, 50)];
//    countdownLabel.backgroundColor = [UIColor purpleColor];
    countdownLabel.textAlignment = NSTextAlignmentCenter;
    countdownLabel.textColor = [UIColor redColor];
    countdownLabel.center = self.view.center;
    countdownLabel.font =  [UIFont systemFontOfSize:25];
    countdownLabel.count = 5;
    [self.view addSubview:countdownLabel];
    //可以在合适的地方 －开始倒计时
    [countdownLabel startCount];
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
