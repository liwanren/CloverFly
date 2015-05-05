//
//  LxFileManager.m
//  Demo
//
//  Created by CloverFly on 14-6-19.
//  Copyright (c) 2014年 CloverStudio. All rights reserved.
//

#import "LxFileManager.h"

@implementation LxFileManager
+ (NSString *)mainBundleDirectory
{
    return [NSBundle mainBundle].resourcePath;
}

+ (NSString *)cachesDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachePath = [paths firstObject];
	return cachePath;
}

+ (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths firstObject];
    return documentsDirectoryPath;
}

+ (NSString *)temporaryDirectory
{
    return NSTemporaryDirectory();
}

+ (NSString *)userFile
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"User"];
}

+ (BOOL)createFile:(NSData *)fileData atPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager createFileAtPath:path contents:fileData attributes:nil];
}

+ (BOOL)removeFileAtPath:(NSString *)path
{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:path error:&error];
}

+ (NSString *)contentsOfFileAtPath:(NSString *)path
{
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return content;
}
@end
