//
//  FileHelper.h
//  NewLonking
//
//  Created by 冯搏 on 14-8-30.
//  Copyright (c) 2014年 冯搏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject

/**
 删除图片

 @param fileName 图片名
 @param aPath 文件夹名
 */
+ (void)removeFileWithFileName:(NSString *)fileName documentPath:(NSString *)aPath;

/**
 获取文件目录

 @param documentName 文件目录名
 @return 获取文件目录路径成功返回路径，否则返回Nil
 */
+ (NSString *)getDocumentPathWithName:(NSString *)documentName;

/**
 存储文件到指定目录

 @param data 文件数据
 @param fileName 文件名
 @param aPath 文件夹名
 @return 存储成功返回 YES 否则返回NO
 */
+ (BOOL)storeFileToDocumentWithData:(NSData *)data andName:(NSString *)fileName andDocumentName:(NSString *)aPath;

/**
 读取文件内容

 @param fileName 文件名
 @param aPath 文件夹名
 @return 读取成功返回文件数据，否则Nil
 */
+ (NSData *)readFileFromDocumentsWithFileName:(NSString *)fileName andDocumentName:(NSString *)aPath;


/**
 归档

 @param obj 归档的OC对象
 @param aKey 归档的键值
 */
+ (void)archiveObject:(id)obj withKey:(NSString *)aKey;


/**
 反归档

 @param aKey 归档的键值
 @return 归档的对象
 */
+ (id)unArchiveObjectWithKey:(NSString *)aKey;
@end

