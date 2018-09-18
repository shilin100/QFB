//
//  QFBAddressTableViewCell.h
//  QFB
//
//  Created by qqq on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBAddressModel.h"

typedef void(^SetDefultBlock)(id model);
typedef void(^EditBlock)(id model);
typedef void(^DeleteBlock)(id model);


@interface QFBAddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *tel;

@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;



@property (nonatomic, copy) SetDefultBlock setDefultBlock;
@property (nonatomic, copy) EditBlock editBlock;
@property (nonatomic, copy) DeleteBlock deleteBlock;


@property (strong, nonatomic) QFBAddressModel *model;


-(void)setCellWithModel:(QFBAddressModel*)model;

@end






