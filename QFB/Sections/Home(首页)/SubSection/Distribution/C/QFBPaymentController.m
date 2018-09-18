//
//  QFBPaymentController.m
//  QFB
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBPaymentController.h"
#import "QFBUserModel.h"
#import "QFBPaymentSuccessController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface QFBPaymentController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label_balance;
@property (weak, nonatomic) IBOutlet UIButton *button_zfb;
@property (weak, nonatomic) IBOutlet UIButton *button_ye;
@property (nonatomic, assign) double balance;      // 可用余额
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString *orderNumber;

@end

@implementation QFBPaymentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付";
    _button_zfb.selected = YES;
    _button_ye.selected = NO;
    [self getBalanceMoney];
    
    // 生成支付宝
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:[[DCSpeedy getNowTimestamp] integerValue] / 1000];
    _orderNumber = [stampFormatter stringFromDate:stampDate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - 处理支付宝
- (void)initWebview
{
    /*  ******************** ***** ***************    */
    /*  ******************** 测试用 ***************    */
    
//    _amountOfPayment = 0.1;
    
    /*  ******************** ***** ***************    */
    /*  ******************** ***** ***************    */
    
    NSString *hostUrl = BASEURL;
    NSString *role;
    if (self.payType == 1) {    // 购买会员
        role = self.roleID;
    }else{                      // 购买机器
        role = [kDefault objectForKey:ROLE_IDk];
    }
    NSString *method = [NSString stringWithFormat:@"/pay/pay.action?price=%.2f&userId=%@&oBrandId=%@&roleId=%@&orderNumber=%@&payType=%d",_amountOfPayment, [kDefault objectForKey:USER_IDk], O_BRAND_ID, role, _orderNumber, _payType];
    hostUrl = [hostUrl stringByAppendingString:method];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    // 加载已经配置的url
    [self loadWithUrlStr:hostUrl];
}

- (void)loadWithUrlStr:(NSString*)urlStr
{
    if (urlStr.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]
                                                        cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                    timeoutInterval:30];
            [self.webView loadRequest:webRequest];
        });
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //新版本的H5拦截支付对老版本的获取订单串和订单支付接口进行合并，推荐使用该接口
    WEAKSELF;
    BOOL isIntercepted = [[AlipaySDK defaultService] payInterceptorWithUrl:[request.URL absoluteString] fromScheme:AliPay_App_Scheme callback:^(NSDictionary *result) {
        // 处理支付结果
        DLog(@"result = %@", result);
        /*  resultCode
         9000    订单支付成功
         8000    正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
         4000    订单支付失败
         5000    重复请求
         6001    用户中途取消
         6002    网络连接出错
         6004    支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
         其它    其它支付错误
         */
        if ([result[@"resultCode"] isEqualToString:@"9000"]) {
            [SVProgressHUD dismiss];
            [weakSelf jumpSuccessView];
        }else{
            [SVProgressHUD showInfoWithStatus:@"未完成支付"];
            [SVProgressHUD dismissWithDelay:1.0];
        }
    }];
    DLog(@"isIntercepted = %d",isIntercepted);
    if (isIntercepted) {
        return NO;
    }
    return YES;
}

#pragma mark - service
- (void)getBalanceMoney
{
    WEAKSELF;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/findUserById.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        QFBUserModel *model = [QFBUserModel mj_objectWithKeyValues:responseObject[@"data"]];
        weakSelf.label_balance.text = [NSString stringWithFormat:@"可用金额￥%g",model.remarks];
    } andFaild:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络出错"];
        [SVProgressHUD dismissWithDelay:0.5];
    }];
}

#pragma mark - 点击事件
- (IBAction)pressZFB:(id)sender {
    _button_zfb.selected = YES;
    _button_ye.selected = NO;
}

- (IBAction)pressYE:(id)sender {
    _button_zfb.selected = NO;
    _button_ye.selected = YES;
}

//  点击确认支付
- (IBAction)pressSure:(id)sender {
    if (_button_zfb.isSelected) {   //  使用支付宝
        [SVProgressHUD showWithStatus:@"等待付款..."];
        [self initWebview];
    }else{                          //  使用余额
        if (self.balance < self.amountOfPayment) {
            [SVProgressHUD showInfoWithStatus:@"您的余额不足,请选择别的支付方式"];
            [SVProgressHUD dismissWithDelay:1.0];
            return ;
        }
        WEAKSELF;
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
        dic[@"price"]   = [NSNumber numberWithDouble:self.amountOfPayment];
        if (self.payType == 1) {    // 购买会员
            dic[@"roleId"] = self.roleID;
        }else {                     // 买机器
            dic[@"orderNum"] = _orderNumber;
        }
        [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/updateUserPrice.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
             [SVProgressHUD dismiss];
            //  成功  跳转成功页面
            [weakSelf jumpSuccessView];
        } andFaild:^(NSError *error) {
            [SVProgressHUD showInfoWithStatus:@"网络出错"];
            [SVProgressHUD dismissWithDelay:1.0];
        }];
    }
}


/**
 跳转成功界面
 */
- (void)jumpSuccessView
{
    QFBPaymentSuccessController *vc = [[QFBPaymentSuccessController alloc] init];
    vc.isPay = YES;
    [self presentViewController:vc animated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}

@end








