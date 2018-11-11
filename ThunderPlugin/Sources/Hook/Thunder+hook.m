//
//  NSObject+hook.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/10.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "Thunder+hook.h"
#import "WDHelper.h"
#import "fishhook.h"

static void * CreateBTTaskCtrlPropertyKey = &CreateBTTaskCtrlPropertyKey;

@implementation NSObject (hook)

+ (void)hookThunder {
    
    wd_hookMethod(objc_getClass("XLTaskFactory"), @selector(controller:deliverTask:withOptions:), [self class], @selector(hook_controller:deliverTask:withOptions:));

    wd_hookMethod(objc_getClass("XLTaskFactory"), @selector(controller:deliverBTFile:fileIndexs:option:), [self class], @selector(hook_controller:deliverBTFile:fileIndexs:option:));
    
    wd_hookMethod(objc_getClass("XLTaskFactory"), @selector(createBTTaskWindowControllerWithPath:), [self class], @selector(hook_createBTTaskWindowControllerWithPath:));
    
    wd_hookMethod(objc_getClass("XLHostMenuController"), @selector(showLiveupdateWindow), [self class], @selector(hook_showLiveupdateWindow));
    
    
}

// 当磁力链接下载好并创建bt任务时调用
- (id)hook_createBTTaskWindowControllerWithPath:(id)arg1 {
    NSLog(@"createBTTaskWindowControllerWithPath");
    return [self hook_createBTTaskWindowControllerWithPath:arg1];
}

- (void)hook_controller:(id)arg1 deliverTask:(id)arg2 withOptions:(id)arg3 {
    NSLog(@"hook)controller:deliverTask:withOptions:");
    [self hook_controller:arg1 deliverTask:arg2 withOptions:arg3];
}

- (void)hook_controller:(id)arg1 deliverBTFile:(id)arg2 fileIndexs:(id)arg3 option:(id)arg4 {
    NSLog(@"hook_controller:deliverBTFile:fileIndexs:option:");
    [self hook_controller:arg1 deliverBTFile:arg2 fileIndexs:arg3 option:arg4];
}

- (void)hook_showLiveupdateWindow {
    NSLog(@"===========================================");
    NSLog(@"hook_showLiveupdateWindow");
    NSLog(@"===========================================");
//    [self hook_showLiveupdateWindow];
}


@end
