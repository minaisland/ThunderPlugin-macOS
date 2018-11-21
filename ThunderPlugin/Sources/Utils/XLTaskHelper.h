//
//  XLTaskHelper.h
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/20.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLTaskHelper : NSObject

/**
 从下载地址解析出文件名
 
 @param urlString 原始下载地址
 @return 解析结果的文件名
 */
+ (NSString *)parseFilenameFromUrl:(NSString *)urlString;

+ (id)createXLURLTaskWithURL:(NSString *)urlString;

+ (int)createTaskWithURL:(NSString *)urlString;

+ (void)parseMagnet:(NSString *)urlString;

/**
 读取种子文件中的下载列表信息（该方法有线程阻塞的调用，需要在异步方法中执行）
 
 @param torrentPath 种子路径
 @return 下载列表信息
 */
+ (NSDictionary *)getTorrentInfo:(NSString *)torrentPath;

@end
