//
//  ViewController.h
//  PDFShow
//
//  Created by Tang on 2016/12/5.
//  Copyright © 2016年 qiuyu wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawPDFViewController : UIViewController

@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) CGPDFDocumentRef pdfDocument;
@property (assign, nonatomic) NSInteger allSum;
@property (assign, nonatomic) NSInteger currentNum;

- (instancetype)initWithPage:(NSInteger)pageNumber withPDFDoc:(CGPDFDocumentRef)pdfDoc WithSum:(NSInteger)sum WithShowIndex:(NSInteger)currentindex;

@end
