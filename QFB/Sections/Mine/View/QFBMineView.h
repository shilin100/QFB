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


@property(nonatomic,strong)UIButton *withdrawBtn;

@property(nonatomic,strong)QFBMineTableView *tableView;



@end
