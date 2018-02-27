//
//  TouchIDViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/23.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "TouchIDViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface TouchIDViewController ()
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initHeaderView];
    [self authenticateUser];
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

- (void)authenticateUser
{
    //初始化上下文对象
    LAContext* context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"输入登陆密码";
    //错误对象
    NSError* error = nil;
    NSString* result = @"需要验证指纹";
    /**
     注意两者的区别，
     首先支持的版本不同、
     //LAPolicyDeviceOwnerAuthentication  iOS 9.0 以上
     //kLAPolicyDeviceOwnerAuthenticationWithBiometrics  iOS 8.0以上
     其次输入 密码次数有关
     用kLAPolicyDeviceOwnerAuthenticationWithBiometrics 就好拉
     
     最主要的是，前者  使用“context.localizedFallbackTitle = @"输入登陆密码";”
     上面这个属性的时候，不能按我们设定的要求走，它会直接弹出验证
     
     所以还是用后者，kLAPolicyDeviceOwnerAuthenticationWithBiometrics
     
     */
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                //验证成功，主线程处理UI
                NSLog(@"验证成功");
            }
            else
            {
                
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"Authentication was cancelled by the system");
                        //切换到其他APP，系统取消验证Touch ID
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"Authentication was cancelled by the user");
                        //用户取消验证Touch ID
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        NSLog(@"User selected to enter custom password");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                        }];
                        break;
                    }
                        
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        NSLog(@"%@",error.localizedDescription);
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
