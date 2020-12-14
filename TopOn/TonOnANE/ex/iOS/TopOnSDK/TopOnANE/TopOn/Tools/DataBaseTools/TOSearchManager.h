//
//  TOSearchManager.h
//
//  Created by 洋吴 on 2019/5/7.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOSettingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TOSearchManager : NSObject

+ (TOSearchManager *)shareManager;

//获取unit配置文件
- (TOUnitModel *)getUnitConfigWithPlacementID:(NSString *)placementID;

//获取本地unitConfig
- (TOUnitModel *)getDefaultUnitConfigWithKey:(NSString *)key unitId:(NSString *_Nullable)unitid;

#pragma IV&RV
//获取上次展示时间以及游标
- (NSDictionary *)getLastShowTimeAndIndexWithPlacement:(NSString *)placement;

//存储上次展示时间及游标
- (void)putLastShowTime:(NSString *)time index:(NSString *)index placementID:(NSString *)placementID;


@end

NS_ASSUME_NONNULL_END
