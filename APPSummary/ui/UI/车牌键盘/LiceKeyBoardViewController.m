//
//  LiceKeyBoardViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/7/6.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "LiceKeyBoardViewController.h"
#import "LicensePlateTextField.h"
@interface LiceKeyBoardViewController ()
@property (strong, nonatomic) LicensePlateTextField *textField;
@end

@implementation LiceKeyBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.textField = [[LicensePlateTextField alloc] initWithFrame:CGRectMake(15, 100, screen_width-30, 50)];
    [self.view addSubview:self.textField];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.textField.curentIndex = 2;
    [self.textField becomeFirstResponder];
    self.textField.text = @"粤B62AF2";
    
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
