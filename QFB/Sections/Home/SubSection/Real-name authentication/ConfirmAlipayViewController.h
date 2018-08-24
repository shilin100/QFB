//
//  ConfirmAlipayViewController.h
//  QFB
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmAlipayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *aliPayAccountTextField;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)submitButtonClicked:(id)sender;


@end
