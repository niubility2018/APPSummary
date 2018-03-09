//
//  FileLoadViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/3/1.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "FileLoadViewController.h"
#import "APPQuestionDetailController.h"
#import "PDFBrowserController.h"
@interface FileLoadViewController ()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation FileLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"本地HTML",@"本地DOC",@"本地PDF"];
    [self initTableView];
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
        return 0;
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, screen_width-30, 20)];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:font_15_size];
    [header addSubview:label];
    if (section == 0) {
        label.text = @"本地";
    }else{
        label.text = @"网络";
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                NSURL *urlStr = [[NSBundle mainBundle] URLForResource:@"consumer_finance_introduce.html" withExtension:nil];
                APPQuestionDetailController *appquestionvc = [[APPQuestionDetailController alloc] init];
                appquestionvc.urlStr = urlStr;
                [self.navigationController pushViewController:appquestionvc animated:YES];
            }
                break;
            case 1:
            {
                NSURL *urlStr = [[NSBundle mainBundle] URLForResource:@"consumer_finance_introduce.docx" withExtension:nil];
                APPQuestionDetailController *appquestionvc = [[APPQuestionDetailController alloc] init];
                appquestionvc.urlStr = urlStr;
                [self.navigationController pushViewController:appquestionvc animated:YES];
            }
                break;
            case 2:
            {
                PDFBrowserController *appquestionvc = [[PDFBrowserController alloc] init];
                [self.navigationController pushViewController:appquestionvc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }else{
        
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
