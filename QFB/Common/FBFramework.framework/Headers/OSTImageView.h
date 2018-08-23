//
//  OSTImageView.h
//  onestong
//
//  Created by 冯搏 on 14-4-26.
//  Copyright (c) 2014年 冯搏. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const OSTIMAGEVIEW_PICKIMAGE_NOTIFICATION = @"pick ostimage notification";
static NSString * const OSTIMAGEVIEW_SHOWIMAGE_NOTIFICATION = @"show ostimage on another controller";

typedef void (^PhotoImageViewClicked)(UIImageView *imageView);

@interface OSTImageView : UIImageView

@property (nonatomic, copy) NSArray *mapInfoAry;
@property (nonatomic) BOOL imageSetted;
@property (nonatomic, copy) NSString *imageName;


/**
 查看大图 (在使用该方法时请确保您的视图刚刚初始化)
 */
- (void)registTapGestureShowImage;

/**
 当点击图片时调用

 @param aBlock 点击图片
 */
- (void)photoimageViewClicked:(PhotoImageViewClicked)aBlock;


/**
 图片压缩

 @param image 图片
 @return 图片二进制数据
 */
+(NSData*)compressImage:(UIImage*)image;
@end
