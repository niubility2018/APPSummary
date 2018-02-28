//
//  CommonWebController.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/28.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "CommonWebController.h"
#import <WebKit/WebKit.h>
#import <QuickLook/QuickLook.h>
@interface CommonWebController ()<WKNavigationDelegate,WKUIDelegate, QLPreviewControllerDelegate, QLPreviewControllerDataSource>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *dataPath;

@end

@implementation CommonWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.webView];
    self.dataPath = [NSString stringWithFormat:@"file://%@",[[NSBundle mainBundle] pathForResource:@"design-model" ofType:@"pdf"]];
    [self qlPreviewControllerView];
}

- (void)qlPreviewControllerView{
    QLPreviewController *qlPreview = [[QLPreviewController alloc]init];
    qlPreview.dataSource = self; //需要打开的文件的信息要实现dataSource中的方法
    qlPreview.delegate = self;  //视图显示的控制
    qlPreview.view.frame = self.view.bounds;
    [self.navigationController pushViewController:qlPreview animated:YES];
}

#pragma mark - QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    
    
    
    return [NSURL URLWithString:self.dataPath];
}


- (WKWebView *)webView {
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"design-model" ofType:@"pdf"];
    if (_webView) return _webView;
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _webView.allowsBackForwardNavigationGestures = YES;
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    if (@available(iOS 9.0, *)) {
        [_webView loadData:[NSData dataWithContentsOfFile:dataPath] MIMEType:@"application/pdf" characterEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
    } else {
        // Fallback on earlier versions
    }
//    [_webView loadData:[NSData dataWithContentsOfFile:dataPath] MIMEType:@"application/pdf" textEncodingName:@"UTF-8" baseURL:nil];

    return _webView;
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面开始加载时调用");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"当内容开始返回时调用");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载完成之后调用");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载失败时调用");
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
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
