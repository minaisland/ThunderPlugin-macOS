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

@implementation XLTaskHelper

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

+ (BOOL)isThunderUrlScheme:(NSString *)urlString {
    return (BOOL)[objc_getClass("DownloadHelper") performSelector:@selector(isThunderUrlScheme:) withObject:urlString];
}

+ (id)createXLURLTaskWithURL:(NSString *)urlString {
    NSString *originUrl;
    if ([self isThunderUrlScheme:urlString]) {
        originUrl = [self decodeThunderUrl:urlString];
    }
    NSString *filename = [self parseFilenameFromUrl:originUrl];
    return [objc_getClass("XLURLTask") performSelector:@selector(taskWithURL:taskName:) withObject:originUrl withObject:filename];
}

+ (int)createTaskWithURL:(NSString *)urlString {
    id task = [self createXLURLTaskWithURL:urlString];
    [task performSelector:@selector(setDownloadPath:) withObject:@"~/Downloads"];
    id taskFactory = [objc_getClass("XLTaskFactory") performSelector:@selector(defaultFactory)];
    [taskFactory performSelector:@selector(controller:deliverTask:withOptions:) withObject:nil withObject:task];
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
