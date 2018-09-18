//
//  QFBActivityController.m
//  QFB
//
//  Created by qqq on 2018/9/14.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBActivityController.h"
#import <WebKit/WebKit.h>

@interface QFBActivityController ()

@property (nonatomic, strong) WKWebView *myWebView;

@end

@implementation QFBActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
}

- (void)loadWebView
{
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    _myWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_myWebView];
//    _myWebView.UIDelegate = self;
//    _myWebView.navigationDelegate = self;
    _myWebView.scrollView.bounces=YES;
//    [_mainWebView loadHTMLString:_contentString baseURL:nil];
    [_myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mp.weixin.qq.com/s/NqIMiCKZDdVOtGyVneRwuw"]]];
}

- (void)loadDetailData
{
    [self.netWorkTool net_getRecendDetailWithId:self.recentId blockRequest:^(RecentModel *model, RequestState state) {
        
    }];
}

@end









