//
//  QFBHomeListCell.h
//  QFB
//
//  Created by qqq on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QFBHomeListCell : UITableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView model:(NSMutableArray<QFBHomeListModel *> *)listArray;

@end
