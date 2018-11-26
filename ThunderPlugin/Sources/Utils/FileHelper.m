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
    NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
}

+ (NSString *)moveFile:(NSString *)filePath to:(NSString *)targetName {
    BOOL isDir;
    NSString *torrentsDir = [kThunderCachesDir stringByAppendingPathComponent:@"torrents"];
    [fileManager fileExistsAtPath:torrentsDir isDirectory:&isDir];
    if (!isDir) {
        [fileManager createDirectoryAtPath:torrentsDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (![[targetName pathExtension] isEqualToString:@"torrent"]) {
        targetName = [NSString stringWithFormat:@"%@.torrent", targetName];
    }
    NSString *targetPath = [torrentsDir stringByAppendingPathComponent:targetName];
    [fileManager moveItemAtPath:filePath
                         toPath:targetPath
                          error:nil];
    [self removeFile:filePath];
    return targetPath;
}

@end
