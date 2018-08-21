//
//  QFBInvitingBottomView.m
//  QFB
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBInvitingBottomView.h"
#import "QFBInvitingBottomCell.h"
#import "UIView+DCExtension.h"

@interface QFBInvitingBottomView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *button_upAndDown;

@end

@implementation QFBInvitingBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.button_upAndDown];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)pressBtn:(UIButton *)btn
{
    if (btn.isSelected) {
        btn.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.collectionView.mj_y = self.mj_h;
            self.button_upAndDown.mj_y = self.mj_h - self.button_upAndDown.mj_h;
        }];
    }else{
        btn.selected = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.collectionView.mj_y = self.mj_h - self.collectionView.mj_h;
            self.button_upAndDown.mj_y = self.mj_h - self.collectionView.mj_h - self.button_upAndDown.mj_h;
        }];
    }
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.mj_h, self.mj_w, self.mj_w * 500 / 1650) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [_collectionView registerNib:[UINib nibWithNibName:@"QFBInvitingBottomCell" bundle:nil] forCellWithReuseIdentifier:@"QFBInvitingBottomCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UIButton *)button_upAndDown
{
    if (!_button_upAndDown) {
        _button_upAndDown = [[UIButton alloc] initWithFrame:CGRectMake(0, self.mj_h - 40, 60, 40)];
        _button_upAndDown.dc_centerX = self.dc_width / 2;
        [_button_upAndDown setImage:[UIImage imageNamed:@"我的更多"] forState:UIControlStateNormal];
        [_button_upAndDown setImage:[UIImage imageNamed:@"white_return_icon"] forState:UIControlStateSelected];
        [_button_upAndDown addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        _button_upAndDown.backgroundColor = [UIColor lightGrayColor];
    }
    return _button_upAndDown;
}

#pragma mark collectionView代理方法
////返回section个数
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 3;
//}
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QFBInvitingBottomCell *cell = [QFBInvitingBottomCell initWithCollectionView:collectionView indexPath:indexPath model:nil];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((collectionView.mj_h - 20) * 335 / 500, collectionView.mj_h - 20);
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
}


@end





