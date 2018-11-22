//
//  GCDWebServerMultiPartFormRequest+Extra.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/22.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "GCDWebServerMultiPartFormRequest+Extra.h"

@implementation GCDWebServerMultiPartFormRequest (Extra)

- (NSString *)argumentValueForKey:(NSString *)key {
    return [[self firstArgumentForControlName:key] string];
}

- (NSString *)filePathForKey:(NSString *)key {
    return [[self firstFileForControlName:key] temporaryPath];
}

@end
