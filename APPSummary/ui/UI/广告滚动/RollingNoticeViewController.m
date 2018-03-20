//
//  RollingNoticeViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/3/20.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "RollingNoticeViewController.h"
#import "JGRollingNoticeView.h"
#import "JGCustomNoticeCell.h"
#import "CustomNoticeCell.h"
@interface RollingNoticeViewController ()<JGRollingNoticeViewDataSource, JGRollingNoticeViewDelegate>
{
    NSArray *_arr;
    NSMutableArray *_muArr;
    NSArray *_arr1;
    NSArray *_arr2;
    
    JGRollingNoticeView *_noticeView0;
    JGRollingNoticeView *_noticeView1;
    JGRollingNoticeView *_noticeView2;
    
}

@end

@implementation RollingNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, screen_width - 20, 100)];
    lab.numberOfLines = 0;
    lab.text = @"\t滚动公告、广告，支持自定义View，模仿淘宝头条等等。";
    [self.view addSubview:lab];
    
    
    
    _arr = @[
             @{@"img": @"tb_icon2",@"name": @"一名", @"time": @"还差1人拼成\n剩余21:12:11:8"},
             @{@"img": @"tb_icon3",@"name": @"二名", @"time": @"还差22人拼成\n剩余21:12:11:8"},
             @{@"img": @"tb_icon2",@"name": @"三名", @"time": @"还差23人拼成\n剩余21:12:11:8"},
             @{@"img": @"tb_icon2",@"name": @"四名", @"time": @"还差14人拼成\n剩余21:12:11:8"},
             @{@"img": @"tb_icon5",@"name": @"五名", @"time": @"还差7人拼成\n剩余21:12:11:8"},
             @{@"img": @"tb_icon7",@"name": @"六名", @"time": @"还差11人拼成\n剩余21:12:11:8"},
             @{@"img": @"tb_icon2",@"name": @"七名", @"time": @"还差23人拼成\n剩余21:12:11:8"},
             @{@"img": @"tb_icon2",@"name": @"八名", @"time": @"还差14人拼成\n剩余21:12:11:8"},
             @{@"img": @"tb_icon5",@"name": @"九名", @"time": @"还差7人拼成\n剩余21:12:11:8"}
             //              ,
             //              @{@"img": @"tb_icon7",@"name": @"十名", @"time": @"还差11人拼成\n剩余21:12:11:8"}
             ];
    _muArr = [NSMutableArray arrayWithArray:_arr];
    if (_arr.count % 2 == 1) {
        for (NSDictionary *dict in _arr) {
            [_muArr addObject:dict];
            
        }
    }
    
    
    _arr1 = @[@"小米千元全面屏：抱歉，久等！625献上",
              @"可怜狗狗被抛弃，苦苦等候主人半年",
              @"三星中端新机改名，全面屏火力全开",
              @"学会这些，这5种花不用去花店买了",
              @"华为nova2S发布，剧透了荣耀10？"
              ];
    
    
    _arr2 = @[
              @{@"arr": @[@{@"tag": @"手机", @"title": @"小米千元全面屏：抱歉，久等！625献上"}, @{@"tag": @"萌宠", @"title": @"可怜狗狗被抛弃，苦苦等候主人半年"}], @"img": @"tb_icon2"},
              @{@"arr": @[@{@"tag": @"手机", @"title": @"三星中端新机改名，全面屏火力全开"}, @{@"tag": @"围观", @"title": @"主人假装离去，狗狗直接把孩子推回去了"}], @"img": @"tb_icon3"},
              @{@"arr": @[@{@"tag": @"园艺", @"title": @"学会这些，这5种花不用去花店买了"}, @{@"tag": @"手机", @"title": @"华为nova2S发布，剧透了荣耀10？"}], @"img": @"tb_icon5"},
              @{@"arr": @[@{@"tag": @"开发", @"title": @"iOS 内购最新讲解"}, @{@"tag": @"博客", @"title": @"技术博客那些事儿"}], @"img": @"tb_icon6"},
              @{@"arr": @[@{@"tag": @"招聘", @"title": @"招聘XX高级开发工程师"}, @{@"tag": @"资讯", @"title": @"如何写一篇好的技术博客"}], @"img": @"tb_icon7"}
              ];

    
    [self creatRollingViewWithArray:_muArr index:0];
    [self creatRollingViewWithArray:_arr1 index:1];
    [self creatRollingViewWithArray:_arr2 index:2];
}

// 请在合适的时机 销毁timer
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_noticeView0.timer invalidate];
    [_noticeView1.timer invalidate];
}


- (void)creatRollingViewWithArray:(NSArray *)arr index:(int)index
{
    float w = [[UIScreen mainScreen] bounds].size.width;
    CGRect frame = CGRectZero;
    if (index == 0) {
        
        if (_muArr.count == 1) {
            frame = CGRectMake(0, 200, w, 60);
        }else {
            frame = CGRectMake(0, 200, w, 120);
        }
    }else if (index == 1) {
        frame = CGRectMake(0, 350, w, 30);
    }else{
        frame = CGRectMake(0, 400, w, 50);
    }
    
    JGRollingNoticeView *noticeView = [[JGRollingNoticeView alloc]initWithFrame:frame];
    noticeView.dataSource = self;
    noticeView.delegate = self;
    [self.view addSubview:noticeView];
    noticeView.backgroundColor = [UIColor lightGrayColor];
    
    
    if (index == 0) {
        _noticeView0 = noticeView;
        [noticeView registerClass:[JGCustomNoticeCell class] forCellReuseIdentifier:@"JGCustomNoticeCell"];
        
        
    }else if(index == 1){
        _noticeView1 = noticeView;
        [noticeView registerClass:[JGNoticeViewCell class] forCellReuseIdentifier:@"JGNoticeViewCell"];
    }else{
        _noticeView2 = noticeView;
        [noticeView registerNib:[UINib nibWithNibName:@"CustomNoticeCell" bundle:nil] forCellReuseIdentifier:@"CustomNoticeCell"];
    }
    
    [noticeView beginScroll];
}



- (NSInteger)numberOfRowsForRollingNoticeView:(JGRollingNoticeView *)rollingView
{
    if (rollingView == _noticeView0) {
        if (_muArr.count == 1) return 1;
        if ((_muArr.count % 2) == 1) {
            return (_muArr.count / 2) + 1;
        }
        return _muArr.count / 2;
    }else if (rollingView == _noticeView1) {
        return _arr1.count;
    }else{
        return _arr2.count;
    }
    
    return 0;
}

- (__kindof JGNoticeViewCell *)rollingNoticeView:(JGRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index
{
    if (rollingView == _noticeView0) {
        JGCustomNoticeCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"JGCustomNoticeCell"];
        [cell noticeCellWithArr:_muArr forIndex:index];
        return cell;
    }
    
    //     普通用法，只有一行label滚动显示文字
    //     normal use, only one line label rolling
   else if (rollingView == _noticeView1) {
        JGNoticeViewCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"JGNoticeViewCell"];
        cell.textLabel.text = _arr1[index];
        cell.contentView.backgroundColor = [UIColor orangeColor];
        if (index % 2 == 0) {
            cell.contentView.backgroundColor = [UIColor greenColor];
        }
        return cell;
    }else{
        CustomNoticeCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"CustomNoticeCell"];
        [cell noticeCellWithArr:_arr2 forIndex:index];
        return cell;
    }
    
    
    return nil;
}

- (void)didClickRollingNoticeView:(JGRollingNoticeView *)rollingView forIndex:(NSUInteger)index
{
    NSLog(@"点击的index: %ld", index);
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
