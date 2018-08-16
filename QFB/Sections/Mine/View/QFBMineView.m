//
//  QFBMineView.m
//  QFB
//
//  Created by qqq on 2018/8/16.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMineView.h"

@implementation QFBMineView

-(instancetype)init{
    if (self = [super init]) {
        
        UIImageView * bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        bgImgView.image = [UIImage imageNamed:@"我的背景"];
        [self addSubview:bgImgView];
        
        [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(@0);
            make.height.mas_equalTo(227);
        }];
        
        UIImageView * userIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        userIcon.contentMode = UIViewContentModeScaleAspectFill;
        userIcon.image = [UIImage imageNamed:@"我的默认头像"];
        CGFloat userIconHeight = 75;//头像宽高
        userIcon.layer.cornerRadius = userIconHeight/2;
        userIcon.layer.masksToBounds = YES;
        userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
        userIcon.layer.borderWidth = 2;
        [self addSubview:userIcon];

        if ([kDefault objectForKey:USER_HEAD_IMGk] != nil) {
            [userIcon sd_setImageWithURL:[NSURL URLWithString:[kDefault objectForKey:USER_HEAD_IMGk]] placeholderImage:[UIImage imageNamed:@"我的默认头像"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
            
        }
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(userIconHeight, userIconHeight));
            make.left.mas_equalTo(@24);
            make.top.mas_equalTo(@77);
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
        usernameLabel.text = @"";
        usernameLabel.font = XFont(18);
        usernameLabel.textColor = HEXCOLOR(0xFDE3B6);
//        usernameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:usernameLabel];
        self.usernameLabel = usernameLabel;
        
        [usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(userIcon.mas_top).offset(0);
            

        }];

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    return self;
}
@end
