//
//  UnitilMacro.h
//  QFB
//
//  Created by qqq on 2018/8/6.
//  Copyright © 2018年 qqq. All rights reserved.
//

#ifndef UnitilMacro_h
#define UnitilMacro_h

#ifdef DEBUG
#define CXLog(...) NSLog(@"%s 行号：%d \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define CXLog(...)
#endif



#define kSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kDefault [NSUserDefaults standardUserDefaults]
/**AppDelegate*/
#define APPLication [UIApplication sharedApplication]
/**字体*/
#define XFont(a) [UIFont systemFontOfSize:a]
#define XBFont(a) [UIFont boldSystemFontOfSize:a]
/**图片*/
#define IMAGENAME(a) [UIImage imageNamed:a]
/**document路径*/
#define DOC_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
/**颜色*/
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HEXCOLOR_ALPHA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define IS_STR_EMPTY(str) (str == nil || [str isEqual:[NSNull null]] || str.length <= 0)
#define IS_OBJECT_EMPTY(obj) (obj == nil || [obj isEqual:[NSNull null]])


//====
//////////////////////IM 聊天用通知 //////////////////////////////////////////////
#define IM_Send_CheckReport_Notification @"send check report notification"

/////////////////////////////////////////////////////////////////////////////////
#define Document_Image @"ImageDocument" //图片文件夹
#define Document_UserDetail @"documentUserDetail"  //用户信息文件夹 该文件夹只收集用户帐户信息
#define Diary_Document @"diaryDocument" //日记保存目录

#define OBJ_EMPTY_OR_OBJ(obj) IS_OBJECT_EMPTY(obj) ? @"" : obj
#define Magic_Number 1000000000

//#define UserHeadKey @"user_head"
//#define UserNickNameKey @"user_NickName"
//#define UserNameKey @"user_name"
//#define UserPasswordKey @"user_password"
//#define UserTokenKey @"user_token"


#define SelectAreaIdKey @"select_areaId"
#define cn_word_regix @"[\u4e00-\u9fa5]"
#define LBXScan_Define_Native  //下载了native模块
#define LBXScan_Define_UI     //下载了界面模块

//***************************AES加密********************
#define AESKEY @"db0bf515044b1bf3"
#define PARAMDICKEY @"cipher"


//＊＊＊＊＊＊＊＊＊＊＊＊＊默认图片＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
#define Default_Circle_Icon @"avator_icon"
//#define Default_Goods_Icon @"default_icon_goods"
#define Default_banner_Icon @"default_banner"
//＊＊＊＊＊＊＊＊＊＊＊＊＊＊


//*************************分享************************
#define ShareSDK_App_key @"15a5ba0007ec0"  //shareSDK key
#define QQ_App_ID @"101437149"
#define QQ_App_Key @"baGMm1mVjz3W4bhM"

//**************************支付宝支付*****************************

#define AliPay_App_Partner @"2088721450297812"
//#define AliPay_App_Seller @"327757110@qq.com"
#define AliPay_Charge_Success 9000

//**************************百度地图****************************************

#define BaiDu_App_Key @"GzZxxAPlTExAKB52G8wf4PeGvWAMt7sW"

//*******************************************************************
#define IOS_VERSION  ([[[UIDevice currentDevice] systemVersion] doubleValue])

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define textScale [UIScreen mainScreen].bounds.size.height / 667.
#define textWidthScale [UIScreen mainScreen].bounds.size.width / 375.
#define testH5Header @"http://cal.cs.dajianhui.com/"
#define APP_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define StringValue(x) [NSString stringWithFormat:@"%@",x]

#define rgbaColor(r,g,b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]

#define WEAKSELF typeof(self) __weak weakSelf = self

//判断iphone4/4s
#define iPhone4_4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone5/5s
#define iPhone5_5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone6P
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphoneX
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

#define SafeAreaTopHeight ([UIScreen mainScreen].bounds.size.height == 812.0 ? 88 : 64)
#define SafeAreaBottomHeight ([UIScreen mainScreen].bounds.size.height == 812.0 ? 83 : 49)

///weakSelf
#define CZHWeakSelf(type)  __weak typeof(type) weak##type = type;
#define CZHStrongSelf(type)  __strong typeof(type) type = weak##type;

/**屏幕宽度*/
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
/**屏幕高度*/
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)


/**全局字体*/
#define CZHGlobelNormalFont(__VA_ARGS__) ([UIFont systemFontOfSize:CZH_ScaleFont(__VA_ARGS__)])

/**宽度比例*/
#define CZH_ScaleWidth(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375)*(__VA_ARGS__)

/**高度比例*/
#define CZH_ScaleHeight(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.height/667)*(__VA_ARGS__)

/**字体比例*/
#define CZH_ScaleFont(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375)*(__VA_ARGS__)

/**颜色*/
#define CZHColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define CZHRGBColor(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define CZHThemeColor (CZHColor(0xff0000))

#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...)
#endif

#define OBJ_EMPTY_OR_OBJ(obj) IS_OBJECT_EMPTY(obj) ? @"" : obj


//====

#endif /* UnitilMacro_h */
