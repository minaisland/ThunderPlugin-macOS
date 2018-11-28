//
//  FKTorrentModel.h
//  ThunderPlugin
//
//  Created by Stanley on 2018/11/26.
//  Copyright © 2018年 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface FKTorrentSubFileModel : JSONModel

@property (nonatomic, assign) long index;
@property (nonatomic, assign) long size;
@property (nonatomic, assign) long offset;
@property (nonatomic, copy) NSString *name;

+ (NSMutableArray *)arrayWithModels:(NSArray *)array;

@end

@interface FKTorrentModel : JSONModel

@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, assign) long subFileCount;
@property (nonatomic, strong) NSMutableArray<FKTorrentSubFileModel *> *subFiles;
@property (nonatomic, copy) NSString *hashValue;
@property (nonatomic, assign) long totalSize;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (NSDictionary *)toDictionaryAndAddEntries:(NSDictionary *)entries;

@end


