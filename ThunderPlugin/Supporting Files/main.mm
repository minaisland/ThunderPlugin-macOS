//
//  main.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/9.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate+hook.h"
#import "Thunder+hook.h"
#import "XLCreateBTTaskWindowController+hook.h"
#import "ThunderManager.h"
#import "NSObject+Context.h"

static void __attribute__((constructor)) initialize(void) {
    NSLog(@"++++++++ ThunderPlugin loaded ++++++++");
    [NSObject setupContext];
    [NSObject hookThunder];
    [NSObject hookCreateBTTask];
    [NSObject hookAppDelegate];
}

