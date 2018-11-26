//
//  NSDictionary+SafeRead.h
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/26.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeRead)

- (NSString *)stringForKey:(NSString *)key;

- (long)longValueForKey:(NSString *)key;

- (NSArray *)arrayForKey:(NSString *)key;

@end
