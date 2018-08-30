//
//  QFBDrawMoneyCollectionView.m
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBDrawMoneyCollectionView.h"
#import "QFBDrawMoneyLayout.h"
#import "QFBDrawMoneyCell.h"
#import "DCSpeedy.h"

@interface QFBDrawMoneyCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<QFBDrawMoneyCellModel *> *dataArray;

@end

@implementation QFBDrawMoneyCollectionView

//CGRectMake(0, 0, screen_width, 228);
- (instancetype)initWithFrame:(CGRect)frame
{
    QFBDrawMoneyLayout *layout = [[QFBDrawMoneyLayout alloc] init];
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        [self setDelegate:self];
        [self setDataSource:self];
        [self registerNib:[UINib nibWithNibName:@"QFBDrawMoneyCell" bundle:nil] forCellWithReuseIdentifier:@"QFBDrawMoneyCell"];
    }
    return self;
}

- (double)getCanDrawMoney
{
    if (self.dataArray.count != 3) {
        return 0;
    }
    int index = [self getCurrentIndex];
    return self.dataArray[index].useMoney;
}

- (int)getCurrentIndex
{
    int index = 0;
    if (self.indexPathsForVisibleItems.count == 3) {
        index = 1;
    }else{
        if (self.indexPathsForVisibleItems.firstObject.row == 0 || self.indexPathsForVisibleItems.lastObject.row == 0 ) {
            index = 0;
        }else{
            index = 2;
        }
    }
    return index;
}

- (void)loadDrawMoneyListModel:(QFBDrawMoneyListModel *)model
{
    [self.dataArray removeAllObjects];
    
    QFBDrawMoneyCellModel *model0 = [[QFBDrawMoneyCellModel alloc] init];
    model0.returnMode   = @"激活返现";
    model0.setMode      = model.activeStatus;
    model0.allMoney     = model.allActive;
    if (model.activeStatus == 0) {  //  妙结
        model0.frozenMoney  = 0;
        model0.useMoney     = model.active;
    }else{
        if (model.activeTime >= [DCSpeedy getCurrentNumberTime]) {  //  过了月结时间可以提款
            model0.frozenMoney  = 0;
            model0.useMoney     = model.active;
        }else{
            model0.frozenMoney  = model.active;
            model0.useMoney     = 0;
        }
    }
    
    QFBDrawMoneyCellModel *model1 = [[QFBDrawMoneyCellModel alloc] init];
    model1.returnMode   = @"升级代理返现";
    model1.setMode      = model.recommendStatus;
    model1.allMoney     = model.allRecommend;
    if (model.recommendStatus == 0) {  //  妙结
        model1.frozenMoney  = 0;
        model1.useMoney     = model.recommend;
    }else{
        if (model.recommendTime >= [DCSpeedy getCurrentNumberTime]) {  //  过了月结时间可以提款
            model1.frozenMoney  = 0;
            model1.useMoney     = model.recommend;
        }else{
            model1.frozenMoney  = model.recommend;
            model1.useMoney     = 0;
        }
    }
    
    QFBDrawMoneyCellModel *model2 = [[QFBDrawMoneyCellModel alloc] init];
    model2.returnMode   = @"分润返现";
    model2.setMode      = model.profitStatus;
    model2.allMoney     = model.allProfit;
    if (model.profitStatus == 0) {  //  妙结
        model2.frozenMoney  = 0;
        model2.useMoney     = model.profit;
    }else{
        if (model.profitTime >= [DCSpeedy getCurrentNumberTime]) {  //  过了月结时间可以提款
            model2.frozenMoney  = 0;
            model2.useMoney     = model.profit;
        }else{
            model2.frozenMoney  = model.profit;
            model2.useMoney     = 0;
        }
    }
    [self.dataArray addObject:model0];
    [self.dataArray addObject:model1];
    [self.dataArray addObject:model2];
    [self reloadData];
}

#pragma mark - collectionView Delegate
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QFBDrawMoneyCell *cell = [QFBDrawMoneyCell initWithCollectionView:collectionView indexPath:indexPath model:self.dataArray[indexPath.row]];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(172, 207);
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    NSInteger itemCount = [self collectionView:collectionView numberOfItemsInSection:section];
    
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    CGSize firstSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:firstIndexPath];
    
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:itemCount - 1 inSection:section];
    CGSize lastSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:lastIndexPath];
    
    return UIEdgeInsetsMake(0, (collectionView.bounds.size.width - firstSize.width) / 2,
                            0, (collectionView.bounds.size.width - lastSize.width) / 2);
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

- (NSMutableArray<QFBDrawMoneyCellModel *> *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end







