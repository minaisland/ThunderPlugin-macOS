//
//  TaskManager.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/12.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "TaskManager.h"
#import "FKTaskModel.h"
#import "XLTaskHelper.h"
#import <objc/runtime.h>

@implementation TaskManager

+ (TaskManager *)shared {
    static id sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:@"XLDownloadingTaskChangedNotification" object:nil];
    }
    return self;
}

- (void)test:(NSNotification *)noti {
    NSLog(@"%@", noti);
}

- (void)createTaskWithURL:(NSString *)urlString {
    if (!urlString || [urlString isEqualToString:@""]) return;
    [XLTaskHelper createTaskWithURL:urlString];
}

- (NSMutableArray *)allTasks {
    return [self getTasksForKeyPath:@"allTasks"];
}

- (NSMutableArray *)downloadingTasks {
    return [self getTasksForKeyPath:@"downloadingTasks"];
}

- (NSMutableArray *)completedTasks {
    return [self getTasksForKeyPath:@"completedTasks"];
}

- (NSMutableArray *)deletedTasks {
    return [self getTasksForKeyPath:@"deletedTasks"];
}

- (NSMutableArray *)sectionCompletedTasks {
    return [self getTasksForKeyPath:@"sectionCompletedTasks"];
}

- (NSMutableArray *)getTasksForKeyPath:(NSString *)keyPath {
    TasksCategoryMgr *mgr = [objc_getClass("TasksCategoryMgr") performSelector:@selector(sharedMgr)];
    NSMutableArray *newArray = [NSMutableArray array];
    for (LocalTask *item in [mgr valueForKeyPath:keyPath]) {
        [newArray addObject:[[FKTaskModel alloc] initWithLocalTask:item]];
    }
    return newArray;
}

@end
