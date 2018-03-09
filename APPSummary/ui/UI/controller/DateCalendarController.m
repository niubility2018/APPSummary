//
//  DateCalendarController.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/23.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "DateCalendarController.h"
#import "DateUtils.h"
@interface DateCalendarController ()
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@end

@implementation DateCalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initHeaderView];
    [self initUI];
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

- (void)initUI{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [WRNavigationBar navBarBottom]+1, screen_width, screen_height)];
    label.text = [NSString stringWithFormat:@"明天：%@ \n 下周：%@ \n 下月：%@",[DateUtils currentCycleEndTimeStrWithType:EndTimeTypeDay],[DateUtils currentCycleEndTimeStrWithType:EndTimeTypeWeek],[DateUtils currentCycleEndTimeStrWithType:EndTimeTypeMonth]];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    [self.view addSubview:label];
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
