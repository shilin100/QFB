//
//  DCSpeedy.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DCSpeedy.h"

@implementation DCSpeedy

+ (NSString *)getNowTimestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970] * 1000];
    return timeSp;
}

+ (BOOL)isPrice:(NSString *) price {
    NSString *format =@"([1-9]([0-9]+)?(.[0-9]{1,2})?$)|((0){1}$)|(^[0-9].0-9?$)";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", format];
    if ([regextest evaluateWithObject:price] == YES)
        return YES;
    else
        return NO;
}

//获取当地时间
+ (int)getCurrentNumberTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return [dateTime intValue];
}

//获取当前月份
+ (int)getCurrentMonthTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return [dateTime intValue];
}

#pragma mark - base64图片转编码
+ (NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

+(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr
{
    NSData *_decodedImageData = [[NSData alloc] initWithBase64EncodedString:_encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}


/**
 获取二维码图片
 */
+ (UIImage *)dc_getQRCode:(NSString *)url size:(CGFloat)size
{
    if (url == nil) {
        url = @"没有可用的数据";
    }
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //给过滤器添加数据
    NSString *string = url;
    //将NSString格式转化成NSData格式
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKeyPath:@"inputMessage"];
    //获取二维码过滤器生成的二维码
    CIImage *image = [filter outputImage];
    return [DCSpeedy createNonInterpolatedUIImageFormCIImage:image withSize:size];
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}



#pragma mark - 获取当前屏幕显示的VC
+ (UIViewController *)dc_getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    }else if([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    }else{
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

/**
 判断一个字符串是纯数字
 */
+ (BOOL)dc_getIsPureNum:(NSString *)text
{
    if (!text) {
        return NO;
    }
    NSScanner *scan = [NSScanner scannerWithString:text];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - 固定宽度和字体大小，获取label的frame
+ (CGFloat)dc_getSizeWithStr:(NSString *) str Width:(float)width Font:(float)fontSize
{
    NSDictionary * attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGSize tempSize = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attribute
                                        context:nil].size;
    return tempSize.height;
}

/**
 *改变字符串中具体某字符串的颜色
 */
+ (void)dc_messageAction:(UILabel *)theLab changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize {
    NSString *tempStr = theLab.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    [strAtt addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, [strAtt length])];
    NSRange markRange = [tempStr rangeOfString:change];
    [strAtt addAttribute:NSForegroundColorAttributeName value:markColor range:markRange];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:fontSize] range:markRange];
    theLab.attributedText = strAtt;
}


@end




