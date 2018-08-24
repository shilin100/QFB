//
//  QFBDrawSuccessController.m
//  QFB
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBDrawSuccessController.h"

@interface QFBDrawSuccessController ()

@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_phone;
@property (weak, nonatomic) IBOutlet UILabel *label_money;

@end

@implementation QFBDrawSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    _label_name.text = _name;
    _label_money.text = [NSString stringWithFormat:@"￥%@",_price];
    NSString *frontStr = [_phone substringWithRange:NSMakeRange(0, 3)];
    NSString *behindStr = [_phone substringFromIndex:_phone.length - 3];
    _label_phone.text = [NSString stringWithFormat:@"%@******%@",frontStr,behindStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end








