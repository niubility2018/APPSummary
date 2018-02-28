//
//  PDFBrowserController.m
//  APPSummary
//
//  Created by qiuyu on 2018/2/28.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "PDFBrowserController.h"
#import "DrawPDFViewController.h"

@interface PDFBrowserController ()<UIPageViewControllerDataSource>{
    NSArray *pdfArr;
    ///第几个
    NSInteger index;
    //显示的第几页了
    NSInteger currentPage;
}

@end

@implementation PDFBrowserController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *got = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    got.backgroundColor = [UIColor blackColor];
    [got setTitle:@"开始浏览" forState:UIControlStateNormal];
    [got addTarget:self action:@selector(gotoPdfMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:got];
    
    pdfArr = @[@"design-model.pdf",@"PDF1.pdf",@"PDF2.pdf"];
}
-(void)gotoPdfMethod
{
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                       forKey: UIPageViewControllerOptionSpineLocationKey];
    //翻页效果
    UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                                           navigationOrientation:UIPageViewControllerNavigationOrientationVertical
                                                                                         options:options];
    pageController.dataSource = self;
    
    currentPage=1;
    DrawPDFViewController *pdfController = [self getViewControllerWithPage:currentPage];
    
    NSArray *viewControllers =[NSArray arrayWithObject:pdfController];
    //翻页效果
    [pageController setViewControllers:viewControllers
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:NO
                            completion:nil];
    
    [self.navigationController pushViewController:pageController animated:YES];
    
}
#pragma mark 获取到第page页的内容
- (DrawPDFViewController *)getViewControllerWithPage:(NSInteger)page
{
    //计算全部数量
    NSInteger allSum =[self countSumWith:pdfArr.count];
    BOOL isShow = [self caculateMethod];
    NSLog(@"%d",isShow);
    NSString *pdfName=pdfArr[index];
    CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), (__bridge CFStringRef)pdfName, NULL, NULL);
    CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
    CFRelease(pdfURL);
    
    NSInteger beforSum = 0;
    if (index>0) {
        beforSum= [self countSumWith:index];
        NSLog(@"前几个的和是%lu",beforSum);
    }
    //实际的
    NSInteger actureIndex = currentPage-beforSum;
    DrawPDFViewController *pdfController = [[DrawPDFViewController alloc] initWithPage:actureIndex withPDFDoc:pdfDocument WithSum:allSum WithShowIndex:currentPage];
    
    return pdfController;
}
#pragma - mark UIPageViewControllerDataSource
//翻到上一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    currentPage--;
    if ([self caculateMethod]) {
        return [self getViewControllerWithPage:currentPage];
    }
    else
    {
        currentPage++;
        return nil;
    }
}
//翻到下一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    currentPage++;
    if ([self caculateMethod]) {
        return [self getViewControllerWithPage:currentPage];
    }
    else
    {
        currentPage--;
        return nil;
    }
}
//计算到达第几个了
-(BOOL)caculateMethod
{
    //计算全部数量
    NSInteger allSum =0;
    index=0;
    // 当前显示的页数是否到下限
    BOOL low=NO;
    // 当前显示的页数是否到上限
    BOOL high =NO;
    if (currentPage<1) {
        return NO;
    }
    for (NSInteger i=0; i<pdfArr.count; i++) {
        NSString *filename = pdfArr[i];
        CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), (__bridge CFStringRef)filename, NULL, NULL);
        CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
        CFRelease(pdfURL);
        NSInteger indexSum = CGPDFDocumentGetNumberOfPages(pdfDocument);
        allSum = allSum+indexSum;
        NSInteger firstNum = [self countSumWith:0];
        if (currentPage<=firstNum) {
            index= 0;
            return YES;
        }
        if (currentPage>allSum) {
            low = YES;
        }
        if (currentPage<=allSum) {
            high = YES;
        }
        if (low && high) {
            index = i;
            NSLog(@"第%lu个pdf了",index);
            return YES;
        }
    }
    if (currentPage>allSum) {
        return NO;
    }
    return NO;
}
//计算前index个对象的总数
-(NSInteger)countSumWith:(NSInteger)indexNum
{
    NSMutableArray *pdfMutable = [NSMutableArray new];
    if (indexNum>0) {
        for (int i =0; i<indexNum; i++) {
            id Obj = pdfArr[i];
            [pdfMutable addObject:Obj];
        }
    }
    else
    {
        [pdfMutable addObject:pdfArr[0]];
    }
    //计算全部数量
    NSInteger allSum =0;
    for (NSInteger i=0; i<pdfMutable.count; i++) {
        NSString *filename = pdfMutable[i];
        CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), (__bridge CFStringRef)filename, NULL, NULL);
        CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
        CFRelease(pdfURL);
        NSInteger indexSum = CGPDFDocumentGetNumberOfPages(pdfDocument);
        allSum = allSum+indexSum;
    }
    return allSum;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
