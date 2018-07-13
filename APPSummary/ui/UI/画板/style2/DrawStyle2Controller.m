//
//  DrawStyle2Controller.m
//  APPSummary
//
//  Created by xubojoy on 2018/7/13.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "DrawStyle2Controller.h"
//#import "DrawView.h" 此方法会引起内存暴增
#import "BHBDrawBoarderView.h"
@interface DrawStyle2Controller ()
//@property (nonatomic, strong) DrawView *drawView;
@property (nonatomic,strong) BHBDrawBoarderView * bv;
@end

@implementation DrawStyle2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self initDrawView];
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.backgroundColor = [UIColor brownColor];
    [startBtn setTitle:@"弹出画板" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(popDrawView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
}
//- (void)initDrawView{
//    _drawView = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
//    _drawView.backgroundColor = [UIColor whiteColor];
//    _drawView.lineWidth = 5;
//    _drawView.lineColor = [UIColor blackColor];
//    [self.view addSubview:_drawView];
//}

- (void)popDrawView:(id)sender {
    self.bv = [[BHBDrawBoarderView alloc] initWithFrame:CGRectZero];
    //    self.bv.linesInfo = @[];
    //    self.bv.canceledLinesInfo = @[];
    self.bv.backgroundColor = [UIColor whiteColor];
    [self.bv show];
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
