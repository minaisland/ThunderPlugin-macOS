//
//  ThunderPlugin.h
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/9.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for ThunderPlugin.
FOUNDATION_EXPORT double ThunderPluginVersionNumber;

//! Project version string for ThunderPlugin.
FOUNDATION_EXPORT const unsigned char ThunderPluginVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ThunderPlugin/PublicHeader.h>


@interface XLCreateBTTaskWindowController: NSWindowController
@end

@interface XLTaskFactory : NSObject
+ (id)defaultFactory;
- (void)controller:(id)arg1 deliverTask:(id)arg2 withOptions:(id)arg3;
@end

@interface LocalAllViewCtrl: NSViewController
+ (id)sharedController;
@end

@interface LocalTask : NSObject
@end

@interface XLCryptoUtil : NSObject
+ (id)md5OfFile:(id)arg1;
@end

@interface XLMainWindowController : NSObject
- (void)_loadDefaultPage;
@end

@interface XLHostPageController : NSObject
@property (nonatomic) id navigationItems;
@end

@interface XLBundleManager : NSObject
- (id)hostController:(id)arg1 loadPluginsWithIdentifier:(NSString *)arg2;
@end

@interface XLNavigationViewController : NSObject
- (void)selectItemWithIdentifier:(id)arg1;
@end

@interface TasksCategoryMgr : NSObject
+ (id)sharedMgr;
@end

@interface XLLoginSession : NSObject
- (void)userLogin:(id)arg1 password:(id)arg2;
@end

@interface XLLoginManager : NSObject
+ (XLLoginManager *)manager;
- (XLLoginSession *)loginSession;
- (void)sessionDidLoginFail:(id)arg1 loginType:(long long)arg2 loginInfo:(id)arg3 error:(long long)arg4 errorDescription:(id)arg5;
@end

@interface XLURLTask : NSObject
+ (id)taskWithURL:(id)arg1 taskName:(id)arg2;
- (void)setDownloadPath:(id)arg1;
@end
