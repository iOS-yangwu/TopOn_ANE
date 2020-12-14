//
//  TOAdvertManager+banner.m
//
//  Created by 洋吴 on 2019/5/9.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "TOAdvertManager+nativeBanner.h"

@implementation TOAdvertManager (nativeBanner)


#pragma mark nativeBanner
- (void)loadNativeBannerWithPlacementId:(NSString*)placementId{
    
    TOUnitModel *bModel = [self getNativeBannerUnitModelWithPlacementID:placementId];
    if (bModel.unitID != nil && [bModel.status isEqualToString:@"1"]) {
        
        [self.delegate loadADWithPlacementId:bModel.unitID adType:kADTypeNativeBanner nativeFrame:CGRectZero];
    }
}


- (void)setNativeBannerAlign:(NSString *)align offset:(CGPoint)offset{
    
    [self.delegate setBannerAlign:align offset:offset];
    
}

- (void)showNativeBannerWithPlacementId:(NSString *)placementId{
    
    TOUnitModel *bModel = [self getNativeBannerUnitModelWithPlacementID:placementId];
    [self showNativeBannerWithUnitId:bModel.unitID adOrder:bModel.adOrder];
    
}

- (BOOL)isReadyNativeBannerWithPlacement:(NSString *)placementId{
        
    TOUnitModel *nbModel = [self getNativeBannerUnitModelWithPlacementID:placementId];
    //获取最小时间间隔
    NSInteger getMinTimeInterval = [nbModel.minTimeInterval integerValue];
    //获取最大时间间隔
    NSInteger getMaxTimeInterval = [nbModel.maxTimeInterval integerValue];
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
    
    if ([nbModel.status isEqualToString:@"1"]) {
        
        if (timeInterval >= getMinTimeInterval) {
            
            if (timeInterval >= getMaxTimeInterval) {
                
                return [self.delegate isReadyADWithADType:kADTypeNativeBanner];
                 
            }else{
                
                if ([[self getNativeBannerAdOrderWithIndex:idx adOrder:nbModel.adOrder] isEqualToString:@"1"]) {
                    //调用show接口
                    
                    return [self.delegate isReadyADWithADType:kADTypeNativeBanner];
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

- (void)hideNativeBanner{
    
    [self.delegate hideBanner];
    
}
- (void)removeNativeBanner{
    
    [self.delegate removeBanner];
}

#pragma mark 获取当前order
- (NSString *)getNativeBannerAdOrderWithIndex:(int)index adOrder:(NSString *)adOrder{
    
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


- (void)showNativeBannerWithUnitId:(NSString *)unitId adOrder:(NSString *)adOrder{
    
    [self.delegate showADWithADType:kADTypeNativeBanner];
    
    if (!kISNullString(unitId) && !kISNullString(adOrder)) {
        
        NSDictionary *para = [self.searchManager getLastShowTimeAndIndexWithPlacement:unitId];
        
        int bannerIndex;
        if (!kISNullDict(para)) {
            
            bannerIndex = [para[@"TOLASTINDEX"] intValue];
        }else{
            
            bannerIndex = 0;
        }
        
        bannerIndex = bannerIndex < adOrder.length - 1 ? bannerIndex + 1 : 0;
        
        [self.searchManager putLastShowTime:[NSDate getCurrentTime] index:[NSString stringWithFormat:@"%d",bannerIndex] placementID:unitId];
        
    }
}

- (TOUnitModel *)getNativeBannerUnitModelWithPlacementID:(NSString *)placementID{
    
    if (![TOAdvertManager manager].nativeBannerModel) {
        TOUnitModel *bModel = [self.searchManager getUnitConfigWithPlacementID:placementID];
        if (!bModel) {
            bModel = [self.searchManager getDefaultUnitConfigWithKey:kNativeBannerModel unitId:nil];
        }
        [TOAdvertManager manager].nativeBannerModel = bModel;
        return bModel;
    }else{
        return [TOAdvertManager manager].nativeBannerModel;
    }
    
}

@end
