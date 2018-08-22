//
//  QFBAllianceTableView.m
//  QFB
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAllianceTableView.h"
#import "QFBAllianceTeamTableViewCell.h"
#import "QFBAllianceDirectlyTableViewCell.h"

@interface QFBAllianceTableView () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation QFBAllianceTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        self.dataArray = [NSMutableArray arrayWithObjects:@"团队",@"直营", nil];
        [self configView];
    }
    return self;
    
}
-(void)configView{
    
    self.delegate               = self;
    self.dataSource             = self;
    self.tableFooterView = [UIView new];
    self.scrollEnabled = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 137;
    }else
        return 137;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        QFBAllianceTeamTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"QFBAllianceTeamTableViewCell"];
        if (cell == nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"QFBAllianceTeamTableViewCell" owner:self options:nil]lastObject];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else
    {
        QFBAllianceDirectlyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"QFBAllianceDirectlyTableViewCell"];
        if (cell == nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"QFBAllianceDirectlyTableViewCell" owner:self options:nil]lastObject];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.viewModel.earningCellCommand execute:self.dataArray[indexPath.row]];
}


@end
