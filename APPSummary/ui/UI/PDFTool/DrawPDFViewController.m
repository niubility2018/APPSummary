//
//  ViewController.h
//  PDFShow
//
//  Created by Tang on 2016/12/5.
//  Copyright © 2016年 qiuyu wang. All rights reserved.
//

#import "DrawPDFViewController.h"
#import "DrawPDFView.h"

@interface DrawPDFViewController () <UIScrollViewDelegate>
{
    DrawPDFView *drawPDFView;
}

@end

@implementation DrawPDFViewController
@synthesize page, pdfDocument,allSum;

- (instancetype)initWithPage:(NSInteger)pageNumber withPDFDoc:(CGPDFDocumentRef)pdfDoc WithSum:(NSInteger)sum  WithShowIndex:(NSInteger)currentindex
{
    self = [super init];
    
    if (self)
    {
        self.page = pageNumber;
        self.pdfDocument = pdfDoc;
        self.allSum = sum;
        self.currentNum = currentindex;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional  after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    //缩放级别
    scrollView.maximumZoomScale = 2.0;
    scrollView.minimumZoomScale = 1.0;
    [self.view addSubview:scrollView];
    
    drawPDFView = [[DrawPDFView alloc] initWithFrame:self.view.bounds atPage:self.page withPDFDoc:self.pdfDocument];
    [scrollView addSubview:drawPDFView];
    
    NSLog(@"第%lu页了",self.page);

    UILabel *pageLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-30, self.view.bounds.size.width, 30)];
    pageLab.text = [NSString stringWithFormat:@"%ld/%ld",self.currentNum,self.allSum];
    pageLab.textColor = [UIColor lightGrayColor];
    pageLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:pageLab];
    
}

#pragma - mark UIScrollViewDelegate
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return drawPDFView;
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
