//
//  ViewController.h
//  PDFShow
//
//  Created by Tang on 2016/12/5.
//  Copyright © 2016年 qiuyu wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawPDFView : UIView
{
    CGPDFDocumentRef pdfDocument;
    NSInteger        page;
}

- (instancetype)initWithFrame:(CGRect)frame atPage:(NSInteger)page withPDFDoc:(CGPDFDocumentRef)pdfDoc;


@end
