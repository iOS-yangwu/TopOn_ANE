//
//  TODataBaseTools.m
//
//  Created by 洋吴 on 2019/3/18.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "TODataBaseTools.h"
#import "TOKeyValueStore.h"
#import "TOConst.h"

@interface TODataBaseTools ()

@property (nonatomic, strong) TOKeyValueStore *store;

@end

@implementation TODataBaseTools

+ (instancetype)dbTools{
    
    static TODataBaseTools *dbTools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbTools = [[TODataBaseTools alloc]init];
    });
    return dbTools;
}

- (instancetype)init{
    if (self = [super init]) {
        [self initTable];
    }
    return self;
}
- (void)initTable{
    
    self.store = [[TOKeyValueStore alloc]initDBWithName:kDBName];
    [self.store createTableWithName:kTableName];
    
}

- (void)putObject:(id)object withId:(NSString *)objectId{
    
    [self.store putObject:object withId:objectId intoTable:kTableName];
    
}

- (id)getObjectById:(NSString *)objectId{
    
    return [self.store getObjectById:objectId fromTable:kTableName];
}

- (void)putString:(NSString *)string withId:(NSString *)stringId{
    
    [self.store putString:string withId:stringId intoTable:kTableName];
}

- (NSString *)getStringById:(NSString *)stringId{
    
    return [self.store getStringById:stringId fromTable:kTableName];
}

- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId{
    
    [self.store putNumber:number withId:numberId intoTable:kTableName];
}

- (NSNumber *)getNumberById:(NSString *)numberId{
    
    return [self.store getNumberById:numberId fromTable:numberId];
}
- (void)deleteObjectById:(NSString *)objectId{
    
    [self.store deleteObjectById:objectId fromTable:kTableName];
    
}

@end
