//
//  QFBMineView.m
//  QFB
//
//  Created by qqq on 2018/8/16.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMineView.h"
#import "QFBMineTableView.h"
#import "QFBMyMessageController.h"

@implementation QFBMineView

-(instancetype)init{
    if (self = [super init]) {
        
        UIImageView * bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        bgImgView.image = [UIImage imageNamed:@"我的背景"];
        [self addSubview:bgImgView];
        
        [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(@0);
            make.height.mas_equalTo(@(227 + (SafeAreaTopHeight - 64)));
        }];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight - 44, ScreenWidth, 44)];
        titleLabel.textAlignment = 1;
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = @"盟友";
        [self addSubview:titleLabel];
        
        UIButton *messageBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 50, SafeAreaTopHeight - 42, 40, 40)];
        [messageBtn setImage:[UIImage imageNamed:@"home_have_msg"] forState:UIControlStateNormal];
        [messageBtn addTarget:self action:@selector(pressMessage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:messageBtn];
        
        UIImageView * userIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        userIcon.contentMode = UIViewContentModeScaleAspectFill;
        userIcon.image = [UIImage imageNamed:@"我的默认头像"];
        CGFloat userIconHeight = 75;//头像宽高
        userIcon.layer.cornerRadius = userIconHeight/2;
        userIcon.layer.masksToBounds = YES;
        [self addSubview:userIcon];
        self.userIcon = userIcon;

        if ([kDefault objectForKey:USER_HEAD_IMGk] != nil) {
            [userIcon sd_setImageWithURL:[NSURL URLWithString:[kDefault objectForKey:USER_HEAD_IMGk]] placeholderImage:[UIImage imageNamed:@"我的默认头像"]];

        }
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(userIconHeight, userIconHeight));
            make.left.mas_equalTo(@24);
            make.top.mas_equalTo(@(77 + (SafeAreaTopHeight - 64)));
        }];

        UILabel * levelLabel = [UILabel new];
        levelLabel.text = @"V0";
        levelLabel.font = XFont(12);
//        usernameLabel.textColor = HEXCOLOR(0xFDE3B6);
        levelLabel.textAlignment = NSTextAlignmentCenter;
        levelLabel.backgroundColor = HEXCOLOR(0xFDE3B6);
        levelLabel.layer.cornerRadius = 10;
        levelLabel.layer.masksToBounds = YES;

        [self addSubview:levelLabel];
        self.levelLabel = levelLabel;
        
        [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.bottom.equalTo(userIcon.mas_bottom).offset(5);
            make.right.equalTo(userIcon.mas_right).offset(-5);

        }];

        
        UILabel * usernameLabel = [UILabel new];
        usernameLabel.text = [kDefault objectForKey:NICK_NAMEk];
        usernameLabel.font = XFont(18);
        usernameLabel.textColor = HEXCOLOR(0xFDE3B6);
//        usernameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:usernameLabel];
        self.usernameLabel = usernameLabel;
        
        [usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(userIcon.mas_top).offset(10);
            make.left.equalTo(userIcon.mas_right).offset(20);
            make.height.mas_equalTo(@20);
            make.right.mas_equalTo(@-80);
        }];

        UIImageView * memberIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        memberIcon.contentMode = UIViewContentModeScaleAspectFit;
        memberIcon.image = [UIImage imageNamed:@"皇冠icon"];
        [self addSubview:memberIcon];
        
        [memberIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.equalTo(usernameLabel.mas_left);
            make.bottom.equalTo(userIcon.mas_bottom).offset(-10);
        }];

        
        UILabel * memberLabel = [UILabel new];
        memberLabel.text = @"金牌";
        memberLabel.font = XFont(12);
        memberLabel.textColor = HEXCOLOR(0xFDE3B6);
        memberLabel.layer.masksToBounds = YES;
        memberLabel.layer.cornerRadius = 5;
        memberLabel.layer.borderWidth = 1;
        memberLabel.layer.borderColor = HEXCOLOR(0xFDE3B6).CGColor;
        memberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:memberLabel];
        self.memberLabel = memberLabel;

        [memberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(memberIcon);
            make.left.equalTo(memberIcon.mas_right).offset(7);
            make.height.mas_equalTo(@20);
            make.width.greaterThanOrEqualTo(@80);
        }];

        UIImageView * moreArrow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        moreArrow.contentMode = UIViewContentModeScaleAspectFit;
        moreArrow.image = [UIImage imageNamed:@"我的更多"];
        [self addSubview:moreArrow];
        
        [moreArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(userIcon);
            make.right.mas_equalTo(@-24);
            make.height.mas_equalTo(@20);
            make.width.mas_equalTo(@10);
        }];

        
        UIButton * accountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:accountBtn];
        self.accountBtn = accountBtn;
        
        [accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(userIconHeight);
            make.top.mas_equalTo(@77);
            make.left.right.mas_equalTo(0);
        }];

        
        
        UIView * leftLine = [UIView new];
        leftLine.backgroundColor = HEXCOLOR(0x4D4F5A);
        [self addSubview:leftLine];
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(userIcon.mas_bottom).offset(27);
            make.left.mas_equalTo(@(kSCREEN_WIDTH/3));
            make.height.mas_equalTo(@28);
            make.width.mas_equalTo(@1);
        }];

        UILabel * newParterner = [UILabel new];
        newParterner.text = @"新增伙伴";
        newParterner.font = XFont(12);
//        newParterner.textColor = HEXCOLOR(0xFDE3B6);
        newParterner.textAlignment = NSTextAlignmentCenter;
        [self addSubview:newParterner];
        
        [newParterner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(leftLine.mas_left).offset(-20);
            make.left.mas_equalTo(@20);
            make.height.mas_equalTo(@12);
            make.top.equalTo(userIcon.mas_bottom).offset(23);
        }];

        UILabel * newParternerCount = [UILabel new];
        newParternerCount.text = @"暂无";
        newParternerCount.font = XFont(18);
        newParternerCount.textColor = HEXCOLOR(0xFDE3B6);
        newParternerCount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:newParternerCount];
        self.parternerCount = newParternerCount;
        
        [newParternerCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(leftLine.mas_left).offset(-20);
            make.left.mas_equalTo(@20);
            make.height.mas_equalTo(@20);
            make.top.equalTo(newParterner.mas_bottom).offset(7);
        }];

        
        
        
        UIView * rightLine = [UIView new];
        rightLine.backgroundColor = HEXCOLOR(0x4D4F5A);
        [self addSubview:rightLine];
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(userIcon.mas_bottom).offset(27);
            make.left.mas_equalTo(@(kSCREEN_WIDTH*2/3));
            make.height.mas_equalTo(@28);
            make.width.mas_equalTo(@1);
        }];

        UILabel * myRank = [UILabel new];
        myRank.text = @"我的排名";
        myRank.font = XFont(12);
        myRank.textAlignment = NSTextAlignmentCenter;
        [self addSubview:myRank];
        
        [myRank mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(rightLine.mas_left).offset(-20);
            make.left.equalTo(leftLine.mas_left).offset(20);
            make.height.mas_equalTo(@12);
            make.top.equalTo(userIcon.mas_bottom).offset(23);
        }];
        
        UILabel * myRackCount = [UILabel new];
        myRackCount.text = @"暂无";
        myRackCount.font = XFont(18);
        myRackCount.textColor = HEXCOLOR(0xFDE3B6);
        myRackCount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:myRackCount];
        self.myRankCount = myRackCount;
        
        [myRackCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(rightLine.mas_left).offset(-20);
            make.left.equalTo(leftLine.mas_left).offset(20);
            make.height.mas_equalTo(@20);
            make.top.equalTo(newParterner.mas_bottom).offset(7);
        }];

        
        UILabel * activeCommercial = [UILabel new];
        activeCommercial.text = @"激活商户";
        activeCommercial.font = XFont(12);
        //        newParterner.textColor = HEXCOLOR(0xFDE3B6);
        activeCommercial.textAlignment = NSTextAlignmentCenter;
        [self addSubview:activeCommercial];
        
        [activeCommercial mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightLine.mas_right).offset(20);
            make.right.mas_equalTo(@-20);
            make.height.mas_equalTo(@12);
            make.top.equalTo(userIcon.mas_bottom).offset(23);
        }];
        
        UILabel * activeCommercialCount = [UILabel new];
        activeCommercialCount.text = @"暂无";
        activeCommercialCount.font = XFont(18);
        activeCommercialCount.textColor = HEXCOLOR(0xFDE3B6);
        activeCommercialCount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:activeCommercialCount];
        self.activeCommercialCount = activeCommercialCount;
        
        [activeCommercialCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightLine.mas_right).offset(20);
            make.right.mas_equalTo(@-20);
            make.height.mas_equalTo(@20);
            make.top.equalTo(activeCommercial.mas_bottom).offset(7);
        }];
        
        
        
        UIImageView * MoneyBgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        MoneyBgImgView.contentMode = UIViewContentModeScaleAspectFill;
        MoneyBgImgView.image = [UIImage imageNamed:@"我要提现背景"];
        [self addSubview:MoneyBgImgView];
        
        [MoneyBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(@0);
            make.height.mas_equalTo(64);
            make.top.equalTo(bgImgView.mas_bottom).offset(0);
        }];

        UIButton * withdrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [withdrawBtn setBackgroundColor:HEXCOLOR_ALPHA(0x333333, 0.24)];
        withdrawBtn.layer.masksToBounds = YES;
        withdrawBtn.layer.cornerRadius = 5;
        withdrawBtn.titleLabel.font = XFont(15);
        withdrawBtn.titleLabel.numberOfLines = 2;
        [withdrawBtn setTitle:@"我要\n提现" forState:UIControlStateNormal];
        [self addSubview:withdrawBtn];
        self.withdrawBtn = withdrawBtn;
        
        [withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(64);
            make.top.equalTo(bgImgView.mas_bottom).offset(0);
            make.width.mas_equalTo(59);
            make.right.mas_equalTo(-24);
        }];

        
        UILabel * myMoney = [UILabel new];
        myMoney.text = @"我的余额:";
        myMoney.font = XFont(12);
        myMoney.textColor = [UIColor whiteColor];
        [self addSubview:myMoney];
        
        [myMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@(kSCREEN_WIDTH/2-21));
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(@12);
            make.top.equalTo(MoneyBgImgView.mas_top).offset(10);
        }];
        
        UILabel * myMoneyCount = [UILabel new];
        myMoneyCount.text = @"暂无";
        myMoneyCount.font = XBFont(30);
        myMoneyCount.textColor = HEXCOLOR(0xFDE3B6);
        [self addSubview:myMoneyCount];
        self.myMoneyCount = myMoneyCount;
        
        [myMoneyCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(myMoney.mas_left).offset(0);
            make.right.equalTo(withdrawBtn.mas_left).offset(-10);
            make.height.mas_equalTo(@30);
            make.top.equalTo(myMoney.mas_bottom).offset(4);
        }];

        
        
        UILabel * myEarn = [UILabel new];
        myEarn.text = @"我的收益:";
        myEarn.font = XFont(12);
        myEarn.textColor = [UIColor whiteColor];
        [self addSubview:myEarn];
        
        [myEarn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@24);
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(@12);
            make.top.equalTo(MoneyBgImgView.mas_top).offset(10);
        }];
        
        UILabel * myEarnCount = [UILabel new];
        myEarnCount.text = @"1212.33元";
        myEarnCount.font = XBFont(30);
        myEarnCount.textColor = HEXCOLOR(0xFDE3B6);
        [self addSubview:myEarnCount];
        self.myEarnCount = myEarnCount;
        
        [myEarnCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(myEarn.mas_left).offset(0);
            make.right.equalTo(myMoneyCount.mas_left).offset(-10);
            make.height.mas_equalTo(@30);
            make.top.equalTo(myEarn.mas_bottom).offset(4);
        }];

        QFBMineTableView * tableView = [[QFBMineTableView alloc]initWithFrame:CGRectMake(0, 0, 19, 19)];
        self.tableView = tableView;
        [self addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(MoneyBgImgView.mas_bottom).offset(11);
            make.left.mas_equalTo(@0);
            make.right.mas_equalTo(@0);
            make.height.mas_equalTo(@230);
        }];
        
    }
    return self;
}

- (void)pressMessage
{
    QFBMyMessageController *vc = [[QFBMyMessageController alloc] init];
    [[DCSpeedy dc_getCurrentVC].navigationController pushViewController:vc animated:YES];
}


-(void)setTableViewModel:(id)viewModel{
    self.tableView.viewModel = viewModel;
}



-(void)setMyEarnStr:(NSString *)myEarnStr{

    
    NSString * totalStr = [NSString stringWithFormat:@"%@元",myEarnStr];
    NSArray *array = [totalStr componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
    NSString * rangeStr = [NSString stringWithFormat:@".%@",array.lastObject];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:totalStr];
    NSRange rang = [totalStr rangeOfString:rangeStr];
    
    [attributeString setAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys:XFont(15),NSFontAttributeName, nil] range:rang];
    self.myEarnCount.attributedText = attributeString;
    
}

-(void)setMyMoneyStr:(NSString *)myMoneyStr{
    
    
    NSString * totalStr = [NSString stringWithFormat:@"%@元",myMoneyStr];
    NSArray *array = [totalStr componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
    NSString * rangeStr = [NSString stringWithFormat:@".%@",array.lastObject];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:totalStr];
    NSRange rang = [totalStr rangeOfString:rangeStr];
    [attributeString setAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys:XFont(15),NSFontAttributeName, nil] range:rang];
    self.myMoneyCount.attributedText = attributeString;
    
}


@end
