//
//  UUIDViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/3/8.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "UUIDViewController.h"
#import "GSKeyChainDataManager.h"
@interface UUIDViewController ()

@end

@implementation UUIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lable =[[ UILabel alloc]initWithFrame:CGRectMake(0, 300, screen_width, 40)];
    lable.text = [GSKeyChainDataManager readUUID];
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
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
