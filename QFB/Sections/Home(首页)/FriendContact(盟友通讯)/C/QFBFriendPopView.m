//
//  QFBFriendPopView.m
//  QFB
//
//  Created by qqq on 2018/9/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBFriendPopView.h"

@interface QFBFriendPopView()

@property (nonatomic, strong) NSArray *buttonTitleArray;
@property (nonatomic, strong) NSMutableArray<QFBRoleModel *> *myRoleArray;

@end

@implementation QFBFriendPopView

- (instancetype)initWithFrame:(CGRect)frame roles:(NSMutableArray<QFBRoleModel *> *)roleArray
{
    if (self = [super initWithFrame:frame]) {
        
        _myRoleArray = roleArray;
        
        UIView *bv = [[UIView alloc] initWithFrame:self.bounds];
        bv.backgroundColor = [UIColor blackColor];
        bv.alpha = 0.55;
        [self addSubview:bv];
        
        NSInteger rowH = 35;        // 每行行高
        NSInteger count = roleArray.count;
        int addNum = (count % 3) == 0 ? 0 : 1;
        if (count > 9) {
            count = 9;
        }
        CGFloat sh = rowH + (count / 3 + addNum) * rowH;
        UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(25, 2, 260, sh)];
        sc.contentSize = CGSizeMake(sc.mj_w, rowH + (roleArray.count / 3 + addNum) * rowH);
        sc.backgroundColor = [UIColor whiteColor];
        sc.layer.cornerRadius = 5;
        [self addSubview:sc];
        CGFloat bw = (sc.mj_w - 20) / 3;
        _buttonTitleArray = @[@"全部盟友",@"已实名",@"未实名"];
        for (int i = 0; i < _buttonTitleArray.count; i++) {
            UIButton *btn = [UIButton createButton:CGRectMake((5 + bw) * i + 5, 0, bw, rowH) targ:self sel:@selector(pressBtn:) titColor:[UIColor lightGrayColor] backGroundImage:nil title:_buttonTitleArray[i]];
            btn.tag = 100 + i;
            [sc addSubview:btn];
        }
        for (int i = 0; i < roleArray.count; i++) {
            UIButton *btn = [UIButton createButton:CGRectMake((5 + bw) * (i % 3) + 5, rowH + rowH * (i / 3), bw, rowH) targ:self sel:@selector(pressBtn:) titColor:[UIColor lightGrayColor] backGroundImage:nil title:roleArray[i].roleName];
            btn.tag = 200 + i;
            [sc addSubview:btn];
        }
        
        UIButton *bcBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sc.frame), self.mj_w, self.mj_h - CGRectGetMaxY(sc.frame))];
        [bcBtn addTarget:self action:@selector(pressDismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bcBtn];
        
        sc.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            sc.alpha = 1;
        }];
    }
    return self;
}

- (void)pressBtn:(UIButton *)btn
{
    if (!self.block) {
        return ;
    }
    if (btn.tag < 200) {
        self.block(_buttonTitleArray[btn.tag - 100]);
    }else{
        self.block(_myRoleArray[btn.tag - 200]);
    }
    [self pressDismiss];
}

- (void)pressDismiss
{
    [self removeFromSuperview];
}

- (void)dealloc
{
    [self.layer removeAllAnimations];
}

@end





