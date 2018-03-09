//
//  CommonLabelViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/3/8.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "CommonLabelViewController.h"
#import <TYAttributedLabel.h>
@interface CommonLabelViewController ()

@end

@implementation CommonLabelViewController

- (instancetype)initWithString:(NSString *)str{
    self = [super init];
    if (self) {
        self.str = str;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initLabel];
}

- (void)initLabel{
    TYAttributedLabel *label = [[TYAttributedLabel alloc] init];
    //    label.textContainer = container;
    [label setFrameWithOrign:CGPointMake(15, 64) Width:CGRectGetWidth(self.view.frame)-30];
    [self.view addSubview:label];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.str];
    [label setAttributedText:attrStr];
    [label setFont:[UIFont systemFontOfSize:18]];
    [label sizeToFit];
    CGSize labelSize = [label getSizeWithWidth:self.view.bounds.size.width-30];
    NSLog(@"----------%f------%f",labelSize.height,labelSize.width);

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
