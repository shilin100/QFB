//
//  CustomTabbarTool.m
//  ZhiFa
//
//  Created by Exsun on 16/8/10.
//  Copyright © 2016年 wei. All rights reserved.
//

#import "CustomTabbarTool.h"
#import "TabbarItemAttributesModel.h"

@interface CustomTabbarTool ()

@property (nonatomic,strong)  NSDictionary * moduleToClassName;

@end

@implementation CustomTabbarTool
-( NSArray *)getTabbarControllersByModules:(NSArray *)modules{
//    if (modules == nil) {
//        modules                         = @[@"查车",@"查工地",@"任务"];
//    }
    NSMutableArray * temp           = [[NSMutableArray alloc ]init];
    for (NSString* str in modules) {
        QFBBaseNaviViewController *naviVC  = [self ControllerByModule:str];
        [temp addObject:naviVC];
    }
    
    
    return temp;
}

//创建NaviVC
-(QFBBaseNaviViewController*)ControllerByModule:(NSString*)module{
    Class class                     = NSClassFromString(self.moduleToClassName[module]);
    UIViewController *vc            = [[class alloc] init];
    QFBBaseNaviViewController *naviVC  = [[QFBBaseNaviViewController alloc]
                                       initWithRootViewController:vc];
    return naviVC;
}


-( NSArray *)getTabbarItemAttributesByModules:(NSArray *)modules{

    NSMutableArray * temp = [[NSMutableArray alloc ]init];
    for (NSString * str in modules) {
        [temp addObject:[self getTabbarItemAttributesByModule:str]];
    }
    NSArray * tabBarItemsAttributes = [temp copy];
    return tabBarItemsAttributes;
}



-(NSDictionary *)getTabbarItemAttributesByModule:(NSString *)module{
    NSDictionary * dic= [QFBTool getAllTabbarItemAttributes];
    TabbarItemAttributesModel * tool    = dic[module];
    NSDictionary *tabBarItemsAttribute  = @{
                                            //
                                            CYLTabBarItemTitle : tool.title,
                                            CYLTabBarItemImage : tool.imageName,
                                            CYLTabBarItemSelectedImage : tool.selectedImageName
                                            };
    return tabBarItemsAttribute;
}



//写死的模块名对应类名
- (NSDictionary *)moduleToClassName {
    if(_moduleToClassName == nil) {
        _moduleToClassName = [QFBTool getAllModuleClassNameDictionary];
    }
    return _moduleToClassName;
}


@end
