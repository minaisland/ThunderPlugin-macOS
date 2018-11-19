//
//  WebServerManager.h
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/19.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServerManager : NSObject

+ (instancetype)shared;
- (void)startServer;

@end
