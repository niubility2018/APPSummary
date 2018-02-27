//
//  PopViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/26.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "PopViewController.h"
#import "GBPopMenuButtonView.h"
#import <FJAlertView.h>
@interface PopViewController ()<GBMenuButtonDelegate>
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@property (nonatomic, strong) GBPopMenuButtonView *popMenuButtonView;
@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initHeaderView];
    [self initPopMenuButtonView];
    [self initFJAlertView];
}

/**
 初始化导航
 */
- (void)initHeaderView{
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    self.customNavBar.barBackgroundColor = [UIColor brownColor];
    [self.view addSubview:self.customNavBar];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.leftButton.hidden = YES;
    //    self.customNavBar.title = @"UI";
    // 设置初始导航栏透明度
    [self.customNavBar wr_setBackgroundAlpha:1];
}

/**
 初始化弹出按钮
 */
- (void)initPopMenuButtonView{
    self.popMenuButtonView = [[GBPopMenuButtonView alloc] initWithItems:@[@"00",@"90",@"80",@"年度"] size:CGSizeMake(50, 50) type:GBMenuButtonTypeLineRight isMove:YES];
    self.popMenuButtonView.backgroundColor = [UIColor orangeColor];
    self.popMenuButtonView.delegate = self;
    self.popMenuButtonView.frame = CGRectMake(15, [WRNavigationBar navBarBottom], 50, 50);
    [self.view addSubview:self.popMenuButtonView];
}

/**
 初始化alertView
 */
- (void)initFJAlertView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"alertView" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font_14_size];
    btn.backgroundColor = [UIColor brownColor];
    btn.frame = CGRectMake(0, self.popMenuButtonView.frame.origin.y+100, 100, 40);
    [btn addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark GBMenuButtonDelegate--------
- (void)menuButtonSelectedAtIdex:(NSInteger)index{
    [self.popMenuButtonView hideItems];
    NSLog(@"点击了-------%ld",(long)index);
    
}
#pragma mark btn点击事件--------------
- (void)buttonPressed{
    FJAlertView *alert = [[FJAlertView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) title:@"标题" message:@"内容" buttonTitle:nil];
    [alert show];
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
