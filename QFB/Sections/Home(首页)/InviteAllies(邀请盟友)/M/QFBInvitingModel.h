//
//  QFBInvitingModel.h
//  QFB
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBInvitingListModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *url;        //  图片路径
@property (nonatomic, strong) NSString *remarks;    //  移动二维码样式
@property (nonatomic, strong) NSString *reserve;    //  移动推荐人一块的样式

@end

@interface QFBInvitingModel : NSObject

@property (nonatomic, strong) NSString *appKey;     // <null>,
@property (nonatomic, strong) NSString *content;    // @property (nonatomic, strong) NSString *扫一扫下方二维码，加入支付联盟@property (nonatomic, strong) NSString *,
@property (nonatomic, strong) NSString *remarks;    // <null>,
@property (nonatomic, strong) NSString *ID;         // <null>,
@property (nonatomic, strong) NSString *value;      // http://122.114.248.156:8888/group1/M00/00/04/enL4nFtoF86AXCGuAAFZSK_4JTI632.png
@property (nonatomic, strong) NSString *reserve;    // <null>,
@property (nonatomic, strong) NSString *oBrandId;   // <null>,
@property (nonatomic, strong) NSString *name;       // <null>,
@property (nonatomic, strong) NSString *url;        // <null>
@property (nonatomic, strong) NSMutableArray<QFBInvitingListModel *> *list;

@end
