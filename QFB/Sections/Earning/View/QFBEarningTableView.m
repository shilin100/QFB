//
//  QFBEarningTableView.m
//  QFB
//
//  Created by qqq on 2018/8/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBEarningTableView.h"
#import "QFBEarningTableViewCell.h"
@interface QFBEarningTableView () <UITableViewDataSource,UITableViewDelegate>


@end

@implementation QFBEarningTableView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        if (!self.dataArray) {
            self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"个人收益",@"icon":@"个人",},
                                                              @{@"title":@"团队收益",@"icon":@"团队2",},
                                                              @{@"title":@"品牌收益",@"icon":@"团队收益",}]];
        }
        [self configView];
    }
    return self;

}

static NSString * const EarningTableViewCellIdentifier = @"earningTableViewCell";

-(void)configView{
    self.delegate               = self;
    self.dataSource             = self;
//    self.tableFooterView = [UIView new];
//    self.scrollEnabled = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"QFBEarningTableViewCell" bundle:nil] forCellReuseIdentifier:EarningTableViewCellIdentifier];
    
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
    

    QFBEarningTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:EarningTableViewCellIdentifier forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[QFBEarningTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EarningTableViewCellIdentifier];
//    }
    [cell setTitleAndIcon:self.dataArray[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dic = self.dataArray[indexPath.row];
    [self.viewModel.earningCellCommand execute:dic[@"title"]];

}





@end
