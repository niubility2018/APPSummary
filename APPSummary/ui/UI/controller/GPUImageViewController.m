//
//  GPUImageViewController.m
//  RuntimeTest
//
//  Created by xubojoy on 2018/1/26.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "GPUImageViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ILGLKImageView.h"
#import <GLKit/GLKit.h>
#import "CIFilter+LUT.h"
#import <GPUImage/GPUImage.h>
#import "GpUImageScaleFilter.h"
#import "GPUImageSoulFilter.h"
@interface GPUImageViewController (){
    NSInteger _faildCount;
    CIImage *_lastCIImage;    //最后获取到的图片
    CMTime _lastTime;    //最后一次时间
    UIImageView *_show;
    float _scaleCount;
    GPUImageStillCamera *stillCamera;
    GPUImageGammaFilter *filter;
}
@property(nonatomic,strong) AVPlayer *player;

@property(nonatomic,strong) AVPlayerItemVideoOutput *videoOutPut;

@property(nonatomic,strong) ILGLKImageView *glkImageView;

@property(nonatomic,strong) CADisplayLink *disPlayLink;

@property(nonatomic,strong) dispatch_queue_t renderQueue;

@property (nonatomic, strong) GPUImagePicture *picture;
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@end

@implementation GPUImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initHeaderView];
    _renderQueue = dispatch_queue_create("com.renderQueue", DISPATCH_QUEUE_SERIAL);
//    视频添加滤镜
    [self setUpUI];
//    图片添加滤镜
    [self setUpImage];
    _scaleCount = 1.1;
}
/**
 初始化导航
 */
- (void)initHeaderView{
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    self.customNavBar.barBackgroundColor = [UIColor brownColor];
    [self.view addSubview:self.customNavBar];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.leftButton.hidden = YES;
    //    self.customNavBar.title = @"UI";
    // 设置初始导航栏透明度
    [self.customNavBar wr_setBackgroundAlpha:1];
}

- (void)setUpImage{
    
    UIImage *inputImage = [UIImage imageNamed:@"logo.jpeg"];
    
    //    //创建一个亮度的滤镜
    //    GPUImageBrightnessFilter *passthroughFilter = [[GPUImageBrightnessFilter alloc] init];
    //    passthroughFilter.brightness = -0.5f;
    //    //设置要渲染的区域
    //    [passthroughFilter forceProcessingAtSize:inputImage.size];
    //    [passthroughFilter useNextFrameForImageCapture];
    //    //获取数据源
    //    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:inputImage];
    //    //添加上滤镜
    //    [stillImageSource addTarget:passthroughFilter];
    //    //开始渲染
    //    [stillImageSource processImage];
    //    //获取渲染后的图片
    //    UIImage *newImage = [passthroughFilter imageFromCurrentFramebuffer];
    //    //加载出来
    //    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    //    imageView.frame = CGRectMake(50,100,100 ,100);
    //    [self.view addSubview:imageView];
    
    
    //    GPUImageStretchDistortionFilter *disFilter =[[GPUImageStretchDistortionFilter alloc] init];
    //    GPUImageBulgeDistortionFilter *disFilter = [[GPUImageBulgeDistortionFilter alloc] init];
    //    GPUImagePinchDistortionFilter *disFilter = [[GPUImagePinchDistortionFilter alloc] init];
    //    GPUImageGlassSphereFilter *disFilter = [[GPUImageGlassSphereFilter alloc] init];
    //    GPUImageSphereRefractionFilter *disFilter = [[GPUImageSphereRefractionFilter alloc] init];
    GPUImageToonFilter *disFilter = [[GPUImageToonFilter alloc] init];
    
    //    GPUImageVignetteFilter *disFilter = [[GPUImageVignetteFilter alloc] init];
    //设置要渲染的区域
    [disFilter forceProcessingAtSize:inputImage.size];
    [disFilter useNextFrameForImageCapture];
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:inputImage];
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    //加载出来
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    imageView.frame = CGRectMake(50,100,100 ,100);
    [self.view addSubview:imageView];
}

//视频添加滤镜
- (void)setUpUI{
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMG_0019.mp4" ofType:nil]]];
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    
    [self createVideoOutPut];
    
    [self glkImageView];
    
    self.disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshDisplay:)];
    //    self.disPlayLink.frameInterval = 2;
    [self.disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    [self.player play];
}

- (void)refreshDisplay:(CADisplayLink *)sender {
    [self renderCIImageWithCIFilter];
}


#pragma mark - 取出每一帧 渲染
- (void)renderCIImageWithCIFilter{
    dispatch_async(_renderQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            glClear(GL_COLOR_BUFFER_BIT);
        });
        
        CMTime time = [_videoOutPut itemTimeForHostTime:CACurrentMediaTime()];
        if ([_videoOutPut hasNewPixelBufferForItemTime:time]) {
            
            _faildCount = 0;
            
            CVPixelBufferRef pixelBuffer = NULL;
            
            pixelBuffer = [_videoOutPut copyPixelBufferForItemTime:time itemTimeForDisplay:nil];
            if (!pixelBuffer) {
                return ;
            }
            
            __block CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
            CVPixelBufferRelease(pixelBuffer);
            
            _lastCIImage = ciImage;
            _lastTime = time;
            //
            //添加滤镜等效果
            [self renderCIImageWithCIImage:ciImage];
            
            
        }else{
            _faildCount++;
            
            //使用上次的image
            if (CMTimeGetSeconds(time) == CMTimeGetSeconds(_lastTime) && _lastCIImage) {
                
                [self renderCIImageWithCIImage:_lastCIImage];
                
                _faildCount = 0;
                
            }else if (_faildCount == 30){
                _faildCount = 0;
                NSLog(@"------------");
                [self.disPlayLink setPaused:YES];
                [self createVideoOutPut];
            }
            
        }
        
    });
    
}

- (void)renderCIImageWithCIImage:(CIImage *)ciImage{
//        CGSize imageSize = CGSizeMake(ciImage.extent.size.width/2, ciImage.extent.size.height/2);
//        if (!CGSizeEqualToSize(imageSize, _videoManager.currentVideoInfo.videoSize)) {
//            _videoManager.currentVideoInfo.videoSize = imageSize;
//            [self setPreImageViewSize];
//        }
    
    
    CIContext *content = [CIContext contextWithOptions:nil];
    CGImageRef img = [content createCGImage:ciImage fromRect:[ciImage extent]];
    GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:[[UIImage alloc] initWithCGImage:img]];
    CGImageRelease(img);
    
    GpUImageScaleFilter *scaleFilter = [[GpUImageScaleFilter alloc] init];
    
    _scaleCount += 0.005;
    if (_scaleCount >= 1.2) {
        _scaleCount = 1.1;
    }
    
    scaleFilter.scale = _scaleCount;
    
    [scaleFilter useNextFrameForImageCapture];
    [picture addTarget:scaleFilter];
    
    [picture processImageWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.glkImageView.ciImage = [[CIImage alloc] initWithCGImage:[scaleFilter imageFromCurrentFramebuffer].CGImage];
        });
    }];
}

- (ILGLKImageView *)glkImageView{
    if (!_glkImageView) {
        _glkImageView = [[ILGLKImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)/2 - CGRectGetWidth(self.view.frame)/2, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame))];
        [self.view addSubview:_glkImageView];
    }
    return _glkImageView;
}


- (void)createVideoOutPut{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange),kCVPixelBufferPixelFormatTypeKey,
                                 nil];
        
        
        if (_videoOutPut) {
            [_player.currentItem removeOutput:_videoOutPut];
        }
        _videoOutPut = [[AVPlayerItemVideoOutput alloc] initWithPixelBufferAttributes:options];
        [_player.currentItem addOutput:_videoOutPut];
        
        [self.disPlayLink setPaused:NO];
        
    });
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_player pause];
    [self.disPlayLink setPaused:YES];
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
