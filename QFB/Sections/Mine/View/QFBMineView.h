//
//  QFBMineView.h
//  QFB
//
//  Created by qqq on 2018/8/16.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QFBMineTableView;

@interface QFBMineView : UIView
@property(nonatomic,strong)UILabel *usernameLabel;
@property(nonatomic,strong)UILabel *levelLabel;
@property(nonatomic,strong)UILabel *memberLabel;

@property(nonatomic,strong)UILabel *parternerCount;
@property(nonatomic,strong)UILabel *myRankCount;
@property(nonatomic,strong)UILabel *activeCommercialCount;

@property(nonatomic,strong)UILabel *myEarnCount;
@property(nonatomic,strong)UILabel *myMoneyCount;


@property(nonatomic,strong)UIButton *accountBtn;
@property(nonatomic,strong)UIButton *withdrawBtn;

@property(nonatomic,strong)UIImageView *userIcon;



@property(nonatomic,strong)QFBMineTableView *tableView;

-(void)setMyEarnStr:(NSString *)myEarnStr;
-(void)setMyMoneyStr:(NSString *)myMoneyStr;
-(void)setTableViewModel:(id)viewModel;
@end
