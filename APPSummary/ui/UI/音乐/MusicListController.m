//
//  MusicListController.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/26.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "MusicListController.h"
#import "QQMusicOperationTool.h"
#import "MusicListCell.h"
#import "QQMusicModel.h"
@interface MusicListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *musicModelArray;

@end
@implementation MusicListController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    NSLog(@"------信息-------------%@",QQMusicOperationTool.shareInstance.musicMList);
    [self initTableView];
}

- (void)loadData{
    self.musicModelArray = [NSMutableArray new];
    if (QQMusicOperationTool.shareInstance.musicMList.count > 0) {
        [self.musicModelArray addObjectsFromArray:QQMusicOperationTool.shareInstance.musicMList];
    }
    [self.tableView reloadData];
}

//初始化tableview
- (void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDataSource-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musicModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicListCell *cell = [MusicListCell cellWithTableView:tableView andCellStyle:UITableViewCellStyleDefault];
    if (self.musicModelArray.count > 0) {
        QQMusicModel *model = self.musicModelArray[indexPath.row];
        NSLog(@"------model-------------%@",model);
        [cell renderMusicListCell:model];
    }
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
//    return header;
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
