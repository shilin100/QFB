//
//  QFBTool.m
//  QFB
//
//  Created by qqq on 2018/8/6.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBTool.h"
#import "TabbarItemAttributesModel.h"
#import "UICKeyChainStore.h"

@implementation QFBTool

+(NSString *) getUUID {
    
    NSString * bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:bundleIdentifier];
    NSString * uuid;
    if ([keychain stringForKey:@"imeiKeyChain"] != nil) {
        uuid = [keychain stringForKey:@"imeiKeyChain"];
    }else {
        uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString] ;
        keychain[@"imeiKeyChain"] = uuid;
    }
    
    return uuid;
}


+(NSString *)getClassNameFromModule:(NSString *)module{
    NSDictionary* moduleToClassName = [QFBTool getAllModuleClassNameDictionary];
    if (moduleToClassName[module] == nil) {
        CXLog(@"模块名与参数名不符");
        return nil;
    }
    return moduleToClassName[module];
}

+(NSDictionary * )getAllModuleClassNameDictionary{
    return @{
             @"首页":@"QFBHomeController",
//             @"首页":@"QFBHomeViewController",
             @"盟友":@"QFBAllianceViewController",
             @"收益":@"QFBEarningViewController",
             @"我的":@"QFBMineViewController"
             };
}

+(NSArray*)getDefaultModules{
    return @[@"首页",@"盟友",@"收益",@"我的"];
}

+(NSDictionary*)getAllTabbarItemAttributes{
//    return @{
//             @"首页":[TabbarItemAttributesModel AttributesToolTitle:@"首页" imageName:@"首页未选中" selectedImageName:@"首页选中"],
//             @"盟友":[TabbarItemAttributesModel AttributesToolTitle:@"盟友" imageName:@"parterner_unselected" selectedImageName:@"盟友选中"],
//             @"收益":[TabbarItemAttributesModel AttributesToolTitle:@"收益" imageName:@"收益未选中" selectedImageName:@"收益选中"],
//             @"我的":[TabbarItemAttributesModel AttributesToolTitle:@"我的" imageName:@"mine_unselected" selectedImageName:@"我的选中"]
//             };;
    return @{
             @"首页":[TabbarItemAttributesModel AttributesToolTitle:@"首页" imageName:@"首页-2" selectedImageName:@"首页-1"],
             @"盟友":[TabbarItemAttributesModel AttributesToolTitle:@"盟友" imageName:@"联盟-2" selectedImageName:@"联盟-1"],
             @"收益":[TabbarItemAttributesModel AttributesToolTitle:@"收益" imageName:@"收益-2" selectedImageName:@"收益-1"],
             @"我的":[TabbarItemAttributesModel AttributesToolTitle:@"我的" imageName:@"我的-2" selectedImageName:@"我的-1"]
             };;
}


@end
