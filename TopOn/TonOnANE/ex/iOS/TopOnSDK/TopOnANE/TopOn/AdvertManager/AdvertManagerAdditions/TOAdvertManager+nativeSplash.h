//
//  TOAdvertManager+nativeSplash.h
//  TopOnSDK
//
//  Created by 洋吴 on 2019/6/20.
//  Copyright © 2019 洋吴. All rights reserved.
//

#import "TOAdvertManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TOAdvertManager (nativeSplash)

@property(nonatomic,strong,nullable) NSString *backgroundTime;

@property(nonatomic,strong,nullable) UIView *backgroundView;

@property(nonatomic,strong,nullable) CADisplayLink *disLink;

- (void)loadNativeSplashWithPlacementId:(NSString*)placementId;

- (BOOL)isReadyNativeSplashWithPlacementId:(NSString *)placementId;

- (void)showNativeSplashWithPlacementId:(NSString *)placementId;

- (void)stopDisplayLink;

- (void)failToLoadSplash;

- (void)removeBackgroundView;

- (void)showSplashWithIAP:(NSString *)IAP;



@end

NS_ASSUME_NONNULL_END
