//
//  NSObject+hook.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/10.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "Thunder+hook.h"
#import "WDHelper.h"
#import "PreferencesHelper.h"
#import "WDThunderPluginConfig.h"
#import "TaskManager.h"
#import "WebServerManager.h"

static NSString * const kNavFeaturedPage = @"com.xunlei.plugin.page.featuredpage";
static NSString * const kNavFilmReviewPage = @"com.xunlei.plugin.page.filmreview";
static NSString * const kNavDownloadingPage = @"com.xunlei.embeddedplugin.view.downloading";
static NSString * const kNavCompletionPage = @"com.xunlei.embeddedplugin.view.completion";
static NSString * const kNavApplicationsPage = @"com.xunlei.plugin.page.applications";

typedef enum {
    Login = 0,
    Loginkey = 1,
    Sessionlogin = 3,
    Smslogin = 4
} XLLoginType;

@implementation NSObject (hook)

+ (void)hookThunder {
    
    wd_hookMethod(objc_getClass("XLTaskFactory"), @selector(controller:deliverBTFile:fileIndexs:option:), [self class], @selector(hook_controller:deliverBTFile:fileIndexs:option:));
    
    wd_hookMethod(objc_getClass("XLTaskFactory"), @selector(createBTTaskWindowControllerWithPath:), [self class], @selector(hook_createBTTaskWindowControllerWithPath:));
    
    wd_hookMethod(objc_getClass("LocalTasksMgr"), @selector(onTaskStateChanged:), [self class], @selector(hook_onTaskStateChanged:));

    wd_hookMethod(objc_getClass("XLMainWindowController"), @selector(_loadDefaultPage), [self class], @selector(hook_loadDefaultPage));

    wd_hookMethod(objc_getClass("XLHostPageController"), @selector(navigationItems), [self class], @selector(hook_navigationItems));
    
    wd_hookMethod(objc_getClass("XLBundleManager"), @selector(hostController:loadPluginsWithIdentifier:), [self class], @selector(hook_hostController:loadPluginsWithIdentifier:));
    
    wd_hookMethod(objc_getClass("XLLoginManager"), @selector(sessionDidLoginFail:loginType:loginInfo:error:errorDescription:), [self class], @selector(hook_sessionDidLoginFail:loginType:loginInfo:error:errorDescription:));
    
    wd_hookMethod(objc_getClass("XLLoginSession"), @selector(userLogin:password:), [self class], @selector(hook_userLogin:password:));
    
    wd_hookMethod(objc_getClass("EtmApi"), @selector(getTorrentInfo:withBlock:), [self class], @selector(hook_getTaskInfo:withBlock:));
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[WebServerManager shared] startServer];
    });
    
}

// 当磁力链接下载好并创建bt任务时调用
- (id)hook_createBTTaskWindowControllerWithPath:(id)arg1 {
    NSLog(@"createBTTaskWindowControllerWithPath");
    return [self hook_createBTTaskWindowControllerWithPath:arg1];
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
    if ([WDThunderPluginConfig shared].advertisingPluginDisable && [arg2 containsString:@"advertising"]) {
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
        if ([WDThunderPluginConfig shared].featuredPageDisable && [identifier isEqualToString:kNavFeaturedPage]) {
            [tempItems removeObject:navView];
        } else if ( [WDThunderPluginConfig shared].filmReviewPageDisable && [identifier isEqualToString:kNavFilmReviewPage]) {
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

- (void)hook_sessionDidLoginFail:(id)arg1 loginType:(XLLoginType)arg2 loginInfo:(id)arg3 error:(long long)arg4 errorDescription:(id)arg5 {
    // 身份信息失效后后用用户名和密码登录
    if (arg2 == Loginkey && arg4 == 15 && [WDThunderPluginConfig shared].userTxtPassword != nil) {
        XLLoginSession *loginSession = [[objc_getClass("XLLoginManager") manager] loginSession];
        [loginSession performSelector:@selector(userLogin:password:)
                           withObject:[PreferencesHelper userTxtUsername]
                           withObject:[WDThunderPluginConfig shared].userTxtPassword];
    } else {
        [self hook_sessionDidLoginFail:arg1 loginType:arg2 loginInfo:arg3 error:arg4 errorDescription:arg5];
    }
}

- (void)hook_userLogin:(id)arg1 password:(id)arg2 {
    [self hook_userLogin:arg1 password:arg2];
    [WDThunderPluginConfig shared].userTxtPassword = arg2;
}

- (void)hook_onTaskStateChanged:(NSDictionary *)taskInfo {
    // DSKeyTaskInfoTaskState 1为开始任务   3为任务完成
    [self hook_onTaskStateChanged:taskInfo];
    [[TaskManager shared] setOnCompletion:taskInfo];
}
                  
- (void)hook_getTaskInfo:(id)arg1 withBlock:(id)arg2 {
    [self hook_getTaskInfo:arg1 withBlock:arg2];
}

@end
