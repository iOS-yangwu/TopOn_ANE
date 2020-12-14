//
//  TOAdvertManager+interstitial.m
//
//  Created by 洋吴 on 2019/5/5.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "TOAdvertManager+interstitial.h"

@implementation TOAdvertManager (interstitial)


- (void)loadInterstitialWithPlacementId:(NSString*)placementId{
    
    TOUnitModel *iModel = [self getIVUnitModelWithPlacementID:placementId];
    if (iModel.unitID != nil && [iModel.status isEqualToString:@"1"]) {
        //请求广告
        [self.delegate loadADWithPlacementId:iModel.unitID adType:kADTypeIterstital nativeFrame:CGRectZero];
    }
}

- (BOOL)isReadyInterstitialWithPlacementId:(NSString *)placementId{
        
    TOUnitModel *IVModel = [self getIVUnitModelWithPlacementID:placementId];

    //获取最小时间间隔
    NSInteger getMinTimeInterval = [IVModel.minTimeInterval integerValue];
    //获取最大时间间隔
    NSInteger getMaxTimeInterval = [IVModel.maxTimeInterval integerValue];
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
    
    if ([IVModel.status isEqualToString:@"1"]) {
        
        if (timeInterval >= getMinTimeInterval) {
            
            if (timeInterval >= getMaxTimeInterval && getMaxTimeInterval != 0) {
                
                [TOAdvertManager manager].isReadyInterstital = YES;

                return [self.delegate isReadyADWithADType:kADTypeIterstital];
                
                
            }else{
                
                if ([[self getAdOrderWithIndex:idx adOrder:IVModel.adOrder] isEqualToString:@"1"]) {
                    
                    //调用show接口
                    [TOAdvertManager manager].isReadyInterstital = YES;
                    
                    return [self.delegate isReadyADWithADType:kADTypeIterstital];
                    
                }else{
                    
                    idx = idx < IVModel.adOrder.length - 1 ? idx+1 : 0;
                    [self.searchManager putLastShowTime:lastShowTime index:[NSString stringWithFormat:@"%d",idx] placementID:placementId];
                    [TOAdvertManager manager].isReadyInterstital = NO;
                    
                    return NO;
                }
            }
        }else{
            
            if (![[self getAdOrderWithIndex:idx adOrder:IVModel.adOrder] isEqualToString:@"1"]){
                idx = idx < IVModel.adOrder.length - 1 ? idx+1 : 0;
                [self.searchManager putLastShowTime:lastShowTime index:[NSString stringWithFormat:@"%d",idx] placementID:placementId];
            }
            [TOAdvertManager manager].isReadyInterstital = NO;
            
            return NO;
        }
    }else{
        
        [TOAdvertManager manager].isReadyInterstital = NO;
        return NO;
    }
}

- (void)showInterstitialWithPlacementId:(NSString *)placementId{
    
    TOUnitModel *ivModel = [self getIVUnitModelWithPlacementID:placementId];
    
    [self showIVWithUnitId:ivModel.unitID adOrder:ivModel.adOrder];
    
}

- (void)showIVWithUnitId:(NSString *)unitId adOrder:(NSString *)adOrder{
    
    //调用show IV
    [self.delegate showADWithADType:kADTypeIterstital];
    
    //数据上报
    if (!kISNullString(unitId) && !kISNullString(adOrder)) {
        
        NSDictionary *para = [self.searchManager getLastShowTimeAndIndexWithPlacement:unitId];
        
        int interIndex;
        if (!kISNullDict(para)) {
            
            interIndex = [para[@"TOLASTINDEX"] intValue];
        }else{
            
            interIndex = 0;
        }
        
        interIndex = interIndex < adOrder.length - 1 ? interIndex+1 : 0;
        
        [self.searchManager putLastShowTime:[NSDate getCurrentTime] index:[NSString stringWithFormat:@"%d",interIndex] placementID:unitId];
        
    }
}

#pragma mark 获取当前order
- (NSString *)getAdOrderWithIndex:(int)index adOrder:(NSString *)adOrder{
    
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

- (TOUnitModel *)getIVUnitModelWithPlacementID:(NSString *)placementID{
    
    if (![TOAdvertManager manager].ivUnitModel) {
        
        TOUnitModel *iModel = [self.searchManager getUnitConfigWithPlacementID:placementID];
        if (!iModel) {
            iModel = [self.searchManager getDefaultUnitConfigWithKey:kIVModel unitId:placementID];
            if (iModel) {
                [self.searchManager putLastShowTime:[NSDate getCurrentTime] index:@"0" placementID:placementID];
            }
        }
        [TOAdvertManager manager].ivUnitModel = iModel;
        return [TOAdvertManager manager].ivUnitModel;
        
    }else{
        return [TOAdvertManager manager].ivUnitModel;
    }
}

@end
