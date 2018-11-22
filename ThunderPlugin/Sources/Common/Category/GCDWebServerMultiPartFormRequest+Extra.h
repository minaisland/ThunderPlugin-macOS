//
//  GCDWebServerMultiPartFormRequest+Extra.h
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/22.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "GCDWebServerMultiPartFormRequest.h"

@interface GCDWebServerMultiPartFormRequest (Extra)

- (NSString *)argumentValueForKey:(NSString *)key;

- (NSString *)filePathForKey:(NSString *)key;

@end
