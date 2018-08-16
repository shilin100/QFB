//
//  QFBMineTableView.m
//  QFB
//
//  Created by qqq on 2018/8/16.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMineTableView.h"
@interface QFBMineTableView () <UITableViewDataSource,UITableViewDelegate>


@end

@implementation QFBMineTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        if (!self.dataArray) {
            self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"我的订单",@"icon":@"我的－订单",},
                                                              @{@"title":@"我的收货地址",@"icon":@"我的地址",},
                                                              @{@"title":@"代理协议",@"icon":@"代理协议",},
                                                              @{@"title":@"版本检测",@"icon":@"检测",},
                                                              @{@"title":@"我的专属客服",@"icon":@"我的专属客服",}]];
        }
        [self configView];
    }
    return self;
    
}
static NSString * const MineTableViewCellIdentifier = @"mineTableViewCell";

-(void)configView{
    self.delegate               = self;
    self.dataSource             = self;
    self.tableFooterView = [UIView new];
    self.scrollEnabled = NO;
//    self.separatorStyle = UITableViewCellSeparatorStyleNone;

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MineTableViewCellIdentifier];
    
    if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MineTableViewCellIdentifier];
        }
    cell.textLabel.font = XFont(17);
    cell.imageView.contentMode = UIViewContentModeCenter;
    cell.backgroundColor = HEXCOLOR(0xF6F3F3);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary * model = self.dataArray[indexPath.row];
    
    cell.textLabel.text = model[@"title"];
    cell.imageView.image = [UIImage imageNamed:model[@"icon"]];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dic = self.dataArray[indexPath.row];
    [self.viewModel.mineCellCommand execute:dic[@"title"]];
}

@end
