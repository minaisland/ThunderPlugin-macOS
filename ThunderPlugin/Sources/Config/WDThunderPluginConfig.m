//
//  WDThunderPluginConfig.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/16.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "WDThunderPluginConfig.h"

static NSString * const kFeaturedPageDisableKey = @"kFeaturedPageDisableKey";
static NSString * const kFilmReviewPageDisableKey = @"kFilmReviewPageDisableKey";
static NSString * const kAdvertisingPluginDisableKey = @"kAdvertisingPluginDisableKey";
static NSString * const kUserTxtPasswordKey = @"kUserTxtPasswordKey";


@implementation WDThunderPluginConfig
{
    NSUserDefaults *userDefaults;
}

+ (WDThunderPluginConfig *)shared {
    static id sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        // 设置配置文件路径
        userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"life.zwd.thunder.plugin"];
        
        self.featuredPageDisable = true;
        self.filmReviewPageDisable = true;
        self.advertisingPluginDisable = true;
        self.userTxtPassword = [userDefaults stringForKey:kUserTxtPasswordKey];
    }
    return self;
}

- (void)setFeaturedPageDisable:(BOOL)featuredPageDisable {
    _featuredPageDisable = featuredPageDisable;
    [userDefaults setBool:featuredPageDisable forKey:kFeaturedPageDisableKey];
    [userDefaults synchronize];
}

- (void)setFilmReviewPageDisable:(BOOL)filmReviewPageDisable {
    _filmReviewPageDisable = filmReviewPageDisable;
    [userDefaults setBool:filmReviewPageDisable forKey:kFilmReviewPageDisableKey];
    [userDefaults synchronize];
}

- (void)setAdvertisingPluginDisable:(BOOL)advertisingPluginDisable {
    _advertisingPluginDisable = advertisingPluginDisable;
    [userDefaults setBool:advertisingPluginDisable forKey:kAdvertisingPluginDisableKey];
    [userDefaults synchronize];
}

- (void)setUserTxtPassword:(NSString *)userTxtPassword {
    _userTxtPassword = userTxtPassword;
    [userDefaults setObject:userTxtPassword forKey:kUserTxtPasswordKey];
    [userDefaults synchronize];
}

@end
