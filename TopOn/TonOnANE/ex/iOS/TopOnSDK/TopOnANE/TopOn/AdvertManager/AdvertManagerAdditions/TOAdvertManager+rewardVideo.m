//
//  TOAdvertManager+rewardVideo.m
//
//  Created by 洋吴 on 2019/5/6.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "TOAdvertManager+rewardVideo.h"

@implementation TOAdvertManager (rewardVideo)


- (void)loadVideoWithPlacementId:(NSString*)placementId{
    
    TOUnitModel *rewardViedoModel = [self getRVUnitModelWithPlacementID:placementId];
    
    if (rewardViedoModel.unitID != nil && [rewardViedoModel.status isEqualToString:@"1"]) {
        //请求广告
        
        [self.delegate loadADWithPlacementId:rewardViedoModel.unitID adType:kADTypeVideo nativeFrame:CGRectZero];
    }else{
        
    }
}

- (BOOL)isReadVideoWithPlacementId:(NSString *)placementId{
    
    TOUnitModel *rewardViedoModel = [self getRVUnitModelWithPlacementID:placementId];
    //获取最小时间间隔
    NSInteger getMinTimeInterval = [rewardViedoModel.minTimeInterval integerValue];
    //获取最大时间间隔
    NSInteger getMaxTimeInterval = [rewardViedoModel.maxTimeInterval integerValue];
    //获取上次广告展示时间
    NSDictionary *para = [self.searchManager getLastShowTimeAndIndexWithPlacement:placementId];
    NSString *lastShowTime;
    int idx;
    if (!kISNullDict(para)) {
        lastShowTime = para[@"TOLASTSHOWTIME"];
        idx = [para[@"TOLASTINDEX"] intValue];
    }else{
        lastShowTime = [NSDate getCurrentTime];
        idx = 0;
    }
    
    //获取当前时间
    NSString *nowShowTime = [NSDate getCurrentTime];
    //这次展示距离上次展示时间
    NSInteger timeInterval = [NSDate timeIntervalFromLastTime:lastShowTime ToCurrentTime:nowShowTime];
    
    if ([rewardViedoModel.status isEqualToString:@"1"]) {
        
        if (timeInterval >= getMinTimeInterval) {
            
            if (timeInterval >= getMaxTimeInterval) {

                return [self.delegate isReadyADWithADType:kADTypeVideo];
                
            }else{
                
                if ([[self getRVAdOrderWithIndex:idx adOrder:rewardViedoModel.adOrder] isEqualToString:@"1"]) {
                    
                    return [self.delegate isReadyADWithADType:kADTypeVideo];
                     
                }else{
                    
                    return NO;
                }
            }
        }else{
            
            return NO;
        }
    }else{
        
        return NO;
    }
    
}

- (void)showVideoWithPlacementId:(NSString *)placementId {
    
    TOUnitModel *rvModel = [self getRVUnitModelWithPlacementID:placementId];
    
    [self showRVWithunitID:rvModel.unitID adOrder:rvModel.adOrder];
    
}

- (void)showRVWithunitID:(NSString *)unitID adOrder:(NSString *)adOrder{
    
    [self.delegate showADWithADType:kADTypeVideo];
    if (!kISNullString(unitID)&&!kISNullString(adOrder)) {
        
        NSDictionary *para = [self.searchManager getLastShowTimeAndIndexWithPlacement:unitID];
        
        int rvIndex;
        if (!kISNullDict(para)) {
            
            rvIndex = [para[@"TOLASTINDEX"] intValue];
        }else{
            
            rvIndex = 0;
        }
        
        rvIndex = rvIndex < adOrder.length - 1 ? rvIndex+1 : 0;
        
        
        [self.searchManager putLastShowTime:[NSDate getCurrentTime] index:[NSString stringWithFormat:@"%d",rvIndex] placementID:unitID];
        
    }
}

- (NSString *)getRVAdOrderWithIndex:(NSInteger)index adOrder:(NSString *)adOrder{
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i=0; i<adOrder.length; i++) {
        [arrM addObject:[adOrder substringWithRange:NSMakeRange(i, 1)]];
    }
    if (index > adOrder.length - 1) {
        return arrM[0];
    }else{
        return arrM[index];
    }
}

- (TOUnitModel *)getRVUnitModelWithPlacementID:(NSString *)placementID{
    
    if (![TOAdvertManager manager].rvUnitModel) {
        TOUnitModel *RVUnitModel = [self.searchManager getUnitConfigWithPlacementID:placementID];
        if (!RVUnitModel) {
            RVUnitModel = [self.searchManager getDefaultUnitConfigWithKey:kRVModel unitId:nil];
        }
        return RVUnitModel;
    }else{
        return [TOAdvertManager manager].rvUnitModel;
    }
    
}

@end
