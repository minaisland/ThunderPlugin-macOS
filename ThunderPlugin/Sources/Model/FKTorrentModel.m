//
//  FKTorrentModel.m
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/26.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import "FKTorrentModel.h"
#import "NSDictionary+SafeRead.h"

@implementation FKTorrentModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.baseFolder = [dict stringForKey:@"DSKeyTorrentBaseFolder"];
        self.subFileCount = [dict longValueForKey:@"DSKeyTorrentSubFileCount"];
        self.subFiles = [FKTorrentSubFileModel arrayWithModels:[dict arrayForKey:@"DSKeyTorrentSubFiles"]];
        self.hashValue = [dict stringForKey:@"DSKeyTorrentHash"];
        self.totalSize = [dict longValueForKey:@"DSKeyTorrentTotalSize"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [[super toDictionary] mutableCopy];
    NSArray *subFiles = [dict arrayForKey:@"subFiles"];
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:subFiles.count];
    for (FKTorrentSubFileModel *subFileModel in subFiles) {
        [newArray addObject:[subFileModel toDictionary]];
    }
    [dict setObject:newArray forKey:@"subFiles"];
    return dict;
}

- (NSDictionary *)toDictionaryAndAddEntries:(NSDictionary *)entries {
    NSMutableDictionary *dict = [[self toDictionary] mutableCopy];
    [dict addEntriesFromDictionary:entries];
    return dict;
}

@end

@implementation FKTorrentSubFileModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.index = [dict longValueForKey:@"DSKeyTorrentSubFileIndex"];
        self.size = [dict longValueForKey:@"DSKeyTorrentSubFileSize"];
        self.offset = [dict longValueForKey:@"DSKeyTorrentSubFileOffset"];
        self.name = [dict stringForKey:@"DSKeyTorrentSubFileName"];
    }
    return self;
}

+ (NSMutableArray *)arrayWithModels:(NSArray *)array
{
    NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        [modelArray addObject:[[self alloc] initWithDictionary:dict]];
    }
    return modelArray;
}

@end
