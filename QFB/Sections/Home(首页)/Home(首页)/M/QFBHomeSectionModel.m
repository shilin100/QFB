//
//  QFBHomeSectionModel.m
//  QFB
//
//  Created by qqq on 2018/9/8.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeSectionModel.h"


@implementation QFBHomeSectionModel

- (NSMutableArray<QFBHomeCellModel *> *)cellArray
{
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

@end
