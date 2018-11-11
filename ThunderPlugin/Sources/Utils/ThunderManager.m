//
//  ThunderManager.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/10.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "ThunderManager.h"
#import "NSObject+Context.h"
#import "FKTaskModel.h"
#import <objc/runtime.h>

@interface ThunderManager()
@end

@implementation ThunderManager

+ (id)shared {
    static id sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (NSMutableArray *)subBTFileInfos {
    return [[NSObject createdBTTaskCtrl] performSelector:@selector(subBTFileInfos)];
}

- (NSMutableArray *)downloadingTasks {
    id mgr = [objc_getClass("TasksCategoryMgr") performSelector:@selector(sharedMgr)];
    NSMutableArray *newArray = [NSMutableArray array];
    for (LocalTask *item in [mgr valueForKeyPath:@"allTasks"]) {
        [newArray addObject:[[FKTaskModel alloc] initWithLocalTask:item]];
    }
    return newArray;
}

- (NSMutableArray *)taskArray {
    NSArray *contentArray = [[NSObject taskListViewCtrl] valueForKeyPath:@"contentArray"];
    NSMutableArray *newArray = [NSMutableArray array];
    for (LocalTask *item in contentArray) {
        [newArray addObject:[[FKTaskModel alloc] initWithLocalTask:item]];
    }
    return newArray;
}

@end
