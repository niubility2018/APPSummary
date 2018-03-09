//
//  DouDiZhuViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/3/1.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "DouDiZhuViewController.h"

@interface DouDiZhuViewController ()
@property (nonatomic, strong) NSMutableArray *resultArr;
@end

@implementation DouDiZhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *colorArr = @[@"黑",@"红",@"梅",@"方"];
    NSArray *numArr   = @[@"2",@"A",@"K",@"Q",@"J",@"10",@"9",@"8",@"7",@"6",@"5",@"4",@"3"];
    //组合54张牌，先是大小王
    NSMutableArray *allPokerArr = [NSMutableArray arrayWithArray:@[@"大王",@"小王"]];
    for (NSString *numStr in numArr) {//组合不同花色不同数字的牌
        for (NSString *colorStr in colorArr) {
            NSString *newStr = [colorStr stringByAppendingString:numStr];
            [allPokerArr addObject:newStr];
        }
    }
    //随机打乱这54张牌
    NSArray *mixArr = [allPokerArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [obj1 compare:obj2];
        } else {
            return [obj2 compare:obj1];
        }
    }];
    //取出其中的17张牌
    NSRange range = NSMakeRange(10, 17);
    NSArray *newArr = [mixArr subarrayWithRange:range];
    //排序这17张牌
    self.resultArr = [NSMutableArray arrayWithArray:allPokerArr];
    for (NSString *str in allPokerArr) {
        if (![newArr containsObject:str]) {//不包含则删除
            [self.resultArr removeObject:str];
        }
    }
    //    [self.resultArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        NSLog(@"---------遍历所有牌-------%@",obj);
    //    }];

    [self initLabel];
}

- (void)initLabel{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:font_15_size];
    label.numberOfLines = 0;
    
    label.text = [NSString stringWithFormat:@"%@",[self.resultArr componentsJoinedByString:@"\n"]];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(screen_width, screen_height));
    }];
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
