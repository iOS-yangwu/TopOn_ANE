//
//  TOAdvertManager+interstitial.h
//
//  Created by 洋吴 on 2019/5/5.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "TOAdvertManager.h"
#import "TOSearchManager.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOAdvertManager (interstitial)

//Interstitial
- (void)loadInterstitialWithPlacementId:(NSString*)placementId;

- (BOOL)isReadyInterstitialWithPlacementId:(NSString *)placementId;

- (void)showInterstitialWithPlacementId:(NSString *)placementId;

@end

NS_ASSUME_NONNULL_END
