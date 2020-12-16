//
//  TOAdvertANEUtils.h
//  TopOnSDK
//
//  Created by 洋吴 on 2019/5/14.
//  Copyright © 2019 洋吴. All rights reserved.
//



#import "FlashRuntimeExtensions.h"
#import <Foundation/Foundation.h>



#define TOPON_IMP_ANE_FUNCTION(f) FREObject (UPANE_##f)(FREContext ctx, void *data, uint32_t argc, FREObject argv[])

#define TOPON_IMP_MAP_FUNCTION(f, data) { (const uint8_t*)(#f), (data), &(UPANE_##f) }

#define TOPON_ANE_FUNCTION(f) TOPON_IMP_ANE_FUNCTION(f)
#define TOPON_MAP_FUNCTION(f, data) TOPON_IMP_MAP_FUNCTION(f, data)

//extern  FREContext ktplayANEEventContext;
/*--------------------------------string------------------------------------*/

NSString * TopOnAdvertGetStringFromFREObject(FREObject obj);

FREObject TopOnAdvertCreateFREString(NSString * string);
/*-------------------------------double-----------------------------------*/
double TopOnAdvertGetDoubleFromFREObject(FREObject obj);
FREObject TopOnAdvertCreateFREDouble(double value);
/*---------------------------------int---------------------------------*/
int TopOnAdvertGetIntFromFREObject(FREObject obj);
FREObject TopOnAdvertCreateFREInt(int value);
/*------------------------------bool----------------------------------------*/
BOOL TopOnAdvertGetBoolFromFREObject(FREObject obj);

FREObject TopOnAdvertCreateFREBool(BOOL value);

NSString *TopOnAdvertObj2ANEJSON(id obj);

void TopOnAdvertANEDispatchStatusEventAsyn(NSString  * type ,NSString *jsonString);

void TopOnAdvertSendANEMessage(int what,NSString *code,NSString *key,NSString *value);

void TopOnAdvertSendANEMessageWithDict(NSDictionary *dict,NSString *code);


typedef enum {
    //interstitial
    InterstitialClose = 0,
    InterstitialShow,
    InterstitialShowFail,
    InterstitialDidLoad,
    InterstitialLoadFail,
    InterstitialClick,//5
    //video
    VideoClose,
    VideoCilck,
    VideoShow,
    VideoShowFail,
    VideoDidLoad,
    VideoLoadFail,
    
    //banner
    BannerDidShow,
    BannerClose,
    BannerDidLoad,
    BannerLoadFail,//15
    BannerClick,
    //native
    NativeDidShow,
    NativeLoadFail,
    NativeClick,
    NativeStartPlay,
    NativeEndPlay,//21

    //others
    XCodeSendZERO,
    XCodeSendSixty,
    
    SplashDidShow, //24
    
    //native banner
    NativeBannerDidShow,
    NativeBannerClose,
    NativeBannerDidLoad,
    NativeBannerLoadFail,//28
    NativeBannerClick,
    
} TopOnAdvertANEEvent;

NSString* const kTopOnVideoCode        = @"TopOn_Video";
NSString* const kTopOnIntersCode       = @"TopOn_Interstitial";
NSString* const kTopOnBannerCode       = @"TopOn_Banner";
NSString* const kTopOnNativeCode       = @"TopOn_Native";
NSString* const kTopOnSplashCode       = @"TopOn_Splash";
NSString* const kXcodeSendMessage      = @"xCodeMessage";
NSString* const kTopOnNativeBannerCode = @"TopOn_NativeBanner";

