//
//  FileHelper.h
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/24.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject

+ (void)removeFile:(NSString *)filePath;

+ (NSString *)moveFile:(NSString *)filePath to:(NSString *)targetName;

@end
