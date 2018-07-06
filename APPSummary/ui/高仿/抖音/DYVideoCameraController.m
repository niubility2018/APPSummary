//
//  DYVideoCameraController.m
//  APPSummary
//
//  Created by xubojoy on 2018/7/5.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "DYVideoCameraController.h"
#import "RootTabrTableViewController.h"
@interface DYVideoCameraController ()

@end

@implementation DYVideoCameraController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initRootTabbar];
    
}

- (void)initRootTabbar{
    RootTabrTableViewController *Main = [[RootTabrTableViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Main];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
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
