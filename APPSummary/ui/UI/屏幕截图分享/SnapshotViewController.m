//
//  SnapshotViewController.m
//  APPSummary
//
//  Created by xubojoy on 2018/4/11.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "SnapshotViewController.h"

@interface SnapshotViewController ()



@end

@implementation SnapshotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"launchAnimationBg"];
    [self.view addSubview:imageView];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenShot) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

- (void)screenShot
{
    //每次截屏之前，删除之间添加的存放图片的imageView，不然重复截屏会不断的截取到之前的页面
    [self.photoIV removeFromSuperview];
    self.photoIV = nil;
    
    //第一种截屏, 获取所截图片（imageWithScreenshot在后面实现）
//    UIImage *image = [self imageWithScreenshot];
    
//    第二种截图
//    UIView *snapView = [self.view snapshotViewAfterScreenUpdates:YES];
//    UIImage *iamge = [self createImageWithView:snapView];
    
    //第三种方式
    UIImage *image = [self getImage];
    
    //添加显示
    UIImageView *photoIV = [[UIImageView alloc]initWithImage:image];
    self.photoIV = photoIV;
    photoIV.frame = CGRectMake(20, 50, [UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.height-100);
    
    /*为imageView添加边框和阴影，以突出显示*/
    //给imageView添加边框
    CALayer * layer = [photoIV layer];
    layer.borderColor = [[UIColor whiteColor] CGColor];
    layer.borderWidth = 5.0f;
    
    //添加四个边阴影
    photoIV.layer.shadowColor = [UIColor blackColor].CGColor;
    photoIV.layer.shadowOffset = CGSizeMake(0, 0);
    photoIV.layer.shadowOpacity = 0.5;
    photoIV.layer.shadowRadius = 10.0;
//    [self.view addSubview:photoIV];
    [[UIApplication sharedApplication].delegate.window addSubview:photoIV];
    
    //调用显示分享的页面
//    [self share];
}

#pragma mark 截取当前屏幕，并生成image对象
-(UIImage *)getImage
{
    UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size);
    [[UIApplication sharedApplication].delegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UIImage *)createImageWithView:(UIView *)view
{

    CGSize s = view.bounds.size;

    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，设置为[UIScreen mainScreen].scale可以保证转成的图片不失真。
    UIGraphicsBeginImageContextWithOptions(s, YES,[UIScreen mainScreen].scale);

    [view.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;

}

- (UIImage *)imageWithScreenshot
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(image);
    return [UIImage imageWithData:imageData];
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
