//
//  LaunchStyleTwoController.m
//  APPSummary
//
//  Created by xubojoy on 2018/7/6.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "LaunchStyleTwoController.h"
#import "GYIntroductionView.h"
#import "CustomIntroductionCell.h"
@interface LaunchStyleTwoController ()<GYIntroductionDelegate, GYIntroductionDataSource, CustomIntroductionCellDelegate>

@property (nonatomic, strong) GYIntroductionView *introductionView;
@property (nonatomic, strong) NSArray *imgNames;

@end

@implementation LaunchStyleTwoController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // storyboard should delay 0.1s
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self example3];
    });
}


- (void)example0
{
    NSArray *imageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
    GYIntroductionView *introductionView = [[GYIntroductionView alloc] initWithImgNames:imageNames bgImgNames:nil];
    introductionView.pageControl.frame = CGRectMake(0, 0, 100, 50);
    [self.view addSubview:introductionView];
    _introductionView = introductionView;
    
    // enterButton and it's action
    // 进入按钮和进入按钮的回调
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterBtn.bounds = CGRectMake(0, 0, 200, 60);
    enterBtn.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.view.frame) - 160);
    enterBtn.backgroundColor = [UIColor redColor];
    [enterBtn setTitle:@"立即进入" forState:UIControlStateNormal];
    introductionView.enterButton = enterBtn;
    
    __weak typeof(self) weakSelf = self;
    [introductionView setEnterBlock:^{
        NSLog(@"点击进入");
        [weakSelf.introductionView removeFromSuperview];
        weakSelf.introductionView = nil;
    }];
    
}

- (void)example1
{
    NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
    NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
    
    GYIntroductionView *introductionView = [[GYIntroductionView alloc] initWithImgNames:coverImageNames bgImgNames:backgroundImageNames];
    [self.view addSubview:introductionView];
    _introductionView = introductionView;
    
    // enterButton and it's action
    // 进入按钮和进入按钮的回调
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterBtn.bounds = CGRectMake(0, 0, 200, 60);
    enterBtn.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.view.frame) - 160);
    enterBtn.backgroundColor = [UIColor redColor];
    [enterBtn setTitle:@"立即进入" forState:UIControlStateNormal];
    introductionView.enterButton = enterBtn;
    
    [introductionView setEnterBlock:^{
        NSLog(@"block 点击进入");
    }];
    
    introductionView.delegate = self;
}
// GYIntroductionDelegate
- (void)introductionViewDidClickEnterAction:(GYIntroductionView *)introductionView
{
    NSLog(@"代理回调 点击进入");
    
    [_introductionView removeFromSuperview];
    _introductionView = nil;
    
}
- (void)introductionView:(GYIntroductionView *)introductionView didClickPageIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", (int)indexPath.item);
}





- (void)example2
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"intro_video" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath:filePath];
    NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
    
    GYIntroductionView *introductionView = [[GYIntroductionView alloc] initWithVideoURL:videoURL volume:1 imgNames:coverImageNames];
    [self.view addSubview:introductionView];
    _introductionView = introductionView;
    
}


#pragma mark- example3
- (void)example3
{
    _imgNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
    
    GYIntroductionView *introductionView = [[GYIntroductionView alloc] initWithImgCount:_imgNames.count andDataSource:self];
    introductionView.pageControl.frame = CGRectMake(0, 0, 100, 50);
    
    // ⚠️⚠️DO NOT forget to register your cell with intrrolCollectionView⚠️⚠️
    [introductionView.introlCollectionView registerNib:[UINib nibWithNibName:@"CustomIntroductionCell" bundle:nil] forCellWithReuseIdentifier:@"CustomIntroductionCell"];
    
    [self.view addSubview:introductionView];
    _introductionView = introductionView;
    
    
}

// GYIntroductionDataSource
- (__kindof UICollectionViewCell *)introductionView:(GYIntroductionView *)introductionView cellForItemAtIndex:(NSIndexPath *)indexPath
{
    CustomIntroductionCell *cell = [introductionView.introlCollectionView dequeueReusableCellWithReuseIdentifier:@"CustomIntroductionCell" forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.item == _imgNames.count - 1) {
        // the last one
        cell.enter.hidden = NO;
    }else
    {
        cell.enter.hidden = YES;
    }
    
    cell.imgView.image = [UIImage imageNamed:_imgNames[indexPath.item]];
    return cell;
}

// CustomIntroductionCellDelegate
- (void)didClickSkip
{
    NSLog(@"点击跳过");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickEnter
{
    NSLog(@"点击进入");
    [self.navigationController popViewControllerAnimated:YES];
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
