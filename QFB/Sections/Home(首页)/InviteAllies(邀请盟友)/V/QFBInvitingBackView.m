//
//  QFBInvitingBackView.m
//  QFB
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBInvitingBackView.h"
#import "QFBInvitingTitleView.h"
#import "UIView+DCExtension.h"
#import "QFBInvitingModel.h"
#import "QFBInvitingBottomView.h"
#import "DCSpeedy.h"


@interface QFBInvitingBackView()

@property (nonatomic, strong) UILabel *label_explain;
@property (nonatomic, strong) QFBInvitingTitleView *view_code;
@property (nonatomic, strong) QFBInvitingTitleView *view_name;
@property (nonatomic, strong) QFBInvitingTitleView *view_phone;
@property (nonatomic, strong) UIImageView *imagev_QRcode;
@property (nonatomic, strong) UIImageView *imagev_QRcodeIcon;
@property (nonatomic, strong) UIView *view_white;
@property (nonatomic, strong) UIImageView *imagev_back;
@property (nonatomic, strong) QFBInvitingBottomView *view_bottom;

@end

@implementation QFBInvitingBackView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imagev_back];
        [self addSubview:self.view_white];
        [self addSubview:self.label_explain];
        [self addSubview:self.view_code];
        [self addSubview:self.view_name];
        [self addSubview:self.view_phone];
        [self addSubview:self.imagev_QRcode];
        [self.imagev_QRcode addSubview:self.imagev_QRcodeIcon];
        [self loadData];
    }
    return self;
}

#pragma mark - 网络请求

- (void)loadData
{
    WEAKSELF;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"oBrandId"] = O_BRAND_ID;
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/test/selectInvitingLogo.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        QFBInvitingModel *model = [QFBInvitingModel mj_objectWithKeyValues:responseObject[@"data"][@"dynamic"]];
        model.list = [QFBInvitingListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        [weakSelf loadModel:model];
    } andFaild:^(NSError *error) {
        
    }];
}

- (void)updateImage:(void(^)(NSString *shareImageUrl))imageUrl;
{
    WEAKSELF;
    // 获取图片
    NSMutableDictionary * dic1 = [NSMutableDictionary dictionary];
    dic1[@"userId"] = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/pic/selectPicById.action",BASEURL] withDic:dic1 Succeed:^(NSDictionary *responseObject) {
        if (LMJIsEmpty(responseObject[@"data"][@"erweima"])) {   // 没有图片
            weakSelf.view_bottom.hidden = YES;
            NSMutableDictionary * dic2 = [NSMutableDictionary dictionary];
            dic2[@"userId"] = [kDefault objectForKey:USER_IDk];
            dic2[@"type"]   = [kDefault objectForKey:USER_IDk];
            UIGraphicsBeginImageContextWithOptions(weakSelf.bounds.size, YES, 1.0);
            [weakSelf.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            dic2[@"photos"] = [DCSpeedy UIImageToBase64Str:uiImage];
            [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/getTwoCodeByUserId.action",BASEURL] withDic:dic2 Succeed:^(NSDictionary *responseObject) {
                imageUrl(responseObject[@"data"]);
            } andFaild:^(NSError *error) {
    
            }];
            weakSelf.view_bottom.hidden = NO;
        }else{
            imageUrl(responseObject[@"data"][@"erweima"]);
        }
    } andFaild:^(NSError *error) {
        
    }];
    
    
    
}


#pragma mark - loadModel
- (void)loadModel:(QFBInvitingModel *)model
{
    [_imagev_QRcodeIcon sd_setImageWithURL:[NSURL URLWithString:model.value]];
    _label_explain.text = model.content;
//    if (model.list.count > 0) {
//        [self addSubview:self.view_bottom];
//    }
}


#pragma mark - 懒加载,UI
- (UILabel *)label_explain
{
    if (!_label_explain) {
        _label_explain = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _label_explain.textAlignment = NSTextAlignmentCenter;
        _label_explain.font = [UIFont systemFontOfSize:16];
        _label_explain.adjustsFontSizeToFitWidth = YES;
        [_label_explain setTextColor: [UIColor whiteColor]];
        _label_explain.text = @"扫一扫下方二维码";
    }
    return _label_explain;
}

- (QFBInvitingTitleView *)view_code
{
    if (!_view_code) {
        _view_code = [QFBInvitingTitleView initWithFrame:CGRectMake(0, 0, 100, 20) leftText:@"推荐码:" right:[kDefault objectForKey:PASSWORDk]];
    }
    return _view_code;
}

- (QFBInvitingTitleView *)view_name
{
    if (!_view_name) {
        _view_name = [QFBInvitingTitleView initWithFrame:CGRectMake(0, 0, 100, 20) leftText:@"推荐人:" right:[kDefault objectForKey:NICK_NAMEk]];
    }
    return _view_name;
}

- (QFBInvitingTitleView *)view_phone
{
    if (!_view_phone) {
        _view_phone = [QFBInvitingTitleView initWithFrame:CGRectMake(0, 0, 100, 20) leftText:@"手机号:" right:[kDefault objectForKey:USERNAMEk]];
        [_view_phone hiddenLine];
    }
    return _view_phone;
}

- (UIImageView *)imagev_QRcode
{
    if (!_imagev_QRcode) {
        _imagev_QRcode = [[UIImageView alloc] init];
        _imagev_QRcode.backgroundColor = [UIColor blackColor];
        NSString *url = [NSString stringWithFormat:@"http://regist.fengzhuan.org:8080/payment_union/user/register.action?parent_id=%@&subordinate_brand=%@",[kDefault objectForKey:USER_IDk],O_BRAND_ID];
        _imagev_QRcode.image = [DCSpeedy dc_getQRCode:url size:self.mj_h * 866 / 2650];
    }
    return _imagev_QRcode;
}

- (UIImageView *)imagev_QRcodeIcon
{
    if (!_imagev_QRcodeIcon) {
        _imagev_QRcodeIcon = [[UIImageView alloc] init];
        _imagev_QRcodeIcon.backgroundColor = [UIColor blackColor];
    }
    return _imagev_QRcodeIcon;
}

- (UIView *)view_white
{
    if (!_view_white) {
        _view_white = [[UIView alloc] init];
        _view_white.backgroundColor = [UIColor whiteColor];
    }
    return _view_white;
}

- (UIImageView *)imagev_back
{
    if (!_imagev_back) {
        _imagev_back = [[UIImageView alloc] initWithFrame:self.bounds];
        _imagev_back.image = [UIImage imageNamed:@"登录页背景图"];
    }
    return _imagev_back;
}

- (QFBInvitingBottomView *)view_bottom
{
    if (!_view_bottom) {
        _view_bottom = [[QFBInvitingBottomView alloc] initWithFrame:self.bounds];
    }
    return _view_bottom;
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    _label_explain.frame = CGRectMake(0, self.mj_h * 250 / 2650, self.mj_w, 20);
    _view_white.frame = CGRectMake(30, self.mj_h * 950 / 2650, self.mj_w - 60, self.mj_h * 1250 / 2650);
    _imagev_QRcode.frame = CGRectMake(0, self.mj_h * 550 / 2650, self.mj_h * 866 / 2650, self.mj_h * 866 / 2650);
    _imagev_QRcodeIcon.frame = CGRectMake(0, 0, _imagev_QRcode.dc_width * 0.15, _imagev_QRcode.dc_width * 0.15);
    _imagev_QRcodeIcon.center = CGPointMake(_imagev_QRcode.dc_width / 2, _imagev_QRcode.dc_height / 2);
    _imagev_QRcode.dc_centerX = self.dc_width / 2;
    _view_code.frame = CGRectMake(CGRectGetMinX(_imagev_QRcode.frame) - 15, CGRectGetMaxY(_imagev_QRcode.frame) + self.mj_h * 108 / 2650, _imagev_QRcode.dc_width + 30, self.mj_h * 160 / 2650);
    _view_name.frame = CGRectMake(_view_code.dc_x, CGRectGetMaxY(_view_code.frame), _view_code.dc_width, _view_code.dc_height);
    _view_phone.frame = CGRectMake(_view_code.dc_x, CGRectGetMaxY(_view_name.frame), _view_code.dc_width, _view_code.dc_height);
}

@end






