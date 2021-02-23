//
//  TOProtocal.h
//
//  Created by 洋吴 on 2019/3/21.
//  Copyright © 2019 yodo1. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TOConst.h"

@protocol TOProtocal <NSObject>

#pragma mark 
- (BOOL)initSDKWithAppId:(NSString *)appId appKey:(NSString *)appKey;

#pragma mark common
- (void)loadADWithPlacementId:(NSString*)placementId adType:(ADType)type nativeFrame:(CGRect)frame;

- (void)showADWithADType:(ADType)type;

- (BOOL)isReadyADWithADType:(ADType)type;

#pragma mark banner
- (void)setBannerAlign:(NSString *)align offset:(CGPoint)offset;

- (void)hideBanner;

- (void)removeBanner;

#pragma mark native
- (void)layoutNativeWithX:(CGFloat)x Y:(CGFloat)y W:(CGFloat)w H:(CGFloat)h;

- (void)showNative;

- (void)removeNative;

@end


