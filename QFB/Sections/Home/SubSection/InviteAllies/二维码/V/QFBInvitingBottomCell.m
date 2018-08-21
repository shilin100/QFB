//
//  QFBInvitingBottomCell.m
//  QFB
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBInvitingBottomCell.h"

@interface QFBInvitingBottomCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV_back;

@end

@implementation QFBInvitingBottomCell

+ (instancetype) initWithCollectionView:(UICollectionView *)cv indexPath:(NSIndexPath *)path model:(id)model
{
    QFBInvitingBottomCell *cell = [cv dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:path];
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end




