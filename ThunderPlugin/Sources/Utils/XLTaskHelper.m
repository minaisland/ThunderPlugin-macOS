//
//  XLTaskHelper.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/20.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "XLTaskHelper.h"
#import "ThunderPlugin.h"
#import <objc/runtime.h>
#import "TaskManager.h"

@implementation XLTaskHelper

+ (id)defaultXLTaskFactory {
    return [objc_getClass("XLTaskFactory") performSelector:@selector(defaultFactory)];
}

/**
 从下载地址解析出文件名
 
 @param urlString 原始下载地址
 @return 解析结果的文件名
 */
+ (NSString *)parseFilenameFromUrl:(NSString *)urlString {
    return [objc_getClass("DownloadHelper") performSelector:@selector(parseFilenameFromUrl:) withObject:urlString];
}

+ (NSString *)decodeThunderUrl:(NSString *)urlString {
    return [objc_getClass("DownloadHelper") performSelector:@selector(decodeThunderUrl:) withObject:urlString];
}

+ (NSString *)replaceEd2kUrl:(NSString *)urlString {
    return [objc_getClass("DownloadHelper") performSelector:@selector(replaceEd2kUrl:) withObject:urlString];
}

+ (BOOL)isThunderUrlScheme:(NSString *)urlString {
    return (BOOL)[objc_getClass("DownloadHelper") performSelector:@selector(isThunderUrlScheme:) withObject:urlString];
}

+ (BOOL)isEmuleUrlScheme:(NSString *)urlString {
    return (BOOL)[objc_getClass("DownloadHelper") performSelector:@selector(isEmuleUrlScheme:) withObject:urlString];
}

+ (BOOL)isMagnetUrlScheme:(NSString *)urlString {
    return (BOOL)[objc_getClass("DownloadHelper") performSelector:@selector(isMagnetUrlScheme:) withObject:urlString];
}

+ (void)parseMagnet:(NSString *)urlString {
    NSString *tmpPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"torrents"];
    id task = [objc_getClass("XLURLTask") performSelector:@selector(taskWithURL:taskName:) withObject:urlString withObject:nil];
    [task performSelector:@selector(setDownloadPath:) withObject:tmpPath];
    int (^block)(int, int) = ^(int x, int y) {
        int result = x + y;
        return result;
    };
    [objc_getClass("XLTaskCreateHelper") performSelector:@selector(createTask:withBlock:) withObject:task withObject:block];
}

/**
 读取种子文件中的下载列表信息（该方法有线程阻塞的调用，需要在异步方法中执行）

 @param torrentPath 种子路径
 @return 下载列表信息
 */
+ (FKTorrentModel *)getTorrentInfo:(NSString *)torrentPath {
    __block NSDictionary *torrentInfo;
    dispatch_group_t group = dispatch_group_create();
    void (^block)(NSDictionary *) = ^(NSDictionary *info) {
        torrentInfo = info;
        dispatch_group_leave(group);
    };
    id etmApiShared = [objc_getClass("EtmApi") performSelector:@selector(sharedInstance)];
    [etmApiShared performSelector:@selector(getTorrentInfo:withBlock:) withObject:torrentPath withObject:block];
    dispatch_group_enter(group);
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    return [[FKTorrentModel alloc] initWithDictionary:torrentInfo];
}

+ (id)createXLURLTaskWithURL:(NSString *)urlString {
    NSString *originUrl;
    if ([self isThunderUrlScheme:urlString]) {
        originUrl = [self decodeThunderUrl:urlString];
    } else if ([self isEmuleUrlScheme:urlString]) {
        originUrl = [self replaceEd2kUrl:urlString];
    }
    NSString *filename = [self parseFilenameFromUrl:originUrl];
    return [objc_getClass("XLURLTask") performSelector:@selector(taskWithURL:taskName:) withObject:originUrl withObject:filename];
}

+ (int)createTaskWithURL:(NSString *)urlString {
    id task = [self createXLURLTaskWithURL:urlString];
    if (task) {
        [task performSelector:@selector(setDownloadPath:) withObject:@"~/Downloads"];
        [self.defaultXLTaskFactory performSelector:@selector(controller:deliverTask:withOptions:) withObject:nil withObject:task];
    }
    
//    SEL mySelector = @selector(controller:deliverTask:withOptions:);
//    NSMethodSignature* signature1 = [objc_getClass("XLTaskFactory") instanceMethodSignatureForSelector:mySelector];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature1];
//    [invocation setTarget:taskFactory];
//    [invocation setSelector:mySelector];
//    [invocation setArgument:&task atIndex:3];
//    [invocation invoke];
    return 0;
}

@end
