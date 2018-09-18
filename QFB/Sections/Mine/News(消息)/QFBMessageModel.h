//
//  QFBMessageModel.h
//  QFB
//
//  Created by qqq on 2018/9/18.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBaseModel.h"

@interface QFBMessageModel : QFBBaseModel

@property(nonatomic,strong) NSString  * userId;
@property(nonatomic,strong) NSString  * content;
@property(nonatomic,strong) NSString  * billDetailId;
@property(nonatomic,strong) NSString  * ID;
@property(nonatomic,strong) NSString  * modifyTime;
@property(nonatomic,strong) NSString  * remarks;
@property(nonatomic,strong) NSString  * type;
@property(nonatomic,strong) NSString  * createTime;

@end


