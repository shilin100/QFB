//
//  FriendUpgradeRuleViewController.h
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendUpgradeRuleViewController : UIViewController

@property (nonatomic, strong)NSString *contentString;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *roleName;
@property (nonatomic, strong)NSString *roleID;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIButton *upgradeButton;

- (IBAction)upgradeButtonClicked:(id)sender;


@end
