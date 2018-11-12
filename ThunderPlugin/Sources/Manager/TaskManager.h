//
//  TaskManager.h
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/12.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskManager : NSObject

@property (nonatomic) NSMutableArray *allTask;
@property (nonatomic) NSMutableArray *downloadingTasks;
@property (nonatomic) NSMutableArray *completedTasks;
@property (nonatomic) NSMutableArray *deletedTasks;
@property (nonatomic) NSMutableArray *sectionCompletedTasks;

+ (TaskManager *)shared;

@end
