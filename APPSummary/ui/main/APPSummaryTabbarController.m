//
//  APPSummaryTabbarController.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/24.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "APPSummaryTabbarController.h"
#import "APPSummaryNavigationController.h"
#import "APPUISummaryController.h"
#import "APPQuestionSummaryController.h"
@interface APPSummaryTabbarController ()<UITabBarControllerDelegate>

@end

@implementation APPSummaryTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor redColor];
//    [self setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, -3)] forKeyPath:LMJKeyPath(self, titlePositionAdjustment)];
    [self addTabarItems];
    [self addChildViewControllers];
    
    self.delegate = self;
}

- (void)addChildViewControllers
{
    APPSummaryNavigationController *one = [[APPSummaryNavigationController alloc] initWithRootViewController:[[APPQuestionSummaryController alloc] init]];
    APPSummaryNavigationController *two = [[APPSummaryNavigationController alloc] initWithRootViewController:[[APPUISummaryController alloc] init]];
    self.viewControllers = @[one, two];
}

- (void)addTabarItems
{
    
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"UI",
                                                 CYLTabBarItemImage : @"tabBar_essence_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_essence_click_icon",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"知识点",
                                                  CYLTabBarItemImage : @"tabBar_new_icon",
                                                  CYLTabBarItemSelectedImage : @"tabBar_new_click_icon",
                                                  };
    
    self.tabBarItemsAttributes = @[ secondTabBarItemsAttributes,
                                    firstTabBarItemsAttributes
                                       ];
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
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
