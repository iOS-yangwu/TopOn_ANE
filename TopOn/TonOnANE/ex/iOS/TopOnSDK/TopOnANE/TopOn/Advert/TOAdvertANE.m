//
//  TOPONAdvertANE.m
//  TOPONSDK
//
//  Created by 洋吴 on 2019/5/14.
//  Copyright © 2019 洋吴. All rights reserved.
//

#import "TOAdvertANE.h"
#import "TOAdvertManager.h"
#import "TOAdvertManager+native.h"
#import "TOAdvertManager+nativeBanner.h"
#import "TOAdvertManager+banner.h"
#import "TOAdvertManager+interstitial.h"
#import "TOAdvertManager+rewardVideo.h"
#import "TOAdvertManager+nativeSplash.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
#import "TOAdatper.h"



TOPON_ANE_FUNCTION(SDK_INIT) {
    
    NSString *appId = TopOnAdvertGetStringFromFREObject(argv[0]);
    NSString *appKey = TopOnAdvertGetStringFromFREObject(argv[1]);
    BOOL isSuccess = [[TOAdvertManager manager] startSDKWithAppId:appId appKey:appKey];
    return TopOnAdvertCreateFREBool(isSuccess);
}

TOPON_ANE_FUNCTION(SDK_VERSION){
    
    NSString *sdkVersion = [[ATAPI sharedInstance]version];
    NSString *vs = [NSString stringWithFormat:@"TopOn SDK version：%@",sdkVersion];
    return TopOnAdvertCreateFREString(vs);
    
}

#pragma mark-  video
///video init
TOPON_ANE_FUNCTION(TO_VIDEO_START) {
    
    
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager loadVideoWithPlacementId:unitId];
    
    
    return NULL;
}

///isReadyVideo
TOPON_ANE_FUNCTION(TO_VIDEO_IS_READY) {
    
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    BOOL isReady = [manager isReadVideoWithPlacementId:unitId];
    return TopOnAdvertCreateFREBool(isReady);
}

///show video
TOPON_ANE_FUNCTION(TO_VIDEO_SHOW) {
    
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager showVideoWithPlacementId:unitId];
    return NULL;
}


#pragma mark- interstitial
///interstitial init
TOPON_ANE_FUNCTION(TO_INTERSTITIAL_START) {
    
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager loadInterstitialWithPlacementId:unitId];
    return NULL;
}

///interstitial ready
TOPON_ANE_FUNCTION(TO_INTERSTITIAL_IS_READY) {
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    BOOL isReady = [manager isReadyInterstitialWithPlacementId:unitId];
    return TopOnAdvertCreateFREBool(isReady);
}

///interstitial show
TOPON_ANE_FUNCTION(TO_INTERSTITIAL_SHOW) {
    
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager showInterstitialWithPlacementId:unitId];
    return NULL;
}

#pragma mark - nativeBanner
///load nativeBanner
TOPON_ANE_FUNCTION(TO_NATIVE_BANNER_START) {
    
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager loadNativeBannerWithPlacementId:unitId];
    return NULL;
}

///set align of nativeBanner offset
TOPON_ANE_FUNCTION(TO_SET_NATIVE_BANNER_ALIGN) {
    
    NSString *align = TopOnAdvertGetStringFromFREObject(argv[0]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager setNativeBannerAlign:align offset:CGPointZero];

    return NULL;
}

///show nativeBanner
TOPON_ANE_FUNCTION(TO_NATIVE_BANNER_SHOW) {
    
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager showNativeBannerWithPlacementId:unitId];
    return NULL;
}

///hide nativeBanner
TOPON_ANE_FUNCTION(TO_NATIVE_BANNER_HIDE) {

    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager hideNativeBanner];
    return NULL;
}

///isReady nativeBanner
TOPON_ANE_FUNCTION(TO_NATIVE_BANNER_IS_READY) {
    
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    BOOL isReady = [manager isReadyNativeBannerWithPlacement:unitId];
    return TopOnAdvertCreateFREBool(isReady);
}

///remove nativeBanner
TOPON_ANE_FUNCTION(TO_NATIVE_BANNER_REMOVE) {
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager removeNativeBanner];
    return NULL;
}


#pragma mark- native
TOPON_ANE_FUNCTION(TO_NATIVE_START){
    float w = TopOnAdvertGetDoubleFromFREObject(argv[0]);
    float h = TopOnAdvertGetDoubleFromFREObject(argv[1]);
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[2]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager loadNativeAdWithPlacementId:unitId nativeFrame:CGRectMake(0, 0, w, h)];
    
    return NULL;
}

TOPON_ANE_FUNCTION(TO_NATIVE_IS_READY){
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    BOOL isReady = [manager isReadyNativeAdWithPlacementId:unitId];
    return TopOnAdvertCreateFREBool(isReady);
}

TOPON_ANE_FUNCTION(TO_NATIVE_LAYOUT){
    float x = TopOnAdvertGetDoubleFromFREObject(argv[0]);
    float y = TopOnAdvertGetDoubleFromFREObject(argv[1]);
    float w = TopOnAdvertGetDoubleFromFREObject(argv[2]);
    float h = TopOnAdvertGetDoubleFromFREObject(argv[3]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager layoutNativeWithX:x Y:y W:w H:h];
    return NULL;
}

TOPON_ANE_FUNCTION(TO_NATIVE_SHOW){

    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[4]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager showNativeWithPlacementId:unitId];
    return NULL;
}

TOPON_ANE_FUNCTION(TO_NATIVE_REMOVE){
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager removeNative];
    return NULL;
}

#pragma mark - splash
TOPON_ANE_FUNCTION(TO_USER_PURCHASE){

    NSString *isIAP = TopOnAdvertGetStringFromFREObject(argv[0]);
    [[TOAdvertManager manager] showSplashWithIAP:isIAP];
    return NULL;
    
}

TOPON_ANE_FUNCTION(TO_STOP_DISPLAYLINK){
    [[TOAdvertManager manager]stopDisplayLink];
    return NULL;
}

TOPON_ANE_FUNCTION(TO_ISREADY_IV){
    BOOL isready = [TOAdvertManager manager].isReadyInterstital;
    return TopOnAdvertCreateFREBool(isready);
}

#pragma mark - banner
///load banner
TOPON_ANE_FUNCTION(TO_BANNER_START) {
    
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager loadBannerWithPlacementId:unitId];
    return NULL;
}

///set align of banner offset
TOPON_ANE_FUNCTION(TO_SET_BANNER_ALIGN) {
    
    NSString *align = TopOnAdvertGetStringFromFREObject(argv[0]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager setBannerAlign:align offset:CGPointZero];

    return NULL;
}

///show banner
TOPON_ANE_FUNCTION(TO_BANNER_SHOW) {
    
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager showBannerWithPlacementId:unitId];
    return NULL;
}

///hide nativeBanner
TOPON_ANE_FUNCTION(TO_BANNER_HIDE) {

    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager hideBanner];
    return NULL;
}

///isReady banner
TOPON_ANE_FUNCTION(TO_BANNER_IS_READY) {
    
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    NSString* unitId = TopOnAdvertGetStringFromFREObject(argv[0]);
    BOOL isReady = [manager isReadyBannerWithPlacement:unitId];
    return TopOnAdvertCreateFREBool(isReady);
}

///remove banner
TOPON_ANE_FUNCTION(TO_BANNER_REMOVE) {
    TOAdvertManager *manager = [[TOAdvertManager alloc]initSDK];
    [manager removeBanner];
    return NULL;
}

TOPON_ANE_FUNCTION(TO_IS_READY_IV){
    
    BOOL isready = [TOAdvertManager manager].isReadyInterstital;
    return TopOnAdvertCreateFREBool(isready);
    
}

TOPON_ANE_FUNCTION(TO_SET_LOG_ENABLE){
    
    [ATAPI setLogEnabled:YES];
    return NULL;
    
}
#pragma mark- FLASH
void TOPONANEInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    
    static FRENamedFunction func[] =
    {
        //SDK Init
        TOPON_MAP_FUNCTION(SDK_INIT,NULL),
        TOPON_MAP_FUNCTION(SDK_VERSION, NULL),
        //Video
        TOPON_MAP_FUNCTION(TO_VIDEO_START,NULL),
        TOPON_MAP_FUNCTION(TO_VIDEO_IS_READY,NULL),
        TOPON_MAP_FUNCTION(TO_VIDEO_SHOW,NULL),
        //Interstitial
        TOPON_MAP_FUNCTION(TO_INTERSTITIAL_START,NULL),
        TOPON_MAP_FUNCTION(TO_INTERSTITIAL_IS_READY,NULL),
        TOPON_MAP_FUNCTION(TO_INTERSTITIAL_SHOW,NULL),
        //Banner
        TOPON_MAP_FUNCTION(TO_BANNER_START,NULL),
        TOPON_MAP_FUNCTION(TO_SET_BANNER_ALIGN,NULL),
        TOPON_MAP_FUNCTION(TO_BANNER_SHOW,NULL),
        TOPON_MAP_FUNCTION(TO_BANNER_HIDE,NULL),
        TOPON_MAP_FUNCTION(TO_BANNER_IS_READY,NULL),
        TOPON_MAP_FUNCTION(TO_BANNER_REMOVE, NULL),
        //nativeBanner
        TOPON_MAP_FUNCTION(TO_NATIVE_BANNER_START,NULL),
        TOPON_MAP_FUNCTION(TO_SET_NATIVE_BANNER_ALIGN,NULL),
        TOPON_MAP_FUNCTION(TO_NATIVE_BANNER_SHOW,NULL),
        TOPON_MAP_FUNCTION(TO_NATIVE_BANNER_HIDE,NULL),
        TOPON_MAP_FUNCTION(TO_NATIVE_BANNER_IS_READY,NULL),
        TOPON_MAP_FUNCTION(TO_NATIVE_BANNER_REMOVE, NULL),
        //Native
        TOPON_MAP_FUNCTION(TO_NATIVE_START, NULL),
        TOPON_MAP_FUNCTION(TO_NATIVE_IS_READY, NULL),
        TOPON_MAP_FUNCTION(TO_NATIVE_SHOW, NULL),
        TOPON_MAP_FUNCTION(TO_NATIVE_REMOVE, NULL),
        TOPON_MAP_FUNCTION(TO_NATIVE_LAYOUT, NULL),
        //Splash
        TOPON_MAP_FUNCTION(TO_USER_PURCHASE,NULL),
        TOPON_MAP_FUNCTION(TO_STOP_DISPLAYLINK,NULL),
        TOPON_MAP_FUNCTION(TO_IS_READY_IV,NULL),
        TOPON_MAP_FUNCTION(TO_SET_LOG_ENABLE,NULL)
    
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    TopOnANEEventContext = ctx;
    
}

void TOPONANEFinalizer(FREContext ctx) {
    // clean
}

void TOPONANEExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TOPONANEInitializer;
    *ctxFinalizerToSet = &TOPONANEFinalizer;
}

void TOPONANEExtensionFinalizer(void* extData) {
    // clean
}

