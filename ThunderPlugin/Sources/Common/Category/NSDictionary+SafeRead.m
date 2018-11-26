//
//  NSDictionary+SafeRead.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/26.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "NSDictionary+SafeRead.h"

@implementation NSDictionary (SafeRead)

- (NSString *)stringForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return value;
    }
    return @"";
}

- (long)longValueForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSNumber class]]) {
        return [value longValue];
    }
    return 0;
}

- (NSArray *)arrayForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return @[];
}

@end
