//
//  NSObject+hook.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/10.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "Thunder+hook.h"
#import "WDHelper.h"
#import "WDThunderPluginConfig.h"

static void * CreateBTTaskCtrlPropertyKey = &CreateBTTaskCtrlPropertyKey;
static NSString * const kNavFeaturedPage = @"com.xunlei.plugin.page.featuredpage";
static NSString * const kNavFilmReviewPage = @"com.xunlei.plugin.page.filmreview";
static NSString * const kNavDownloadingPage = @"com.xunlei.embeddedplugin.view.downloading";
static NSString * const kNavCompletionPage = @"com.xunlei.embeddedplugin.view.completion";
static NSString * const kNavApplicationsPage = @"com.xunlei.plugin.page.applications";

@implementation NSObject (hook)

+ (void)hookThunder {
    
    wd_hookMethod(objc_getClass("XLTaskFactory"), @selector(controller:deliverTask:withOptions:), [self class], @selector(hook_controller:deliverTask:withOptions:));

    wd_hookMethod(objc_getClass("XLTaskFactory"), @selector(controller:deliverBTFile:fileIndexs:option:), [self class], @selector(hook_controller:deliverBTFile:fileIndexs:option:));
    
    wd_hookMethod(objc_getClass("XLTaskFactory"), @selector(createBTTaskWindowControllerWithPath:), [self class], @selector(hook_createBTTaskWindowControllerWithPath:));
    
    wd_hookMethod(objc_getClass("XLMainWindowController"), @selector(_loadDefaultPage), [self class], @selector(hook_loadDefaultPage));

    wd_hookMethod(objc_getClass("XLHostPageController"), @selector(navigationItems), [self class], @selector(hook_navigationItems));
    
    wd_hookMethod(objc_getClass("XLBundleManager"), @selector(hostController:loadPluginsWithIdentifier:), [self class], @selector(hook_hostController:loadPluginsWithIdentifier:));
    
}

// 当磁力链接下载好并创建bt任务时调用
- (id)hook_createBTTaskWindowControllerWithPath:(id)arg1 {
    NSLog(@"createBTTaskWindowControllerWithPath");
    return [self hook_createBTTaskWindowControllerWithPath:arg1];
}

- (void)hook_controller:(id)arg1 deliverTask:(id)arg2 withOptions:(id)arg3 {
    NSLog(@"hook)controller:deliverTask:withOptions:");
    [self hook_controller:arg1 deliverTask:arg2 withOptions:arg3];
}

- (void)hook_controller:(id)arg1 deliverBTFile:(id)arg2 fileIndexs:(id)arg3 option:(id)arg4 {
    NSLog(@"hook_controller:deliverBTFile:fileIndexs:option:");
    [self hook_controller:arg1 deliverBTFile:arg2 fileIndexs:arg3 option:arg4];
}

- (void)hook_showLiveupdateWindow {
    NSLog(@"===========================================");
    NSLog(@"hook_showLiveupdateWindow");
    NSLog(@"===========================================");
//    [self hook_showLiveupdateWindow];
}

- (void)hook_loadDefaultPage {
    [self hook_loadDefaultPage];
    XLNavigationViewController *navCtr = [self valueForKeyPath:@"navigationController"];
    // 用延迟执行解决切换tab时的黑色闪烁
    if ([WDThunderPluginConfig shared].featuredPageDisable) {
        if ([WDThunderPluginConfig shared].filmReviewPageDisable) {
            [navCtr performSelector:@selector(selectItemWithIdentifier:) withObject:kNavDownloadingPage afterDelay:0.2];
        } else {
            [navCtr performSelector:@selector(selectItemWithIdentifier:) withObject:kNavFilmReviewPage afterDelay:0.2];
        }
    }
}

- (id)hook_hostController:(id)arg1 loadPluginsWithIdentifier:(NSString *)arg2 {
    if ([arg2 containsString:@"advertising"] && [WDThunderPluginConfig shared].advertisingPluginDisable) {
        return nil;
    }
    return [self hook_hostController:arg1 loadPluginsWithIdentifier:arg2];
}

/**
 调整导航栏选项，选择性隐藏

 @return 导航栏Item
 */
- (id)hook_navigationItems {
    NSMutableArray *navigationItems = [self hook_navigationItems];
    NSMutableArray *tempItems = [navigationItems mutableCopy];
    for (NSView *navView in navigationItems) {
        NSString *identifier = [navView valueForKeyPath:@"identifier"];
        if ([identifier isEqualToString:kNavFeaturedPage] && [WDThunderPluginConfig shared].featuredPageDisable) {
            [tempItems removeObject:navView];
        } else if ([identifier isEqualToString:kNavFilmReviewPage] && [WDThunderPluginConfig shared].filmReviewPageDisable) {
            [tempItems removeObject:navView];
        }
    }
    NSMutableDictionary *navigationItemMap = [self valueForKeyPath:@"navigationItemMap"];
    if ([WDThunderPluginConfig shared].featuredPageDisable) {
        [navigationItemMap removeObjectForKey:kNavFeaturedPage];
    }
    if ([WDThunderPluginConfig shared].filmReviewPageDisable) {
        [navigationItemMap removeObjectForKey:kNavFilmReviewPage];
    }
    return tempItems;
}

@end
