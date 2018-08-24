//
//  FBUpdateApp.h
//  FBFramework
//
//  Created by BoFeng on 2017/11/2.
//  Copyright © 2017年 冯搏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBUpdateApp : NSObject
+(void)fb_updateWithAPPID:(NSString *)appid block:(void(^)(NSString *currentVersion,NSString *storeVersion, NSString *openUrl,BOOL isUpdate))block;
@end
