//
//  TOAdvertManager+native.h
//
//  Created by 洋吴 on 2019/5/8.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "TOAdvertManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TOAdvertManager (native)

//Native
- (void)loadNativeAdWithPlacementId:(NSString *)placementId nativeFrame:(CGRect)frame;

- (BOOL)isReadyNativeAdWithPlacementId:(NSString *)placementId;

- (void)layoutNativeWithX:(CGFloat)x Y:(CGFloat)y W:(CGFloat)w H:(CGFloat)h;

- (void)showNativeWithPlacementId:(NSString *)placementId;

- (void)removeNative;


@end

NS_ASSUME_NONNULL_END
