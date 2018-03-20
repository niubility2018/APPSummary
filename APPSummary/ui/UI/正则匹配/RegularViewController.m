//
//  RegularViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/3/20.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "RegularViewController.h"
#import "RegularVerification.h"
#define kBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[UIColor Color].CGColor];
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
@interface RegularViewController ()

@end

@implementation RegularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addOtherView];
}

- (void)addOtherView{
    
    UIButton * setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(50, 200, screen_width-100, 100);
    setBtn.backgroundColor = [UIColor whiteColor];
    kBorderRadius(setBtn, 4, 1, blackColor)
    [setBtn addTarget:self action:@selector(setBtns:) forControlEvents:UIControlEventTouchUpInside];
    [setBtn setTitle:@"点我一下" forState:UIControlStateNormal];
    [setBtn setTitleColor:kRandomColor forState:UIControlStateNormal];
    [self.view addSubview:setBtn];
}
/*具体代码都在RegularVerification内，请自行查看*/
- (void)setBtns:(UIButton *)sender{
    if ([RegularVerification checkUserName:@"测试的"]) {
        NSLog(@"YES");
    }else{
        NSLog(@"NO");
    }
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
