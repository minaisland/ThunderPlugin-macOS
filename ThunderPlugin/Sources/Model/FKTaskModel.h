//
//  FKTaskModel.h
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/10.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThunderPlugin.h"

@interface FKTaskModel : NSObject

@property (nonatomic, assign) long long taskid;
@property (nonatomic, assign) long long fileSize;
@property (nonatomic, assign) long long downloadedSize;
@property (nonatomic, assign) long long speed;
@property (nonatomic, assign) long long allDonwloadSpeed;
@property (nonatomic, assign) long long progress;
@property (nonatomic, assign) long long remainSeconds;
@property (nonatomic, assign) long long taskType;
@property (nonatomic, assign) long long taskState;
@property (nonatomic, assign) long long failedCode;
@property (nonatomic, assign) long long createdTime;
@property (nonatomic, assign) long long finishedTime;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *referUrl;
@property (nonatomic, copy) NSString *taskName;
@property (nonatomic, copy) NSString *tmpName;
@property (nonatomic, copy) NSString *taskDir;
@property (nonatomic, assign) BOOL isDeleted;

- (id)initWithLocalTask:(LocalTask *)localTask;

@end
