//
//  APPQuestionSummaryController.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/24.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "APPQuestionSummaryController.h"
#import "APPQuestionDetailController.h"
#import "CommonWebController.h"
#import "CommonLabelViewController.h"
#if DEBUG
// FLEX should only be compiled and used in debug builds.
#import <FLEX/FLEX.h>
#endif
@interface APPQuestionSummaryController ()
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *section2DataArray;
@end

@implementation APPQuestionSummaryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
#if DEBUG
    // This call shows the FLEX toolbar if it's not already shown.
    [[FLEXManager sharedManager] showExplorer];
#endif
    self.dataArray = @[@"iOS开发中的八种锁(Lock)",@"如何设定线程池中线程的数目",@"如何用HTTP实现长连接",@"线程安全以及nonatomic和atomic",@"KVC实现原理",@"KVO实现原理",@"说说你理解weak属性？"];
    self.section2DataArray = @[@"kvo与代理区别",@"isKindOfClass与isMumberOfClass的区别",@"NSArray与NSMutableArray 的区别"];
    [self initTableView];
    
    
//    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
//
//    //在这写入要计算时间的代码  __attribute__((unused)) 消除unused警告
    NSArray *array __attribute__((unused)) = @[@"a",@"d",@"f",@"g",@"t"];
//
//    //数组越界,但是不会crash
//    for (int i = 0; i < 100000; i++) {
//        NSLog(@"array >>> %@",[array objectAtIndex:i]);
//    }
//
//    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
//
//    NSLog(@"Linked in %f ms", linkTime *1000.0);
    
//   Linked in 2771.674991 ms   3019.006014 ms   3061.177015 ms  使用dispatch_once
//   Linked in 2307.027936 ms   2197.233915 ms   2268.103957 ms  不使用dispatch_once
    
    
}
//初始化tableview
- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDataSource-----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataArray.count;
    }else{
        return self.section2DataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [UITableViewCell new];
        cell.textLabel.text = self.dataArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:font_15_size];
        return cell;
    }else{
        UITableViewCell *cell = [UITableViewCell new];
        cell.textLabel.text = self.section2DataArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:font_15_size];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NSURL *urlStr;
        switch (indexPath.row) {
            case 0:
                urlStr = [NSURL URLWithString:@"http://xubojoy.cn/2018/02/24/iOS%E5%BC%80%E5%8F%91%E4%B8%AD%E7%9A%84%E5%85%AB%E7%A7%8D%E9%94%81-Lock/"];
                break;
            case 1:
                urlStr = [NSURL URLWithString:@"http://xubojoy.cn/2018/02/26/%E5%A6%82%E4%BD%95%E8%AE%BE%E5%AE%9A%E7%BA%BF%E7%A8%8B%E6%B1%A0%E4%B8%AD%E7%BA%BF%E7%A8%8B%E7%9A%84%E6%95%B0%E7%9B%AE/#more"];
                break;
                
            case 2:
                urlStr = [NSURL URLWithString:@"http://xubojoy.cn/2018/02/26/%E5%A6%82%E4%BD%95%E7%94%A8HTTP%E5%AE%9E%E7%8E%B0%E9%95%BF%E8%BF%9E%E6%8E%A5/#more"];
                break;
            case 3:
                urlStr = [NSURL URLWithString:@"http://xubojoy.cn/2018/03/05/%E7%BA%BF%E7%A8%8B%E5%AE%89%E5%85%A8%E4%BB%A5%E5%8F%8Anonatomic%E5%92%8Catomic/#more"];
                break;
            case 4:
                urlStr = [NSURL URLWithString:@"http://xubojoy.cn/2018/03/05/KVC%E5%AE%9E%E7%8E%B0%E5%8E%9F%E7%90%86/#more"];
                break;
            case 5:
                urlStr = [NSURL URLWithString:@"http://xubojoy.cn/2018/03/05/KVO%E5%AE%9E%E7%8E%B0%E5%8E%9F%E7%90%86/#more"];
                break;
            default:
                break;
        }
        //    AXWebViewController *webVC = [[AXWebViewController alloc] initWithAddress:urlStr];
        //    webVC.navigationType = AXWebViewControllerNavigationBarItem;
        //    webVC.showsToolBar = NO;
        //    webVC.navigationController.navigationBar.translucent = YES;
        //    [self.navigationController pushViewController:webVC animated:YES];
        APPQuestionDetailController *appquestionvc = [[APPQuestionDetailController alloc] init];
        appquestionvc.urlStr = urlStr;
        [self.navigationController pushViewController:appquestionvc animated:YES];
    }else{
        NSString *str;
        switch (indexPath.row) {
            case 0:
                str = @"代理是一种回调机制，是一对一的关系，二通知是一对多的关系，一个中心对象向多个观察者提供变更通知，KVO是被观察者向观察者直接发送通知，这是代理、通知、KVO的直观区别。";
                break;
            case 1:
                str = @"共同点：\nisKindOfClass与isMemberOfClass都是NSObject中比较Class的方法。\n不同点：\n1.isKindOfClass用来判断某个对象是否属于某个类，或者是属于某个派生类。\n2.isMemberOfClass 用来判断某个对象是否为当前类的实例。";
                break;
            case 2:
                str = @"NSArray 创建的是静态数组，一旦创建之后，就再也不能添加和删除数组中的对象了。\nNSMutableArray 是 NSArray 补充类。NSMutalbeArray 创建的是动态数组，可随意添加或删除数组中的元素。";
                break;
                
            default:
                break;
        }
        CommonLabelViewController *commonLabelvc = [[CommonLabelViewController alloc] initWithString:str];
        [self.navigationController pushViewController:commonLabelvc animated:YES];
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
