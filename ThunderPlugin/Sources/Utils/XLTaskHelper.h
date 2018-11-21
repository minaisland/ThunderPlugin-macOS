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

+ (NSDictionary *)getTorrentInfo:(NSString *)torrentPath;

@end
