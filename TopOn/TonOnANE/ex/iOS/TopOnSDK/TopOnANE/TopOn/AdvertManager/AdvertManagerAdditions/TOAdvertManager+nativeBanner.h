//
//  TOAdvertManager+banner.h
//
//  Created by 洋吴 on 2019/5/9.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "TOAdvertManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TOAdvertManager (nativeBanner)

//nativeBanner
- (void)loadNativeBannerWithPlacementId:(NSString *)placementId;

- (void)setNativeBannerAlign:(NSString *)align offset:(CGPoint)offset;

- (void)showNativeBannerWithPlacementId:(NSString *)placementId;

- (BOOL)isReadyNativeBannerWithPlacement:(NSString *)placementId;

- (void)hideNativeBanner;

- (void)removeNativeBanner;

@end

NS_ASSUME_NONNULL_END
