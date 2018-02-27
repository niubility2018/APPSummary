//
//  DrawView.m
//  RuntimeTest
//
//  Created by xubojoy on 2018/1/22.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView
//路径数组
- (NSMutableArray *)paths{
    if (!_paths) {
        _paths = [NSMutableArray new];
    }
    return _paths;
}
//清除
- (void)cleanAll{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}
//回退
- (void)rollback{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
//橡皮擦
- (void)eraser{
    _lineColor = self.backgroundColor;
}
//保存
- (void)save{
//    开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
//    获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
//    截屏
    [self.layer renderInContext:context];
//    获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    关闭图片上下文
    UIGraphicsEndImageContext();
//    保存到相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

//保存图片的回调
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *message = @"";
    if (!error) {
        message = @"成功保存到相册";
    }else{
        message = [error description];
    }
    NSLog(@"message is %@",message);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    获取触摸对象
    UITouch *touch = [touches anyObject];
//    获取手指位置
    CGPoint point = [touch locationInView:touch.view];
//    当手指按下就开创建一条路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = _lineWidth;
    [_lineColor set];
//    设置起点
    [path moveToPoint:point];
    [self.paths addObject:path];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
//    连线的点
    [[self.paths lastObject] addLineToPoint:point];
    
//    重绘
    [self setNeedsDisplay];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (UIBezierPath *path in self.paths) {
//        设置颜色
        [_lineColor set];
//        设置连线处的样式
        [path setLineJoinStyle:kCGLineJoinRound];
//        设置头尾样式
        [path setLineCapStyle:kCGLineCapRound];
//        渲染
        [path stroke];
    }
}


@end
