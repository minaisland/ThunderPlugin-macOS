//
//  WebServerManager.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/19.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "WebServerManager.h"
#import "TaskManager.h"
#import "FKTaskModel.h"
#import <GCDWebServer.h>
#import <GCDWebServerDataResponse.h>
#import <GCDWebServerErrorResponse.h>
#import "GCDWebServerMultiPartFormRequest+Extra.h"

@interface WebServerManager()

@property (nonatomic, strong) GCDWebServer *webServer;

@end

@implementation WebServerManager

static int port=43800;

+ (instancetype)shared {
    static id sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}


- (void)startServer {
    if (self.webServer) {
        return;
    }
    NSDictionary *options = @{GCDWebServerOption_Port: [NSNumber numberWithInt:port],
                              GCDWebServerOption_BindToLocalhost: @YES,
                              GCDWebServerOption_ConnectedStateCoalescingInterval: @2,
                              };
    
    self.webServer = [[GCDWebServer alloc] init];
    [self addHandleForGetTask];
    [self addHandleForCreateTask];
    [self.webServer startWithOptions:options error:nil];
}

- (void)addHandleForGetTask {
    WeakSelf(weakSelf);
    [self.webServer addHandlerForMethod:@"GET" path:@"/tasks/all" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        
        return [weakSelf modelToJSONResponseFrom:[TaskManager shared].allTasks];
        
    }];
    
    [self.webServer addHandlerForMethod:@"GET" path:@"/tasks/downloading" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        
        return [weakSelf modelToJSONResponseFrom:[TaskManager shared].downloadingTasks];
        
    }];
    
    [self.webServer addHandlerForMethod:@"GET" path:@"/tasks/deleted" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        
        return [weakSelf modelToJSONResponseFrom:[TaskManager shared].deletedTasks];
        
    }];
    
    [self.webServer addHandlerForMethod:@"GET" path:@"/tasks/completed" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        
        return [weakSelf modelToJSONResponseFrom:[TaskManager shared].completedTasks];
        
    }];
    
}

- (void)addHandleForCreateTask {
    [self.webServer addHandlerForMethod:@"POST" path:@"/task/create" requestClass:[GCDWebServerMultiPartFormRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerMultiPartFormRequest * _Nonnull request) {
        
        [[TaskManager shared] createTaskWithURL:[request argumentValueForKey:@"url"]];
        
        return [GCDWebServerResponse responseWithStatusCode:200];
        
    }];
    
    [self.webServer addHandlerForMethod:@"POST" path:@"/torrent/info" requestClass:[GCDWebServerMultiPartFormRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerMultiPartFormRequest * _Nonnull request) {
        
        NSDictionary *data;
        
        NSString *url = [request argumentValueForKey:@"url"];
        GCDWebServerMultiPartFile *file = [request firstFileForControlName:@"torrent"];
        if (url && ![url isEqualToString:@""]) {
            data = [[TaskManager shared] torrentInfoWithMagnetURL:url];
        } else if (file) {
            data = [[TaskManager shared] torrentInfoWithFilename:file.fileName path:file.temporaryPath];
        }
        
        if (data) {
            return [GCDWebServerDataResponse responseWithJSONObject:data];
        } else {
            return [GCDWebServerErrorResponse responseWithClientError:kGCDWebServerHTTPStatusCode_PaymentRequired message:@"parameters `url` or `torrent` must have one is not empty!!"];
        }

    }];
}

- (GCDWebServerDataResponse *)modelToJSONResponseFrom:(NSMutableArray *)array {
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    NSMutableArray *dataList = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(FKTaskModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dataList addObject:[obj toDictionary]];
    }];
    [data setObject:@(dataList.count) forKey:@"count"];
    [data setObject:dataList forKey:@"data"];
    return [GCDWebServerDataResponse responseWithJSONObject:data];
}

@end
