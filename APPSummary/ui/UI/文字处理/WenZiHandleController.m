//
//  WenZiHandleController.m
//  APPSummary
//
//  Created by xubojoy on 2018/4/24.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "WenZiHandleController.h"
#import <YYText/YYText.h>
#import "UIView+YYAdd.h"
#import <CoreText/CoreText.h>
@interface WenZiHandleController ()
{
    NSMutableArray *labels;
    NSMutableArray *numArr;
    NSMutableArray *dataArr;
}
@property (nonatomic, strong) YYTextView *textView;
@end

@implementation WenZiHandleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self initYYtextLabel];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(100, 64, 100, 50);
    startBtn.backgroundColor = [UIColor orangeColor];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
}


- (void)buttonClick:(id)sender {
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(10, 100, screen_width-20, 300)];
    vi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vi];
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = vi.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [vi.layer addSublayer:textLayer];
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont fontWithName:@"EuphemiaUCAS-Bold" size:18];
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        
        printf( "Family: %s \n", [familyName UTF8String] );
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
    
    NSString *str = @"还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月,还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月还是月西江更有意境:日暮江水远,入夜随风迁,秋叶乱水月...";
    
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:str];
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor whiteColor].CGColor,
                              (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
                              };
    [string setAttributes:attribs range:NSMakeRange(0, str.length)];
    
    dataArr = [NSMutableArray arrayWithObjects:(__bridge id _Nonnull)(fontRef),attribs,string,str,textLayer, nil];
    numArr = [NSMutableArray array];
    for (int i = 0; i < str.length; i++) {
        [numArr addObject:[NSNumber numberWithInt:i]];
        [self performSelector:@selector(changeToBlack) withObject:nil afterDelay:0.1 * i];
    }
    CFRelease(fontRef);
    
}

- (void)changeToBlack {
    CTFontRef fontRef = (__bridge CTFontRef)(dataArr[0]);
    NSMutableAttributedString *string = dataArr[2];
    NSNumber *num = [numArr firstObject];
    int y = [num intValue];
    NSDictionary *attribs = dataArr[1];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
                (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(y, 1)];
    if (numArr.count > 1) {
        [numArr removeObjectAtIndex:0];
    }
    CATextLayer *textLayer = [dataArr lastObject];
    textLayer.string = string;
}


- (void)initYYtextLabel{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the season of light, it was the season of darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us. We were all going direct to heaven, we were all going direct the other way.\n\n这是最好的时代，这是最坏的时代；这是智慧的时代，这是愚蠢的时代；这是信仰的时期，这是怀疑的时期；这是光明的季节，这是黑暗的季节；这是希望之春，这是失望之冬；人们面前有着各样事物，人们面前一无所有；人们正在直登天堂，人们正在直下地狱。"];
    text.yy_font = [UIFont fontWithName:@"Times New Roman" size:20];
    text.yy_lineSpacing = 4;
    text.yy_firstLineHeadIndent = 20;
    
    YYTextView *textView = [YYTextView new];
    textView.attributedText = text;
    textView.size = CGSizeMake(screen_width, screen_height);
    textView.textContainerInset = UIEdgeInsetsMake(15, 0, 64+15, 15);
    textView.verticalForm = YES;
    textView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:textView];
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
