//
//  PreferencesHelper.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/18.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "PreferencesHelper.h"

@implementation PreferencesHelper

+ (NSString *)userTxtUsername {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"UserTxtUsername"];
}

+ (NSString *)userTxtPassword {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"userTxtPassword"];
}

@end
