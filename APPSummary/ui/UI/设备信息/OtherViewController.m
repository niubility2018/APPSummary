//
//  OtherViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/7/2.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "OtherViewController.h"
#import "OtherDetailViewController.h"
@interface OtherViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSArray *nameArray;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.nameArray = @[@"Hardware Info", @"Battery Info", @"IP&& Address", @"CPU Info", @"Disk && Memory"];
    self.typeArray = @[@(BasicInfoTypeHardWare),@(BasicInfoTypeBattery),@(BasicInfoTypeIpAddress),@(BasicInfoTypeCPU),@(BasicInfoTypeDisk)];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = self.nameArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger type = [self.typeArray[indexPath.row] integerValue];
//    NSLog(@"=========type=======%ld",i);
    [self _pushVCWithType:type textStr:self.nameArray[indexPath.row]];
}

- (void)_pushVCWithType:(BasicInfoType)type textStr:(NSString *)textStr {
    OtherDetailViewController *basicVC = [[OtherDetailViewController alloc] initWithType:type];
    basicVC.navigationItem.title = textStr;
    [self.navigationController pushViewController:basicVC  animated:YES];
}

#pragma mark - LazyLoading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight = 60;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
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
