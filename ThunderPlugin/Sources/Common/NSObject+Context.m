//
//  NSObject+Context.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/10.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "NSObject+Context.h"
#import "WDHelper.h"
#import "ThunderManager.h"

static void * CreatedBTTaskCtrlPropertyKey = &CreatedBTTaskCtrlPropertyKey;
static void * TaskListViewCtrlPropertyKey = &TaskListViewCtrlPropertyKey;

@implementation NSObject (Context)

+ (void)setupContext {
    wd_hookMethod(objc_getClass("XLCreateBTTaskWindowController"), @selector(windowDidLoad), [self class], @selector(hook_windowDidLoad));
    
    wd_hookClassMethod(objc_getClass("LocalAllViewCtrl"), @selector(sharedController), [self class], @selector(hook_sharedController));
//    wd_hookMethod(objc_getClass("LocalAllViewCtrl"), @selector(setContentArray:), [self class], @selector(hook_setContentArray:));
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:@"XLNavigationSelectionDidChangeNotification" object:nil];

}

- (void)test:(id)userInfo {
    NSLog(@"%@", userInfo);
}

- (void)hook_windowDidLoad {
    NSLog(@"hook_windowDidLoad");
    NSObject.createdBTTaskCtrl = (XLCreateBTTaskWindowController *)self;
    [self performSelector:@selector(delayRun) withObject:nil afterDelay:1];
    [self hook_windowDidLoad];
}

- (void)delayRun {
    NSLog(@"%@", [ThunderManager shared].taskArray);
    NSLog(@"%@", [ThunderManager shared].subBTFileInfos);
}

- (void)hook_setContentArray:(id)arg1 {
    NSLog(@"hook_setContentArray");
    [self hook_setContentArray:arg1];
}

- (void)hook_selectItemWithIdentifier:(id)arg1 userInfo:(id)arg2 {
    NSLog(@"hook_selectItemWithIdentifier");
    [self hook_selectItemWithIdentifier:arg1 userInfo:arg2];
}

+ (id)hook_sharedController {
    NSLog(@"hook_sharedController");
    id shared = [self hook_sharedController];
    if (NSObject.taskListViewCtrl == nil) {
        NSObject.taskListViewCtrl = shared;
    } else {
        NSLog(@"%@", [ThunderManager shared].downloadingTasks);
    }
    return shared;
}

+ (LocalAllViewCtrl *)taskListViewCtrl {
    return objc_getAssociatedObject(self, TaskListViewCtrlPropertyKey);
}

+ (void)setTaskListViewCtrl:(LocalAllViewCtrl *)taskListViewCtrl {
    objc_setAssociatedObject(self, TaskListViewCtrlPropertyKey, taskListViewCtrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (XLCreateBTTaskWindowController *)createdBTTaskCtrl {
    return objc_getAssociatedObject(self, CreatedBTTaskCtrlPropertyKey);
}

+ (void)setCreatedBTTaskCtrl:(XLCreateBTTaskWindowController *)createdBTTaskCtrl {
    objc_setAssociatedObject(self, CreatedBTTaskCtrlPropertyKey, createdBTTaskCtrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
