//
//  TOSearchManager.m
//
//  Created by 洋吴 on 2019/5/7.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "TOSearchManager.h"
#import "TODataBaseTools.h"
#import "TOConst.h"
#import "MJExtension.h"


@implementation TOSearchManager

+ (TOSearchManager *)shareManager{
    
    static TOSearchManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[TOSearchManager alloc]init];
    });
    return shareManager;
    
}

- (TOUnitModel *)getUnitConfigWithPlacementID:(NSString *)placementID {
    
    NSArray *arr = [[TODataBaseTools dbTools] getObjectById:kUnitConfig];
    __block TOUnitModel *unitModel;
    if (arr.count) {
        [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj[@"name"]isEqualToString:placementID]) {
                unitModel = [TOUnitModel mj_objectWithKeyValues:obj];
                *stop = YES;
            }else{
                if ([obj[@"unitID"]isEqualToString:placementID]) {
                    unitModel = [TOUnitModel mj_objectWithKeyValues:obj];
                }
            }
        }];
    }
    return unitModel;
}


- (TOUnitModel *)getDefaultUnitConfigWithKey:(NSString *)key unitId:(NSString *_Nullable)unitid{
    
    __block TOUnitModel *defaultModel;
    if ([key isEqualToString:kIVModel]) {
        if (!kISNullString(unitid)) {
            id object = [[TODataBaseTools dbTools] getObjectById:key];
            if ([object isKindOfClass:[NSArray class]]&&object !=nil) {
                [object enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj[@"unitID"] && [obj[@"unitID"]isEqualToString:unitid]) {
                        defaultModel = [TOUnitModel mj_objectWithKeyValues:obj];
                        *stop = YES;
                    }
                }];
                return defaultModel;
            }else{
                return nil;
            }
            return nil;
        }else{
            return nil;
        }
    }else{
        
        NSDictionary *dic = [[TODataBaseTools dbTools] getObjectById:key];
        if (!kISNullDict(dic)) {
            defaultModel = [TOUnitModel mj_objectWithKeyValues:dic];
        }
        return defaultModel;
    }
}

- (NSDictionary *)getLastShowTimeAndIndexWithPlacement:(NSString *)placement{
    return [[TODataBaseTools dbTools] getObjectById:placement];
    
}

- (void)putLastShowTime:(NSString *)time index:(NSString *)index placementID:(NSString *)placementID{
    
    NSDictionary *dic = @{@"TOLASTINDEX":index,@"TOLASTSHOWTIME":time};
    [[TODataBaseTools dbTools] putObject:dic withId:placementID];
    
}

-(TOUnitModel *)getRVDefaultUnitConfig{
    NSDictionary *rvDic = [[TODataBaseTools dbTools] getObjectById:kRVModel];
    __block TOUnitModel *rvModel;
    if (!kISNullDict(rvDic)) {
        rvModel = [TOUnitModel mj_objectWithKeyValues:rvDic];
    }
    return rvModel;
    
}


@end
