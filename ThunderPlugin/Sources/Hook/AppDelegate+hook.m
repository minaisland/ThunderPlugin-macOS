//
//  NSObject+AppDelegate.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/10.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "AppDelegate+hook.h"
#import "WDHelper.h"
#import "ThunderPlugin.h"

@implementation NSObject (AppDelegate)

+ (void)hookAppDelegate {

    wd_hookClassMethod(objc_getClass("XLCryptoUtil"), @selector(md5OfFile:), [self class], @selector(hook_md5OfFile:));
    
//    id str = [objc_getClass("XLCryptoUtil") performSelector:@selector(md5OfFile:) withObject:@"/Applications/Thunder.app/Contents/MacOS/Thunder_backup"];
//    NSLog(@"%@", str);
}

+ (id)hook_md5OfFile:(NSString *)arg1 {
    NSLog(@"hook_md5OfFile");
    if ([arg1 isEqualToString:@"/Applications/Thunder.app/Contents/MacOS/Thunder"]) {
        return @"3b226745fc6d4c1522bacb8520a4cb63";
    }
    return [self hook_md5OfFile:arg1];
}

@end
