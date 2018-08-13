//
//  QFBEarningTableViewCell.h
//  QFB
//
//  Created by qqq on 2018/8/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFBEarningTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleIcon;

-(void)setTitleAndIcon:(NSDictionary*)dic;

@end
