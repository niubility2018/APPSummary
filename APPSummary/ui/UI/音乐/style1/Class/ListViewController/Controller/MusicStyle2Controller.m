//
//  MusicStyle2Controller.m
//  APPSummary
//
//  Created by xubojoy on 2018/7/9.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "MusicStyle2Controller.h"
#import "LZPlyerTableViewCell.h"
#import "LZPlayerModel.h"
#import "LZMusicDetailVIewController.h"
#define kMusicUrl @"http://mobile.ximalaya.com/mobile/others/ca/album/track/5541/true/1/15"

@interface MusicStyle2Controller ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *musicTableVIew;
@property(nonatomic,strong) NSMutableArray *totalSongArr;
@property (nonatomic, strong)VTMagicController  *magicController;

@end

@implementation MusicStyle2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.totalSongArr         = [NSMutableArray array];
    self.navigationItem.title = @"LZMusicPlayerDemo";
    [LZSignSongIdSimple lzSignSongIdSimple].songID = @"";
    [LZPlayerBottomView lzPlayerBottomView].reloadBlock = ^{
        [self.musicTableVIew reloadData];//刷新当前播放歌曲songName和songerName字体的颜色
    };
    //添加UI
    [self createUI];
    NSArray *tempArr = LZUserDefaultsGET(SONGLIST);
    if (tempArr.count) {
        [self savedata:tempArr];
    }
    [self initdata];
    
    //添加底部菜单
    [self addBottomVIew];
}
-(void)createUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.musicTableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, LZSCREENW, LZSCREENH-65-64)];
    self.musicTableVIew.delegate = self;
    self.musicTableVIew.dataSource = self;
    self.musicTableVIew.tableFooterView = [UIView new];
    [self.view addSubview:self.musicTableVIew];
    [self.musicTableVIew registerNib:[UINib nibWithNibName:@"LZPlyerTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LZPLAYERCELL"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.totalSongArr.count) {
        return self.totalSongArr.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LZPlyerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZPLAYERCELL"];
    if (!cell) {
        cell = [[LZPlyerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LZPLAYERCELL"];
    }
    cell.model = self.totalSongArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [LZPlayerManager lzPlayerManager].index = indexPath.row;
    [LZPlayerBottomView lzPlayerBottomView].isSongPlayer = YES;//修改按钮的图片
    [[LZPlayerBottomView lzPlayerBottomView] reloadDataWithIndex: [LZPlayerManager lzPlayerManager].index];
    
    
}
-(void)initdata{
    [LZNetWorking sendPostNetWorkWithUrl:kMusicUrl parameters:nil successBlock:^(id data) {
        NSArray *array = data[@"tracks"][@"list"];
        if (array.count) {
            LZUserDefaultsSET(array, SONGLIST);
            LZUserDefaultsSynchronize;
            [self savedata:array];
        }
    } failureBlock:^(NSString *error) {
        
    }];
}
-(void)savedata:(NSArray *)array{
    [self.totalSongArr removeAllObjects];
    self.totalSongArr = [LZPlayerModel mj_objectArrayWithKeyValuesArray:array];
    [LZPlayerManager lzPlayerManager].musicArray = self.totalSongArr;
    [self.musicTableVIew reloadData];
}


#pragma mark 添加底部菜单
-(void)addBottomVIew{
    
    LZPlayerBottomView *bottomVIew = [LZPlayerBottomView lzPlayerBottomView];
    [self.view addSubview:bottomVIew];
    [bottomVIew.jumpBtn addTarget:self action:@selector(jumpBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)jumpBtnClicked{
    
    if ( [LZPlayerManager lzPlayerManager].isPlay) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Music" bundle:nil];
        LZMusicDetailVIewController *detail = [storyBoard instantiateViewControllerWithIdentifier:@"LZMusicDetailVIewController"];
        [self presentViewController:detail animated:YES completion:nil];
    }
}
-(BOOL)shouldAutorotate{
    return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
    
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

-(UIBarButtonItem*) createBackButton
{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 24, 24);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    return   [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}
-(void)popself{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super.navigationController pushViewController:viewController animated:animated];
    //    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
    //        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
    //    }
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
