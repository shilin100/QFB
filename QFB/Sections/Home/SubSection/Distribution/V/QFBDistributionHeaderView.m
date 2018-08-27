//
//  QFBDistributionHeaderView.m
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBDistributionHeaderView.h"

@interface QFBDistributionHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_address;
@property (weak, nonatomic) IBOutlet UILabel *label_phone;


@end

@implementation QFBDistributionHeaderView

+ (instancetype)initWithFrame:(CGRect)frame model:(QFBAddressModel *)addressModel
{
    QFBDistributionHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"QFBDistributionHeaderView" owner:nil options:nil] objectAtIndex:0];
    view.frame = frame;
    [view loadAddressModel:addressModel];
    return view;
}

- (void)loadAddressModel:(QFBAddressModel *)model
{
    _label_name.text = model.name;
    _label_phone.text = model.phone;
    _label_address.text = model.address;
}

- (IBAction)pressClick:(id)sender {
    
}

@end



