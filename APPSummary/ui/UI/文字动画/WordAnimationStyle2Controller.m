//
//  WordAnimationStyle2Controller.m
//  APPSummary
//
//  Created by xubojoy on 2018/7/23.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "WordAnimationStyle2Controller.h"
#import "SPScrollNumLabel.h"
@interface WordAnimationStyle2Controller (){
    NSInteger _touchTag;
}
@property (weak, nonatomic) SPScrollNumLabel *scrollnumLabel;
@property (weak, nonatomic) SPScrollNumLabel *centerDetectLabel;
@property (weak, nonatomic) IBOutlet SPScrollNumLabel *testLabel;
@property (weak, nonatomic) IBOutlet SPScrollNumLabel *defaultLabel;

@end

@implementation WordAnimationStyle2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _touchTag = 0;
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    SPScrollNumLabel *num = [[SPScrollNumLabel alloc] initWithFrame:(CGRect){CGPointMake(screenBounds.size.width/2 - 50, 100),CGSizeMake(2, 100)}];
    
    // 设置frame时
    // 如果size属性的宽不能适应展示宽度，都会自动调整
    // 如果size属性的高度不能容纳展示高度，会自动调整，能容纳则不做任何处理
    // num.frame = (CGRect){CGPointMake(screenBounds.size.width/2 - 50, 100),CGSizeMake(2, 100)};
    
    // 字体属性，直接赋值
    num.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    num.font = [UIFont systemFontOfSize:40 weight:UIFontWeightBold];
    num.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.4];
    
    // 属性配置完成后，赋值 默认为0
    num.targetNumber = 512;
    
    // 如果采用center赋值 需要设置是否中心点优先
    SPScrollNumLabel *centerLabel = [[SPScrollNumLabel alloc] init];
    centerLabel.center = CGPointMake(screenBounds.size.width/2, 250);
    centerLabel.centerPointPriority = YES;
    centerLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    centerLabel.font = [UIFont systemFontOfSize:35 weight:UIFontWeightThin];
    centerLabel.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
    centerLabel.text = @"998";
    
    // 如果想当做普通的UILabel用 比如特殊值"1千"等 打开isCommonLabel 直接按照UILabel的使用即可
    SPScrollNumLabel *commonLabel = [[SPScrollNumLabel alloc] init];
    commonLabel.isCommonLabel = YES;
    commonLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    commonLabel.font = [UIFont systemFontOfSize:35 weight:UIFontWeightThin];
    commonLabel.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
    commonLabel.text = @"我可以当普通label用哦";
    [commonLabel sizeToFit];
    commonLabel.center = CGPointMake(screenBounds.size.width/2, commonLabel.frame.size.height/2+34);
    
    [self.view addSubview:num];
    [self.view addSubview:centerLabel];
    [self.view addSubview:commonLabel];
    self.scrollnumLabel = num;
    self.centerDetectLabel = centerLabel;
    
}
- (IBAction)increaseAction:(id)sender {
    [self.scrollnumLabel increaseNumber:3];
    [self.testLabel increaseNumber:1];
    [self.defaultLabel increaseNumber:1];
    [self.centerDetectLabel increaseNumber:1];
}

- (IBAction)decreaseAction:(id)sender {
    [self.scrollnumLabel decreaseNumber:1];
    [self.testLabel decreaseNumber:1];
    [self.defaultLabel decreaseNumber:1];
    [self.centerDetectLabel decreaseNumber:1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.scrollnumLabel.targetNumber = 404;
    self.defaultLabel.targetNumber = 400;
    self.centerDetectLabel.text = @"404";
    _touchTag += 1;
    if (_touchTag%2) {
        self.testLabel.text = @"我也是^(*￣(oo)￣)^";
    }else{
        self.testLabel.text = @"我是一段文字";
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
