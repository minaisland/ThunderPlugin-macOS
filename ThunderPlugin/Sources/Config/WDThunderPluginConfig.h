//
//  WDThunderPluginConfig.h
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/16.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDThunderPluginConfig : NSObject

@property (nonatomic, assign) BOOL featuredPageDisable; //禁止加载【精选】选项
@property (nonatomic, assign) BOOL filmReviewPageDisable; //禁止加载【影评】选项
@property (nonatomic, assign) BOOL advertisingPluginDisable; //禁止加载【广告】插件

+ (WDThunderPluginConfig *)shared;

@end
