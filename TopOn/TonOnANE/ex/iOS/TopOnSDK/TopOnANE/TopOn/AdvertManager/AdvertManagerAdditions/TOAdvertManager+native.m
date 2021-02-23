//
//  TOAdvertManager+native.m
//
//  Created by 洋吴 on 2019/5/8.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "TOAdvertManager+native.h"

@implementation TOAdvertManager (native)


- (void)loadNativeAdWithPlacementId:(NSString *)placementId nativeFrame:(CGRect)frame{

    TOUnitModel *nModel = [self getNativeUnitModelWithPlacementID:placementId];
    
    if (nModel.unitID != nil && [nModel.status isEqualToString:@"1"]) {
        //请求广告
        [self.delegate loadADWithPlacementId:nModel.unitID adType:kADTypeNative nativeFrame:frame];
    }
}

- (BOOL)isReadyNativeAdWithPlacementId:(NSString *)placementId{
    
    TOUnitModel *nModel = [self getNativeUnitModelWithPlacementID:placementId];
    //获取最小时间间隔
    NSInteger getMinTimeInterval = [nModel.minTimeInterval integerValue];
    //获取最大时间间隔
    NSInteger getMaxTimeInterval = [nModel.maxTimeInterval integerValue];
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
    
    if ([nModel.status isEqualToString:@"1"]) {
        
        if (timeInterval >= getMinTimeInterval) {
            
            if (timeInterval >= getMaxTimeInterval) {
                
                return [self.delegate isReadyADWithADType:kADTypeNative];
                
            }else{
                if ([[self getNativeAdOrderWithIndex:idx adOrder:nModel.adOrder] isEqualToString:@"1"]) {
                    
                    return [self.delegate isReadyADWithADType:kADTypeNative];
                    
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

- (void)layoutNativeWithX:(CGFloat)x Y:(CGFloat)y W:(CGFloat)w H:(CGFloat)h{
    
    [self.delegate layoutNativeWithX:x Y:y W:w H:h];
}

- (void)showNativeWithPlacementId:(NSString *)placementId{
    
    TOUnitModel *nModel = [self getNativeUnitModelWithPlacementID:placementId];
    
    [self showNativeWithunitId:nModel.unitID adOrder:nModel.adOrder];
    
}

- (void)showNativeWithunitId:(NSString *)unitID adOrder:(NSString *)adOrder{

    //show native
    [self.delegate showADWithADType:kADTypeNative];
    
    //数据上报
    if (!kISNullString(unitID) && !kISNullString(adOrder)) {
        
        NSDictionary *para = [self.searchManager getLastShowTimeAndIndexWithPlacement:unitID];
        
        int nativeIndex;
        if (!kISNullDict(para)) {
            
            nativeIndex = [para[@"TOLASTINDEX"] intValue];
        }else{
            
            nativeIndex = 0;
        }
        
        nativeIndex = nativeIndex < adOrder.length - 1 ? nativeIndex + 1 : 0;
        [self.searchManager putLastShowTime:[NSDate getCurrentTime] index:[NSString stringWithFormat:@"%d",nativeIndex] placementID:unitID];
    }
}

- (void)removeNative{

    [self.delegate removeNative];
}


#pragma mark 获取adorder
- (NSString *)getNativeAdOrderWithIndex:(NSInteger)index adOrder:(NSString *)adOrder{

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

- (TOUnitModel *)getNativeUnitModelWithPlacementID:(NSString *)placementID{
    
    if (![TOAdvertManager manager].nativeModel) {
        TOUnitModel *nModel = [self.searchManager getUnitConfigWithPlacementID:placementID];
        if (!nModel) {
            nModel = [self.searchManager getDefaultUnitConfigWithKey:kNativeModel unitId:nil];
        }
        [TOAdvertManager manager].nativeModel = nModel;
        return nModel;
    }else{
        return [TOAdvertManager manager].nativeModel;
    }
}

@end
