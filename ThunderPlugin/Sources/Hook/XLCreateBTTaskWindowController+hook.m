//
//  XLCreateBTTaskWindowController+hook.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/10.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "XLCreateBTTaskWindowController+hook.h"
#import "WDHelper.h"
#import "ThunderManager.h"

@implementation NSObject (XLCreateBTTaskWindowController)

+ (void)hookCreateBTTask {
    
    wd_hookMethod(objc_getClass("XLCreateBTTaskWindowController"), @selector(openTorrent:), [self class], @selector(hook_openTorrent:));
    
    wd_hookMethod(objc_getClass("XLCreateBTTaskWindowController"), @selector(subBTFileInfos), [self class], @selector(hook_subBTFileInfos));
    
//    wd_hookMethod(objc_getClass("XLCreateBTTaskWindowController"), @selector(windowDidLoad), [self class], @selector(hook_windowDidLoad));
    
}

//- (void)hook_windowDidLoad {
//    NSLog(@"hook_windowDidLoad");
//    [self performSelector:@selector(delayTouchUp:) withObject:self afterDelay:1];
//    [self hook_windowDidLoad];
//}

- (void)delayTouchUp:(XLCreateBTTaskWindowController *)ctrl {
    NSLog(@"%@", [ThunderManager shared].taskArray);
    NSLog(@"%@", [ThunderManager shared].subBTFileInfos);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        id btn = [ctrl performSelector:@selector(btnDownload) withObject:nil];
//        [ctrl performSelector:@selector(onClick:) withObject:btn];
//    });
}

- (id)hook_subBTFileInfos {
    NSLog(@"hook_subBTFileInfos");
    return [self hook_subBTFileInfos];
}

// 打开bt文件或者磁链链接下载完成时调用
- (void)hook_openTorrent:(id)arg1 {
    NSLog(@"hook_openTorrent");
    [self hook_openTorrent:arg1];
}

@end
