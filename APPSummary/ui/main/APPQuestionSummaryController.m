//
//  APPQuestionSummaryController.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/24.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "APPQuestionSummaryController.h"
#import "APPQuestionDetailController.h"
@interface APPQuestionSummaryController ()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation APPQuestionSummaryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"iOS开发中的八种锁(Lock)",@"如何设定线程池中线程的数目",@"如何用HTTP实现长连接"];
    [self initTableView];
}

- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

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
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, screen_width, 20)];
//    label.font = [UIFont systemFontOfSize:14];
//    [header addSubview:label];
//    if (section == 0) {
//        label.text = @"UI";
//    }else{
//        label.text = @"DATA";
//    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    NSString *str = self.dataArray[indexPath.row];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:str size:14];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
//http://xubojoy.cn/2018/02/26/%E5%A6%82%E4%BD%95%E8%AE%BE%E5%AE%9A%E7%BA%BF%E7%A8%8B%E6%B1%A0%E4%B8%AD%E7%BA%BF%E7%A8%8B%E7%9A%84%E6%95%B0%E7%9B%AE/#more
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *urlStr;
    switch (indexPath.row) {
        case 0:
            urlStr = @"http://xubojoy.cn/2018/02/24/iOS%E5%BC%80%E5%8F%91%E4%B8%AD%E7%9A%84%E5%85%AB%E7%A7%8D%E9%94%81-Lock/";
            break;
        case 1:
            urlStr = @"http://xubojoy.cn/2018/02/26/%E5%A6%82%E4%BD%95%E8%AE%BE%E5%AE%9A%E7%BA%BF%E7%A8%8B%E6%B1%A0%E4%B8%AD%E7%BA%BF%E7%A8%8B%E7%9A%84%E6%95%B0%E7%9B%AE/#more";
            break;
            
        case 2:
            urlStr = @"http://xubojoy.cn/2018/02/26/%E5%A6%82%E4%BD%95%E7%94%A8HTTP%E5%AE%9E%E7%8E%B0%E9%95%BF%E8%BF%9E%E6%8E%A5/#more";
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
