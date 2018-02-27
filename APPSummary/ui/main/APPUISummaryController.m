//
//  APPUISummaryController.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/24.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "APPUISummaryController.h"
#import "AIViewController.h"
#import "LaunchImageController.h"
#import "FaceIDViewController.h"
#import "GPUImageViewController.h"
#import "CountDownViewController.h"
#import "DrawViewController.h"
#import "WIFICheckViewController.h"
#import "TouchIDViewController.h"
#import "QQTmpChatViewController.h"
#import "DateCalendarController.h"
#import "PopViewController.h"


@interface APPUISummaryController ()
@property (nonatomic, strong) NSArray *dataUIArray;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation APPUISummaryController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    [self.navigationController setNavigationBarHidden:NO];
    //    启用大标题显示
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataUIArray = @[@"启动引导页动画",@"标签云",@"人脸识别",@"image处理",@"倒计时",@"画板",@"wifi认证",@"指纹识别",@"QQ临时会话",@"弹出视图",@"音乐"
                         ];
    self.dataArray = @[@"时间计算"
                       ];
    [self initTableView];
    [self initSearch];
}

- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
}
//搜索新特性
- (void)initSearch{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.placeholder = @"搜索";
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    [self.searchController.searchBar sizeToFit];
    //    self.tableView.tableHeaderView = self.searchController.searchBar;
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchController;
    } else {
        //         Fallback on earlier versions
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataUIArray.count;
    }else{
        return self.dataArray.count;
    }
    
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, screen_width, 20)];
    label.font = [UIFont systemFontOfSize:14];
    [header addSubview:label];
    if (section == 0) {
        label.text = @"UI";
    }else{
        label.text = @"DATA";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    if (indexPath.section == 0) {
        NSString *str = self.dataUIArray[indexPath.row];
        cell.textLabel.text = self.dataUIArray[indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:str size:16];
    }else{
        NSString *str = self.dataArray[indexPath.row];
        cell.textLabel.text = self.dataArray[indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:str size:16];
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0) {
        switch (indexPath.row) {
            case 0:
            {
                LaunchImageController *lanuvc = [[LaunchImageController alloc] init];
                lanuvc.showLaunchAnimation = YES;
                [self.navigationController pushViewController:lanuvc animated:YES];
            }
                break;
            case 1:
            {
                AIViewController *aivc = [[AIViewController alloc] init];
                [self.navigationController pushViewController:aivc animated:YES];
            }
                break;
                
            case 2:
            {
                FaceIDViewController *facevc = [[FaceIDViewController alloc] init];
                [self.navigationController pushViewController:facevc animated:YES];
            }
                break;
            case 3:
            {
                GPUImageViewController *gpuvc = [[GPUImageViewController alloc] init];
                [self.navigationController pushViewController:gpuvc animated:YES];
            }
                break;
            case 4:
            {
                CountDownViewController *countvc = [[CountDownViewController alloc] init];
                [self.navigationController pushViewController:countvc animated:YES];
            }
                break;
                
            case 5:
            {
                DrawViewController *drawvc = [[DrawViewController alloc] init];
                [self.navigationController pushViewController:drawvc animated:YES];
            }
                break;
                
            case 6:
            {
                WIFICheckViewController *wifivc = [[WIFICheckViewController alloc] init];
                [self.navigationController pushViewController:wifivc animated:YES];
            }
                break;
                
            case 7:
            {
                TouchIDViewController *touchIDvc = [[TouchIDViewController alloc] init];
                [self.navigationController pushViewController:touchIDvc animated:YES];
            }
                break;
            case 8:
            {
                QQTmpChatViewController *qqtmpvc = [[QQTmpChatViewController alloc] init];
                [self.navigationController pushViewController:qqtmpvc animated:YES];
            }
                break;
            case 9:
            {
                PopViewController *popvc = [[PopViewController alloc] init];
                [self.navigationController pushViewController:popvc animated:YES];
            }
                break;
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            {
                DateCalendarController *datevc = [[DateCalendarController alloc] init];
                [self.navigationController pushViewController:datevc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    启用大标题显示
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
    } else {
        // Fallback on earlier versions
    }
}

@end
