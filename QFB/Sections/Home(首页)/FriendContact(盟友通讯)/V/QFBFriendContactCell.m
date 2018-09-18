//
//  QFBFriendContactCell.m
//  QFB
//
//  Created by qqq on 2018/9/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBFriendContactCell.h"

@interface QFBFriendContactCell()

@property (weak, nonatomic) IBOutlet UIImageView *image_user;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_relation;
@property (nonatomic, weak) QFBUserModel *myUserModel;

@end

@implementation QFBFriendContactCell

+ (instancetype)initWithTableView:(UITableView *)tableView model:(QFBUserModel *)model
{
    static NSString *cellID = @"QFBFriendContactCell";
    QFBFriendContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label_relation.layer.cornerRadius = 5;
        cell.label_relation.layer.borderWidth = 1;
        cell.label_relation.layer.borderColor = [UIColor redColor].CGColor;
    }
    [cell loadUserModel:model];
    return cell;
}

- (void)loadUserModel:(QFBUserModel *)model
{
    _myUserModel = model;
    if (LMJIsEmpty(model.realName)) {
        _label_name.text = @"普通用户";
    }else{
        _label_name.text = model.realName;
    }
    _label_relation.text = [NSString stringWithFormat:@" %@  ",model.reserve];
    [_image_user sd_setImageWithURL:[NSURL URLWithString:model.userPicture] placeholderImage:[UIImage imageNamed:@"userImage"]];
}

- (IBAction)pressPhone:(id)sender {
    if (LMJIsEmpty(_myUserModel.phone)) {
        [SVProgressHUD showInfoWithStatus:@"该盟友尚未完善手机号!"];
        [SVProgressHUD dismissWithDelay:1];
        return;
    }
    UIWebView * callWebview = [[UIWebView alloc]init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_myUserModel.phone]]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
