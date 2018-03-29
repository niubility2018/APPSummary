//
//  ShouchangController.m
//  APPSummary
//
//  Created by xubojoy on 2018/3/29.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "ShouchangController.h"
#import "PingTransition.h"
@interface ShouchangController ()

@end

@implementation ShouchangController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(screen_width-70, 44, 50, 50);
    [self.button setTitle:@"展开" forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.button];
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}

#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        
        PingTransition *ping = [PingTransition new];
        return ping;
    }else{
        return nil;
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
