//
//  FKTaskModel.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/10.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "FKTaskModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSDictionary (NotNilValue)

- (long long)notNilLongValueForKey:(NSString *)key;

@end

@implementation NSDictionary (NotNilValue)

- (long long)notNilLongValueForKey:(NSString *)key {
    NSNumber *value = [self objectForKey:key];
    if (value != nil) {
        return [value longLongValue];
    }
    return 0;
}

- (long long)notNilBoolValueForKey:(NSString *)key {
    NSNumber *value = [self objectForKey:key];
    if (value != nil) {
        return [value boolValue];
    }
    return false;
}

- (NSString *)notNilStringForKey:(NSString *)key {
    NSString *value = [self objectForKey:key];
    if (value != nil) {
        return value;
    }
    return @"";
}

@end

@implementation FKTaskModel

- (id)initWithLocalTask:(LocalTask *)localTask {
    if (self = [super init]) {
        NSDictionary *taskInfo = [localTask valueForKeyPath:@"taskInfo"];
        if (taskInfo != nil && [taskInfo isKindOfClass:[NSDictionary class]]) {
            self.taskid = [taskInfo notNilLongValueForKey:@"DSKeyTaskInfoTaskId"];
            self.fileSize = [taskInfo notNilLongValueForKey:@"DSKeyTaskInfoFileSize"];
            self.downloadedSize = [taskInfo notNilLongValueForKey:@"DSKeyTaskInfoDownloadDataSize"];
            self.speed = [[localTask valueForKeyPath:@"speed"] longLongValue];
            self.progress = [[localTask valueForKeyPath:@"progress"] longLongValue];
            self.remainSeconds = [[localTask valueForKeyPath:@"remainSeconds"] longLongValue];
            self.taskType = [taskInfo notNilLongValueForKey:@"DSKeyTaskInfoTaskType"];
            self.taskState = [taskInfo notNilLongValueForKey:@"DSKeyTaskInfoTaskState"];
            self.failedCode = [taskInfo notNilLongValueForKey:@"DSKeyTaskInfoErrorCode"];
            self.createdTime = [taskInfo notNilLongValueForKey:@"DSKeyTaskInfoStartTime"];
            self.finishedTime = [taskInfo notNilLongValueForKey:@"DSKeyTaskInfoFinishedTime"];
            self.url = [localTask valueForKeyPath:@"url"];
            self.referUrl = [taskInfo notNilStringForKey:@"DSKeyTaskInfoRefURL"];
            self.taskName = [taskInfo notNilStringForKey:@"DSKeyTaskInfoFileName"];
            self.taskDir = [taskInfo notNilStringForKey:@"DSKeyTaskInfoFilePath"];
            self.isDeleted = [taskInfo notNilBoolValueForKey:@"DSKeyTaskInfoIsDeleted"];
        }
        
    }
    return self;
}

@end
