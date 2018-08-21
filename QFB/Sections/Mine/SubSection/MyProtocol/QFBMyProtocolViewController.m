//
//  QFBMyProtocolViewController.m
//  QFB
//
//  Created by qqq on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMyProtocolViewController.h"
#import <WebKit/WebKit.h>

@interface QFBMyProtocolViewController ()<WKUIDelegate, WKNavigationDelegate>
{
    WKWebView *_mainWebView;
    
}

@end

@implementation QFBMyProtocolViewController

#pragma mark - UI

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self initUI];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    self.navigationItem.title = @"代理协议";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadWebView];
    [self getDelegatePtotocol];
}
- (void)loadWebView
{
    _mainWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height - SafeAreaTopHeight + 64)];
    [self.view addSubview:_mainWebView];
    _mainWebView.UIDelegate = self;
    _mainWebView.navigationDelegate = self;
    _mainWebView.scrollView.bounces=YES;
    
}
#pragma mark - service
- (void)getDelegatePtotocol
{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"oBrandId"] = O_BRAND_ID;
    
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/appDynamic/selectByAgreement.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [self->_mainWebView loadHTMLString:responseObject[@"data"][@"content"] baseURL:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }

    } andFaild:^(NSError *error) {

    }];



}

#pragma mark - WKNavigationDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 让webview的内容一直居中显示
    scrollView.contentOffset = CGPointMake((scrollView.contentSize.width - screen_width) / 2, scrollView.contentOffset.y);
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [_mainWebView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [_mainWebView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];
    //    [_webProgressLayer finishedLoadWithError:nil];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    //    [_webProgressLayer finishedLoadWithError:nil];
    
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didCommitNavigation");
    
}

@end
