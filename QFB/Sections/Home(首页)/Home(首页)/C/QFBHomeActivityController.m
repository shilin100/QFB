//
//  QFBHomeActivityController.m
//  QFB
//
//  Created by qqq on 2018/9/14.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeActivityController.h"

@interface QFBHomeActivityController ()

@property (nonatomic, weak) UIScrollView *mySc;
@property (nonatomic, strong) UIImageView *image_top;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_time;
@property (nonatomic, strong) UILabel *label_address;
@property (nonatomic, strong) UILabel *label_user;
@property (nonatomic, strong) UILabel *label_body;
@property (nonatomic, strong) RecentModel *myModel;

@end

@implementation QFBHomeActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDetailData];
    [self createUI];
    // 安装了微信才创建
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeWechat]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(pressShare)];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}


//  点击分享
- (void)pressShare
{
    NSString *title         = _myModel.title;         //分享标题
    NSString *description   = _myModel.metting;      //分享描述
    NSString *imageStr = @"AppIcon";
    NSString *urlStr        = [NSString stringWithFormat:@"http://fxapp.fengzhuan.org/payment_union/user/register.action?parent_id=%@&subordinate_brand=%@",[PublicData sharePublic].userModel.ID, O_BRAND_ID];   //分享链接
    [ShareSDKTool createShareImageUrlStr:imageStr urlStr:urlStr title:title text:description block:^(BOOL isSuccess) {
        
    }];
}

// 网络请求
- (void)loadDetailData
{
    WEAKSELF;
    [self.netWorkTool net_getRecendDetailWithId:self.recentId blockRequest:^(RecentModel *model, RequestState state) {
        [weakSelf loadRecentModel:model];
    }];
}

// model赋值
- (void)loadRecentModel:(RecentModel *)model
{
//    model.metting = @"我们班上有位同学叫李维昊，她有一双明亮的眼睛，一张长长的脸，还有一条辫子。她的同桌贺挺，数学成绩很不理想。无奈，数学老师只好把教贺挺这个艰巨的任务交给李维昊。我们每次都为她着急，但她却不急，她耐心教：乘法，小数乘法，分数乘法。直到满意为止。一次次，贺挺面对着复杂的数学公式和成堆的数学题，都会摇摇头放弃。但李维昊并不生气，只是一遍又一遍的教着贺挺，没抱怨一句。为了让贺挺快点进步，他不辞辛苦，拿出宝贵的课余时间来教贺挺。别人一次次的说她不值得：“花出宝贵的时间教贺挺这个笨蛋。”她却一言不发，默默的教贺挺。贺挺在李维昊的教导下，越来越进步。贺挺能有今天，多亏了李维昊。我们应该学习李维昊的乐于助人的精神。我们班上有位同学叫李维昊，她有一双明亮的眼睛，一张长长的脸，还有一条辫子。她的同桌贺挺，数学成绩很不理想。无奈，数学老师只好把教贺挺这个艰巨的任务交给李维昊。我们每次都为她着急，但她却不急，她耐心教：乘法，小数乘法，分数乘法。直到满意为止。一次次，贺挺面对着复杂的数学公式和成堆的数学题，都会摇摇头放弃。但李维昊并不生气，只是一遍又一遍的教着贺挺，没抱怨一句。为了让贺挺快点进步，他不辞辛苦，拿出宝贵的课余时间来教贺挺。别人一次次的说她不值得：“花出宝贵的时间教贺挺这个笨蛋。”她却一言不发，默默的教贺挺。贺挺在李维昊的教导下，越来越进步。贺挺能有今天，多亏了李维昊。我们应该学习李维昊的乐于助人的精神。/n 我们班上有位同学叫李维昊，她有一双明亮的眼睛，一张长长的脸，还有一条辫子。她的同桌贺挺，数学成绩很不理想。无奈，数学老师只好把教贺挺这个艰巨的任务交给李维昊。我们每次都为她着急，但她却不急，她耐心教：乘法，小数乘法，分数乘法。直到满意为止。一次次，贺挺面对着复杂的数学公式和成堆的数学题，都会摇摇头放弃。但李维昊并不生气，只是一遍又一遍的教着贺挺，没抱怨一句。为了让贺挺快点进步，他不辞辛苦，拿出宝贵的课余时间来教贺挺。别人一次次的说她不值得：“花出宝贵的时间教贺挺这个笨蛋。”她却一言不发，默默的教贺挺。贺挺在李维昊的教导下，越来越进步。贺挺能有今天，多亏了李维昊。我们应该学习李维昊的乐于助人的精神。/n 我们班上有位同学叫李维昊，她有一双明亮的眼睛，一张长长的脸，还有一条辫子。她的同桌贺挺，数学成绩很不理想。无奈，数学老师只好把教贺挺这个艰巨的任务交给李维昊。我们每次都为她着急，但她却不急，她耐心教：乘法，小数乘法，分数乘法。直到满意为止。一次次，贺挺面对着复杂的数学公式和成堆的数学题，都会摇摇头放弃。但李维昊并不生气，只是一遍又一遍的教着贺挺，没抱怨一句。为了让贺挺快点进步，他不辞辛苦，拿出宝贵的课余时间来教贺挺。别人一次次的说她不值得：“花出宝贵的时间教贺挺这个笨蛋。”她却一言不发，默默的教贺挺。贺挺在李维昊的教导下，越来越进步。贺挺能有今天，多亏了李维昊。我们应该学习李维昊的乐于助人的精神。";
    CGFloat h = [DCSpeedy dc_getSizeWithStr:model.metting Width:_label_body.mj_w Font:13];
    CGFloat sh = h + CGRectGetMaxY(_label_user.frame) + 45 + 15;
    _label_body.mj_h = h;
    _mySc.contentSize = CGSizeMake(_mySc.mj_w, sh);
    
    _label_title.text = model.title;
    _label_time.text = [NSString stringWithFormat:@"%@-%@",model.startTime,model.endTime];
    _label_address.text = model.address;
    _label_user.text = model.attending;
    _label_body.text = model.metting;
    [_image_top sd_setImageWithURL:[NSURL URLWithString:model.merchantImg] placeholderImage:[UIImage imageNamed:@"联盟上半部背景"]];
    _myModel = model;
}

// 创建UI
- (void)createUI
{
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"详情";
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, screen_height- (SafeAreaBottomHeight - 49))];
    AdjustsScrollViewInsetNever(self, sc);
    sc.backgroundColor = [UIColor whiteColor];
    sc.showsVerticalScrollIndicator = NO;
    sc.showsHorizontalScrollIndicator = NO;
    sc.alwaysBounceHorizontal = NO;
    sc.contentSize = sc.mj_size;
    [self.view addSubview:sc];
    
    self.image_top = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sc.mj_w, sc.mj_w * 0.6)];
    self.image_top.image = [UIImage imageNamed:@"联盟上半部背景"];
    [sc addSubview:self.image_top];
    
    self.label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.image_top.frame), sc.mj_w - 30, 40)];
    self.label_title.font = [UIFont boldSystemFontOfSize:15];
    self.label_title.textColor = [UIColor blackColor];
    [sc addSubview:self.label_title];
    
    UIImageView *imageTime = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.label_title.frame) + 8.5, 13, 13)];
    imageTime.image = [UIImage imageNamed:@"recent_time_icon"];
    self.label_time = [[UILabel alloc] initWithFrame:CGRectMake(35, CGRectGetMaxY(self.label_title.frame), sc.mj_w - 50, 30)];
    self.label_time.font = [UIFont systemFontOfSize:11];
    self.label_time.textColor = [UIColor lightGrayColor];
    [sc addSubview:imageTime];
    [sc addSubview:self.label_time];
    
    UIImageView *imageAdd = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.label_time.frame) + 8.5, 13, 13)];
    imageAdd.image = [UIImage imageNamed:@"recent_address_icon"];
    self.label_address = [[UILabel alloc] initWithFrame:CGRectMake(35, CGRectGetMaxY(self.label_time.frame), sc.mj_w - 50, 30)];
    self.label_address.font = [UIFont systemFontOfSize:11];
    self.label_address.textColor = [UIColor lightGrayColor];
    [sc addSubview:imageAdd];
    [sc addSubview:self.label_address];
    
    UIImageView *imageUser = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.label_address.frame) + 8.5, 13, 13)];
    imageUser.image = [UIImage imageNamed:@"recent_head_icon"];
    self.label_user = [[UILabel alloc] initWithFrame:CGRectMake(35, CGRectGetMaxY(self.label_address.frame), sc.mj_w - 50, 30)];
    self.label_user.font = [UIFont systemFontOfSize:11];
    self.label_user.textColor = [UIColor lightGrayColor];
    [sc addSubview:imageUser];
    [sc addSubview:self.label_user];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.label_user.frame), sc.mj_w, 5)];
    lineView.backgroundColor = backColor;
    [sc addSubview:lineView];
    
    UILabel *details = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lineView.frame), sc.mj_w - 30, 40)];
    details.font = [UIFont systemFontOfSize:15];
    details.textColor = [UIColor blackColor];
    details.text = @"活动详情";
    [sc addSubview:details];
    
    self.label_body = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(details.frame), sc.mj_w - 30, 20)];
    self.label_body.font = [UIFont systemFontOfSize:13];
    self.label_body.textColor = [UIColor blackColor];
    self.label_body.numberOfLines = 0;
    [sc addSubview:self.label_body];
    
    _mySc = sc;
}

@end













