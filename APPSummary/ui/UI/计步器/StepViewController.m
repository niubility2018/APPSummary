//
//  StepViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/3/8.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "StepViewController.h"
#import "StepManager.h"
@interface StepViewController ()
{
    NSTimer *_timer;
    UILabel *lable;
}
@end

@implementation StepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[StepManager sharedManager] startWithStep];
    lable =[[ UILabel alloc]initWithFrame:CGRectMake(100, 300, 300, 40)];
    
    
    [self.view addSubview:lable];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(getStepNumber) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}


- (void)getStepNumber
{
    
    lable.text = [NSString stringWithFormat:@"我走了  %ld步",[StepManager sharedManager].step];
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
