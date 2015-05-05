//
//  LxFileManager.h
//  Demo
//
//  Created by CloverFly on 14-6-19.
//  Copyright (c) 2014年 CloverStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LxFileManager : NSObject
/**
 *  应用程序主句柄
 *
 *  @return 句柄
 */
+ (NSString *)mainBundleDirectory;

/**
 *  缓存路径
 *
 *  @return 缓存路径
 */
+ (NSString *)cachesDirectory;

/**
 *  文档路径
 *
 *  @return 文档路径
 */
+ (NSString *)documentsDirectory;

/**
 *  临时路径
 *
 *  @return 临时路径
 */
+ (NSString *)temporaryDirectory;

/**
 *  用户文件
 *
 *  @return 用户文件
 */
+ (NSString *)userFile;


/**
 *  创建文件
 *
 *  @param fileData 文件数据
 *  @param path     文件路径
 *
 *  @return 成功与否
 */
+ (BOOL)createFile:(NSData *)fileData atPath:(NSString *)path;

/**
 *  移除文件
 *
 *  @param path 文件路径
 *
 *  @return 成功与否
 */
+ (BOOL)removeFileAtPath:(NSString *)path;

+ (NSString *)contentsOfFileAtPath:(NSString *)path;
@end
