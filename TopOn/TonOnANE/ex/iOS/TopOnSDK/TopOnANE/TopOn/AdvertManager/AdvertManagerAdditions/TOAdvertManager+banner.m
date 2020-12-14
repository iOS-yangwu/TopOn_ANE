//
//  TOAdvertManager+banner.m
//  TopOnSDK
//
//  Created by 洋吴 on 2020/11/25.
//  Copyright © 2020 洋吴. All rights reserved.
//

#import "TOAdvertManager+banner.h"

@implementation TOAdvertManager (banner)

#pragma mark Banner
- (void)loadBannerWithPlacementId:(NSString*)placementId{
    
    TOUnitModel *bModel = [self getBannerUnitModelWithPlacementID:placementId];
    if (bModel.unitID != nil && [bModel.status isEqualToString:@"1"]) {
        
        [self.delegate loadADWithPlacementId:bModel.unitID adType:kADTypeBanner nativeFrame:CGRectZero];
    }
}


- (void)setBannerAlign:(NSString *)align offset:(CGPoint)offset{
    
    [self.delegate setBannerAlign:align offset:offset];
    
}

- (void)showBannerWithPlacementId:(NSString *)placementId{
    
    TOUnitModel *bModel = [self getBannerUnitModelWithPlacementID:placementId];
    [self showBannerWithUnitId:bModel.unitID adOrder:bModel.adOrder];
    
}

- (BOOL)isReadyBannerWithPlacement:(NSString *)placementId{
        
    TOUnitModel *bModel = [self getBannerUnitModelWithPlacementID:placementId];
    //获取最小时间间隔
    NSInteger getMinTimeInterval = [bModel.minTimeInterval integerValue];
    //获取最大时间间隔
    NSInteger getMaxTimeInterval = [bModel.maxTimeInterval integerValue];
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
    
    if ([bModel.status isEqualToString:@"1"]) {
        
        if (timeInterval >= getMinTimeInterval) {
            
            if (timeInterval >= getMaxTimeInterval) {
                
                return [self.delegate isReadyADWithADType:kADTypeBanner];
                 
            }else{
                
                if ([[self getBannerAdOrderWithIndex:idx adOrder:bModel.adOrder] isEqualToString:@"1"]) {
                    //调用show接口
                    
                    return [self.delegate isReadyADWithADType:kADTypeBanner];
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

- (void)hideBanner{
    
    [self.delegate hideBanner];
    
}
- (void)removeBanner{
    
    [self.delegate removeBanner];
}

#pragma mark 获取当前order
- (NSString *)getBannerAdOrderWithIndex:(int)index adOrder:(NSString *)adOrder{
    
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


- (void)showBannerWithUnitId:(NSString *)unitId adOrder:(NSString *)adOrder{
    
    [self.delegate showADWithADType:kADTypeBanner];
    
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

- (TOUnitModel *)getBannerUnitModelWithPlacementID:(NSString *)placementID{
    
    if (![TOAdvertManager manager].bannerModel) {
        TOUnitModel *bModel = [self.searchManager getUnitConfigWithPlacementID:placementID];
        if (!bModel) {
            bModel = [self.searchManager getDefaultUnitConfigWithKey:kbannerModel unitId:nil];
        }
        [TOAdvertManager manager].bannerModel = bModel;
        return bModel;
    }else{
        return [TOAdvertManager manager].bannerModel;
    }
    
}

@end
