//
//  FriendUpgradeRuleViewController.m
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "FriendUpgradeRuleViewController.h"
#import "FBWebProgressLayer.h"
#import <WebKit/WebKit.h>
#import "QFBPaymentController.h"

@interface FriendUpgradeRuleViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *mainWebView;

@property (nonatomic, strong) FBWebProgressLayer *webProgressLayer;  //  进度条

@end

@implementation FriendUpgradeRuleViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self initUI];
}
#pragma mark - UI
- (void)initUI
{
    self.navigationItem.title = _roleName;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
    [_upgradeButton setTitle:[NSString stringWithFormat:@"￥%@ 升级会员",_price] forState:UIControlStateNormal];
}
- (void)loadWebView
{
    if (LMJIsEmpty(_contentString)) {
        return ;
    }
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    _mainWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height - SafeAreaBottomHeight) configuration:wkWebConfig];
    [self.view addSubview:_mainWebView];
    _mainWebView.UIDelegate = self;
    _mainWebView.navigationDelegate = self;
    _mainWebView.scrollView.bounces=YES;
    [_mainWebView loadHTMLString:_contentString baseURL:nil];
    //    [_mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
    _webProgressLayer = [[FBWebProgressLayer alloc] init];
    _webProgressLayer.frame = CGRectMake(0, 42, screen_width, 2);
    [self.navigationController.navigationBar.layer addSublayer:_webProgressLayer];
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [_webProgressLayer startLoad];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [_mainWebView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [_mainWebView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];
    [_webProgressLayer finishedLoadWithError:nil];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [_webProgressLayer finishedLoadWithError:nil];
    
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didCommitNavigation");
    
}

- (void)dealloc {
    
    [_webProgressLayer closeTimer];
    [_webProgressLayer removeFromSuperlayer];
    _webProgressLayer = nil;
}

#pragma mark - support
-(NSString *)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
}

- (IBAction)upgradeButtonClicked:(id)sender {
    QFBPaymentController *vc = [[QFBPaymentController alloc] init];
    vc.payType = 1;
    vc.roleID = self.roleID;
    [self.navigationController pushViewController:vc animated:YES];
}

@end










