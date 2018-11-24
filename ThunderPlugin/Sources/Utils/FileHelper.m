//
//  FileHelper.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/24.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "FileHelper.h"

static NSFileManager *fileManager;

@implementation FileHelper

+ (void)load {
    fileManager = [NSFileManager defaultManager];
}

+ (void)removeFile:(NSString *)filePath {
    NSError *error;
    [fileManager removeItemAtPath:filePath error:&error];
    if (error) {
        DLog(@"remove file fail: %@", error);
    }
}

+ (void)moveFile:(NSString *)filePath to:(NSString *)targetPath {
    
}

@end
