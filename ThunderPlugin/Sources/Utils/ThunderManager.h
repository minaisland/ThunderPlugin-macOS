//
//  ThunderManager.h
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/10.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThunderPlugin.h"

@interface ThunderManager: NSObject

@property (nonatomic) NSMutableArray *subBTFileInfos;
@property (nonatomic) NSMutableArray *taskArray;
@property (nonatomic) NSMutableArray *downloadingTasks;


+ (ThunderManager *)shared;

@end
