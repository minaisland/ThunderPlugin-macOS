//
//  NSObject+Context.h
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/10.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThunderPlugin.h"

@interface NSObject (Context)

+ (void)setupContext;

+ (LocalAllViewCtrl *)taskListViewCtrl;
+ (XLCreateBTTaskWindowController *)createdBTTaskCtrl;

@end
