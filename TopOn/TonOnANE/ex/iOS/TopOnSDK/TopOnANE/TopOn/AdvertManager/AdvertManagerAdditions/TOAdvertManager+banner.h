//
//  TOAdvertManager+banner.h
//  TopOnSDK
//
//  Created by 洋吴 on 2020/11/25.
//  Copyright © 2020 洋吴. All rights reserved.
//

#import "TOAdvertManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TOAdvertManager (banner)

//Banner
- (void)loadBannerWithPlacementId:(NSString *)placementId;

- (void)setBannerAlign:(NSString *)align offset:(CGPoint)offset;

- (void)showBannerWithPlacementId:(NSString *)placementId;

- (BOOL)isReadyBannerWithPlacement:(NSString *)placementId;

- (void)hideBanner;

- (void)removeBanner;

@end

NS_ASSUME_NONNULL_END
