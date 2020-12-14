//
//  TOFunctions.h
//  TopOnSDK
//
//  Created by 洋吴 on 2019/5/14.
//  Copyright © 2019 洋吴. All rights reserved.
//

///初始化SDK
#define SDK_INIT                               initSDK

#define SDK_VERSION                            sdkVersion

///video
#define TO_VIDEO_START                      loadVideoWithUnitId
#define TO_VIDEO_IS_READY                    isReadyVideoWithUnitId
#define TO_VIDEO_SHOW                       showVideoWithUnitId

///interstitial
#define TO_INTERSTITIAL_START               loadInterstitialWithUnitId
#define TO_INTERSTITIAL_IS_READY             isReadyInterstitialWithUnitId
#define TO_INTERSTITIAL_SHOW                showInterstitialWithUnitId

///banner
#define TO_BANNER_START                     loadBannerWithUnitId
#define TO_SET_BANNER_ALIGN                 setBannerAlign
#define TO_BANNER_SHOW                      showBannerWithUnitId
#define TO_BANNER_HIDE                      hideBanner
#define TO_BANNER_IS_READY                  isReadyBannerWithUnitId
#define TO_BANNER_REMOVE                    removeBanner

///native banner
#define TO_NATIVE_BANNER_START              loadNativeBannerWithUnitId
#define TO_SET_NATIVE_BANNER_ALIGN          setNativeBannerAlign
#define TO_NATIVE_BANNER_SHOW               showNativeBannerWithUnitId
#define TO_NATIVE_BANNER_HIDE               hideNativeBanner
#define TO_NATIVE_BANNER_IS_READY           isReadyNativeBannerWithUnitId
#define TO_NATIVE_BANNER_REMOVE             removeNativeBanner

///native
#define TO_NATIVE_START                     loadNativeWithUnitId
#define TO_NATIVE_IS_READY                  isReadyNativeWithUnitId
#define TO_NATIVE_SHOW                      showNativeWithUnitId
#define TO_NATIVE_LAYOUT                    layoutWithFrame
#define TO_NATIVE_REMOVE                    removeNative

///开屏
#define TO_USER_PURCHASE                    setUserPurchase
#define TO_STOP_DISPLAYLINK                 stopDisplayLink
///临时方案
#define TO_IS_READY_IV                      IsReadyIV

#define TO_SET_LOG_ENABLE                   logEnable


