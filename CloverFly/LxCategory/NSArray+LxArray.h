//
//  NSArray+LxArray.h
/*
 //     ___ __   ____  _   _________
 //   / __// /  / __ \| | / / __/ _ \
 //  / /  / /_ / /_/ /| |/ / _// , _/
 // /___//____/\____/_\___/___/_/|_|
 // --------Created by clover--------
 */


#import <Foundation/Foundation.h>

@interface NSArray (LxArray)

/**
 *  返回数组的第一个节点
 *
 *  @return id
 */
- (id)firstObject;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (id)safeObjectAtIndex:(NSInteger)index;
// int排序
+ (NSArray *)sortNumArray:(NSArray *)array;

// 去掉重复元素
+ (NSArray *)getUnduplicatedElement:(NSArray *)array;

// 元素逆序
+ (NSArray *)reverseArray:(NSArray *)array;


@end
