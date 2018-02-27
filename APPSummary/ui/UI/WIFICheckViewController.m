//
//  WIFICheckViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/23.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "WIFICheckViewController.h"
#import "CaptivePortalCheck.h"
@interface WIFICheckViewController ()
//WiFi认证
@property (strong, nonatomic)  UILabel *checkResultLabel;
@end

@implementation WIFICheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
}

- (void)setUpUI{
    UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(20, 100, 100, 40)];
    [switchBtn addTarget:self action:@selector(testModeSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchBtn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(30, 400, 50, 50);
    btn1.backgroundColor = [UIColor cyanColor];
    [btn1 addTarget:self action:@selector(checkWifiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

}

- (void)testModeSwitchValueChanged:(UISwitch *)sender {
    [CaptivePortalCheck sharedInstance].openTestMode = sender.isOn;
}

- (void)checkWifiBtnClick:(UIButton *)sender {
    self.checkResultLabel.text = @"认证中...";
    // TODO 如果当前网络状态不是WIFI，则无需检查
    [[CaptivePortalCheck sharedInstance] checkIsWifiNeedAuthPasswordWithComplection:^(BOOL needAuthPassword) {
        self.checkResultLabel.text = needAuthPassword ? @"验证结果：需要认证" : @"验证结果：无需认证";
    } needAlert:YES];
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
