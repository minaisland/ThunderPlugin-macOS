//
//  WDThunderPluginConfig.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/16.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "WDThunderPluginConfig.h"

@implementation WDThunderPluginConfig

+ (WDThunderPluginConfig *)shared {
    static id sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        self.featuredPageDisable = true;
        self.filmReviewPageDisable = true;
        self.advertisingPluginDisable = true;
    }
    return self;
}

@end
