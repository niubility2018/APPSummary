//
//  ClockDrawViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/3/7.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "ClockDrawViewController.h"
#import "Clock.h"
#import "ClockView.h"

#define CLOCK_VIEW_MAX_COUNT 10
#define CLOCK_VIEW_TIME_DELAY 3.0
#define RANDOM_ENABLED 1
@interface ClockDrawViewController ()
{
    NSMutableArray *_clockViews;
    dispatch_source_t _timer;
}
@end

@implementation ClockDrawViewController


- (void)dealloc
{
    if (NULL != _timer) {
        dispatch_source_cancel(_timer);
    }
}

//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

- (void)_addClockView
{
    if (!_clockViews) {
        _clockViews = [NSMutableArray array];
    }
    //  arc4random_uniform(kClockViewStyleDark+1)
    ClockView *clockView = [[ClockView alloc] initWithClock:[Clock clock] style:kClockViewStyleLight];
    [_clockViews addObject:clockView];
    [self.view addSubview:clockView];
    
    clockView.bounds = CGRectMake(0, 0, 132, 132);
    
    CGRect contentBounds = self.view.bounds;
    //#if RANDOM_ENABLED
    //  clockView.center = CGPointMake(arc4random_uniform(contentBounds.size.width), arc4random_uniform(contentBounds.size.height));
    //#else
    clockView.center = CGPointMake(contentBounds.size.width / 2., contentBounds.size.height / 2.);
    //#endif
}

- (void)_removeClockView
{
    if (0 == _clockViews.count) {
        return;
    }
    
    [_clockViews[0] removeFromSuperview];
    [_clockViews removeObjectAtIndex:0];
}

- (void)_removeAddClockView
{
    [self _removeClockView];
    [self _addClockView];
}

- (void)_scheduleTimer
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, CLOCK_VIEW_TIME_DELAY * NSEC_PER_SEC), CLOCK_VIEW_TIME_DELAY * NSEC_PER_SEC, 1.0);
    
    __weak id weakSelf = self;
    dispatch_source_set_event_handler(timer, ^{
        [weakSelf _removeAddClockView];
    });
    
    _timer = timer;
#if RANDOM_ENABLED
    dispatch_resume(timer);
#endif
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    //  while (_clockViews.count < CLOCK_VIEW_MAX_COUNT) {
    [self _addClockView];
    //  }
    
    //  [self _scheduleTimer];
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
