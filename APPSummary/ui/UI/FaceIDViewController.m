//
//  FaceIDViewController.m
//  RuntimeTest
//
//  Created by xubojoy on 2018/2/9.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "FaceIDViewController.h"
#import <CoreImage/CoreImage.h>
//#import <FJAlertView/Constant.h>
#define imageName [NSString stringWithFormat:@"face-%d", _imageTag]

@interface FaceIDViewController ()
@property (strong, nonatomic)   UILabel *label;
@property (strong, nonatomic)   UIImageView *imageView;
@property (nonatomic, assign) int imageTag;

@property (strong, nonatomic) UIButton *lastBtn;
@property (strong, nonatomic) UIButton *nextBtn;

@end

@implementation FaceIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    self.imageTag = 1;
    self.imageView.image = [UIImage imageNamed:imageName];
    [self faceDetectWithImage:[UIImage imageNamed:imageName]];
    
}

- (void)initUI{
    [self.view addSubview:self.label];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.lastBtn];
    [self.view addSubview:self.nextBtn];
}

#pragma mark - 识别人脸
- (void)faceDetectWithImage:(UIImage *)image {
    
    for (UIView *view in self.imageView.subviews) {
        [view removeFromSuperview];
    }
    
    // 图像识别能力：可以在CIDetectorAccuracyHigh(较强的处理能力)与CIDetectorAccuracyLow(较弱的处理能力)中选择，因为想让准确度高一些在这里选择CIDetectorAccuracyHigh
    NSDictionary *opts = [NSDictionary dictionaryWithObject:
                          CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    // 将图像转换为CIImage
    CIImage *faceImage = [CIImage imageWithCGImage:image.CGImage];
    CIDetector *faceDetector=[CIDetector detectorOfType:CIDetectorTypeFace context:nil options:opts];
    // 识别出人脸数组
    NSArray *features = [faceDetector featuresInImage:faceImage];
    // 得到图片的尺寸
    CGSize inputImageSize = [faceImage extent].size;
    //将image沿y轴对称
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, -1);
    //将图片上移
    transform = CGAffineTransformTranslate(transform, 0, -inputImageSize.height);
    
    // 取出所有人脸
    for (CIFaceFeature *faceFeature in features){
        //获取人脸的frame
        CGRect faceViewBounds = CGRectApplyAffineTransform(faceFeature.bounds, transform);
        CGSize viewSize = self.imageView.bounds.size;
        CGFloat scale = MIN(viewSize.width / inputImageSize.width,
                            viewSize.height / inputImageSize.height);
        CGFloat offsetX = (viewSize.width - inputImageSize.width * scale) / 2;
        CGFloat offsetY = (viewSize.height - inputImageSize.height * scale) / 2;
        // 缩放
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(scale, scale);
        // 修正
        faceViewBounds = CGRectApplyAffineTransform(faceViewBounds,scaleTransform);
        faceViewBounds.origin.x += offsetX;
        faceViewBounds.origin.y += offsetY;
        
        //描绘人脸区域
        UIView* faceView = [[UIView alloc] initWithFrame:faceViewBounds];
        faceView.layer.borderWidth = 2;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        [_imageView addSubview:faceView];
        
        // 判断是否有左眼位置
        if(faceFeature.hasLeftEyePosition){}
        // 判断是否有右眼位置
        if(faceFeature.hasRightEyePosition){}
        // 判断是否有嘴位置
        if(faceFeature.hasMouthPosition){}
        //
//        if (faceFeature.hasFaceAngle) {}
        
    }
    self.label.text = [NSString stringWithFormat:@"识别出了%ld张脸", features.count];
}

- (UIButton *)lastBtn{
    if (!_lastBtn) {
        _lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lastBtn.frame = CGRectMake(30, (screen_width-30)/2+140+30, 50, 50);
        _lastBtn.backgroundColor = [UIColor cyanColor];
        [_lastBtn addTarget:self action:@selector(theLastPicture:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:_lastBtn];
    }
    return _lastBtn;
}

- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(200, (screen_width-30)/2+140+30, 50, 50);
        _nextBtn.backgroundColor = [UIColor cyanColor];
        [_nextBtn addTarget:self action:@selector(theNextPicture:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:_nextBtn];
    }
    return _nextBtn;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, screen_width, 20)];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
//        [self.view addSubview:_label];
    }
    return _label;
}


- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 140, screen_width-30, (screen_width-30)/2)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [self.view addSubview:_imageView];
    }
    return _imageView;
}


#pragma mark - 上一张图片
- (void)theLastPicture:(id)sender {
    
    if (_imageTag > 1) {
        _imageTag -= 1;
    } else {
        _imageTag = 1;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经是第一张图片了" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    self.imageView.image = [UIImage imageNamed:imageName];
    [self faceDetectWithImage:[UIImage imageNamed:imageName]];
}

#pragma mark - 下一张图片
- (void)theNextPicture:(id)sender {
    
    if (_imageTag < 6) {
        _imageTag += 1;
    } else {
        _imageTag = 6;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经是最后一张图片了" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    self.imageView.image = [UIImage imageNamed:imageName];
    
    [self faceDetectWithImage:[UIImage imageNamed:imageName]];
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
