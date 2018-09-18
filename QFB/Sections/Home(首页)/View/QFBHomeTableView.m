//
//  QFBHomeTableView.m
//  QFB
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeTableView.h"
#import "QFBHomeTitleTableViewCell.h"
#import "QFBHomeHotRecommendedTableViewCell.h"
#import "QFBHomeRecentActivitiesTableViewCell.h"

@interface QFBHomeTableView () <UITableViewDataSource,UITableViewDelegate>


@end

@implementation QFBHomeTableView

/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
//        if (!self.dataArray) {
//            self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"个人收益",@"icon":@"个人",},
//                                                              @{@"title":@"团队收益",@"icon":@"团队",},
//                                                              @{@"title":@"品牌收益",@"icon":@"团队收益",}]];
//        }
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01f;
    }else
        return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 44;
        }else
            return 96;
    }else
    {
        if (indexPath.row == 0) {
            return 44;
        }else
            return 77;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
        {
            QFBHomeTitleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"QFBHomeTitleTableViewCell"];
            if (cell == nil) {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"QFBHomeTitleTableViewCell" owner:self options:nil]lastObject];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else
        {
            QFBHomeHotRecommendedTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"QFBHomeHotRecommendedTableViewCell"];
            if (cell == nil) {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"QFBHomeHotRecommendedTableViewCell" owner:self options:nil]lastObject];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
    }else
    {
        if (indexPath.row == 0)
        {
            QFBHomeTitleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"QFBHomeTitleTableViewCell"];
            if (cell == nil) {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"QFBHomeTitleTableViewCell" owner:self options:nil]lastObject];
            }
            cell.titleStr.text = @"近期活动";
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else
        {
            QFBHomeRecentActivitiesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"QFBHomeRecentActivitiesTableViewCell"];
            if (cell == nil) {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"QFBHomeRecentActivitiesTableViewCell" owner:self options:nil]lastObject];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
    }
    
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
