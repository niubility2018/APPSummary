//
//  3DLabelViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/3/6.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "DLabelViewController.h"
#import "AISphereView.h"
@interface DLabelViewController ()<AISphereViewDelegate>

@property (nonatomic, strong) AISphereView *sphereView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSMutableArray *stack;

@end

@implementation DLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.sphereView];
    
    NSUInteger i = 3 + arc4random() % 10;
    NSMutableArray *views = [NSMutableArray new];
    for (NSUInteger j = 0; j < i; j ++) {
        [views addObject:[self itemViewAtIndex:j]];
    }
    [self.sphereView pushToCenter:[self sphereCenterView] withItems:views];
    
    [self.view addSubview:self.button];
    self.button.translatesAutoresizingMaskIntoConstraints = false;
    if (@available(iOS 9.0, *)) {
        [self.button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 9.0, *)) {
        [self.button.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:64].active = true;
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 9.0, *)) {
        [self.button.heightAnchor constraintEqualToConstant:44].active = true;
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 9.0, *)) {
        [self.button.widthAnchor constraintEqualToConstant:100].active = true;
    } else {
        // Fallback on earlier versions
    }
}

- (AISphereView *)sphereView {
    if (!_sphereView) {
        _sphereView = [[AISphereView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width)];
        _sphereView.delegate = self;
        _sphereView.lineColor = [UIColor greenColor];
    }
    return _sphereView;
}

- (UIView *)sphereCenterView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 76, 76)];
    view.backgroundColor = [UIColor blueColor];
    view.layer.cornerRadius = 38;
    return view;
}

- (UIView *)itemViewAtIndex:(NSUInteger)index {
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor colorWithRed:arc4random()%255 / 255.0 green:arc4random()%255 / 255.0 blue:arc4random()%255 / 255.0 alpha:1];
    view.layer.cornerRadius = 50;
    view.clipsToBounds = true;
    view.text = @(index).stringValue;
    return view;
}

#pragma mark - SphereView delegate

- (void)sphereView:(AISphereView *)sphereView didSelectItem:(UIView *)view {
    NSUInteger i = 3 + arc4random() % 10;
    NSMutableArray *views = [NSMutableArray new];
    for (NSUInteger j = 0; j < i; j ++) {
        [views addObject:[self itemViewAtIndex:j]];
    }
    [self.stack addObject:@(self.sphereView.items.count)];
    [self.sphereView pushToCenter:view withItems:views];
}

- (void)sphereView:(AISphereView *)sphereView pushAnimationCompletion:(BOOL)finished {
}

- (void)sphereView:(AISphereView *)sphereView popAnimationCompletion:(BOOL)finished {
    [self.stack removeLastObject];
    //    self.button.userInteractionEnabled = sphereView.stackDepth > 0;
    [self.button setTitle:sphereView.stackDepth > 0 ? @"isInTop" : @"Back" forState:UIControlStateNormal];
}

#pragma mark -

- (void)buttonAction:(id)sender {
    NSUInteger i = [self.stack.lastObject unsignedIntegerValue];
    NSMutableArray *views = [NSMutableArray new];
    for (NSUInteger j = 0; j < i; j ++) {
        UIView *view = [self itemViewAtIndex:j];
        [views addObject:view];
    }
    [self.sphereView popToCenter:[self sphereCenterView] withItems:views];
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitle:@"Back" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _button;
}

- (NSMutableArray *)stack {
    if (!_stack) {
        _stack = [[NSMutableArray alloc] init];
    }
    return _stack;
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
