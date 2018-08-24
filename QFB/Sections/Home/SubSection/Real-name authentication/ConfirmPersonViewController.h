//
//  ConfirmPersonViewController.h
//  QFB
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmPersonViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *idCardTextField;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)confirmButtonClicked:(id)sender;

@end
