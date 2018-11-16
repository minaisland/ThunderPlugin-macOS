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
- (void)hook_onMagnetStatusChange:(id)arg1 state:(id)arg2 torrent:(id)arg3;
@end

@interface LocalAllViewCtrl: NSViewController
+ (id)sharedController;
@end

@interface LocalTask: NSObject
@end

@interface XLCryptoUtil: NSObject
+ (id)md5OfFile:(id)arg1;
@end

@interface XLMainWindowController: NSObject
- (void)_loadDefaultPage;
@end

@interface XLHostPageController: NSObject
@property (nonatomic) id navigationItems;
@end

@interface XLBundleManager: NSObject
- (id)hostController:(id)arg1 loadPluginsWithIdentifier:(NSString *)arg2;
@end

@interface XLNavigationViewController: NSObject
- (void)selectItemWithIdentifier:(id)arg1;
@end
