//
//  AIViewController.m
//  RuntimeTest
//
//  Created by xubojoy on 2018/2/23.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "AIViewController.h"
#import "DLabelViewController.h"
#import "BarrageViewController.h"
@interface AIViewController ()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation AIViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"3D标签云",@"弹幕护体"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:font_15_size];
    return cell;
}

#pragma mark - UITableViewDelegate------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, screen_width-30, 20)];
//    label.textAlignment = NSTextAlignmentLeft;
//    label.font = [UIFont systemFontOfSize:font_15_size];
//    [header addSubview:label];
//    if (section == 0) {
//        label.text = @"本地";
//    }else{
//        label.text = @"网络";
//    }
//    return header;
    return nil;
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
                DLabelViewController *dvc = [[DLabelViewController alloc] init];
                [self.navigationController pushViewController:dvc animated:YES];
            }
                break;
            case 1:
            {
                BarrageViewController *dvc = [[BarrageViewController alloc] init];
                [self.navigationController pushViewController:dvc animated:YES];
            }
                break;
            case 2:
            {
//                PDFBrowserController *appquestionvc = [[PDFBrowserController alloc] init];
//                [self.navigationController pushViewController:appquestionvc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }else{
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
