#!/bin/sh

rm -rf tmp
rm -f TopOnAdvert.ane

RootPath=$(cd "$(dirname "$0")"; pwd)
echo $RootPath

mkdir tmp
cp -r ../Lib/bin/TopOnAdvertLib.swc  tmp

#GoogleMobileAds
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Admob/GoogleMobileAds.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Admob/PersonalizedAdConsent.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Admob/GoogleAppMeasurement.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Admob/GoogleUtilities.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Admob/nanopb.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Admob/PromisesObjC.framework tmp
#AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Admob/AnyThinkAdmobBannerAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Admob/AnyThinkAdmobInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Admob/AnyThinkAdmobRewardedVideoAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Admob/AnyThinkAdmobNativeAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Admob/AnyThinkAdmobSplashAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Admob/UserMessagingPlatform.framework tmp

admob="GoogleMobileAds.framework AnyThinkAdmobBannerAdapter.framework AnyThinkAdmobInterstitialAdapter.framework AnyThinkAdmobRewardedVideoAdapter.framework AnyThinkAdmobNativeAdapter.framework PersonalizedAdConsent.framework AnyThinkAdmobSplashAdapter.framework GoogleAppMeasurement.framework UserMessagingPlatform.framework GoogleUtilities.framework nanopb.framework PromisesObjC.framework"

#AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Anythink/AnyThinkSDK.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Anythink/AnyThinkBanner.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Anythink/AnyThinkInterstitial.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Anythink/AnyThinkRewardedVideo.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Anythink/AnyThinkSDK.bundle tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Anythink/AnyThinkNative.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Anythink/AnyThinkSplash.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Anythink/ANE.bundle tmp


AnyThink="AnyThinkSDK.framework AnyThinkBanner.framework AnyThinkInterstitial.framework AnyThinkRewardedVideo.framework AnyThinkSDK.bundle/ AnyThinkNative.framework AnyThinkSplash.framework ANE.bundle/"

# Unity 2
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/UnityAds/UnityAds.framework tmp
#AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/UnityAds/AnyThinkUnityAdsRewardedVideoAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/UnityAds/AnyThinkUnityAdsInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/UnityAds/AnyThinkUnityAdsBannerAdapter.framework tmp


unity="UnityAds.framework AnyThinkUnityAdsInterstitialAdapter.framework AnyThinkUnityAdsRewardedVideoAdapter.framework AnyThinkUnityAdsBannerAdapter.framework"


# Vungle 3
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Vungle/VungleSDK.framework tmp
# AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Vungle/AnyThinkVungleInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Vungle/AnyThinkVungleRewardedVideoAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Vungle/AnyThinkVungleBannerAdapter.framework tmp


vungle="VungleSDK.framework AnyThinkVungleInterstitialAdapter.framework AnyThinkVungleRewardedVideoAdapter.framework AnyThinkVungleBannerAdapter.framework"

# AppLovin 4
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Applovin/AppLovinSDK.framework tmp

#AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Applovin/AnyThinkApplovinBannerAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Applovin/AnyThinkApplovinInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Applovin/AnyThinkApplovinRewardedVideoAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Applovin/AnyThinkApplovinNativeAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Applovin/AppLovinSDKResources.bundle tmp

applovin="AppLovinSDK.framework AnyThinkApplovinNativeAdapter.framework AnyThinkApplovinBannerAdapter.framework AnyThinkApplovinInterstitialAdapter.framework AnyThinkApplovinRewardedVideoAdapter.framework AppLovinSDKResources.bundle/"

# GDT 5
#cp -r ../ex/iOS/TopOnANE/UPSDK/3rdsdk/GDT/libGDTMobSDK.a tmp

#AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/GDT/AnyThinkGDTBannerAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/GDT/AnyThinkGDTInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/GDT/AnyThinkGDTRewardedVideoAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/GDT/AnyThinkGDTNativeAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/GDT/AnyThinkGDTSplashAdapter.framework tmp

gdt="AnyThinkGDTNativeAdapter.framework AnyThinkGDTBannerAdapter.framework AnyThinkGDTInterstitialAdapter.framework AnyThinkGDTRewardedVideoAdapter.framework AnyThinkGDTSplashAdapter.framework"

# Mintegral 6
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/MTGSDK.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/MTGSDKReward.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/MTGSDKInterstitial.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/MTGSDKInterstitialVideo.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/MTGSDKNativeAdvanced.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/MTGSDKBidding.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/MTGSDKBanner.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/MTGSDKSplash.framework tmp

#AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/AnyThinkMintegralInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/AnyThinkMintegralRewardedVideoAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/AnyThinkMintegralNativeAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/AnyThinkMintegralBannerAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Mintegral/AnyThinkMintegralSplashAdapter.framework tmp


#
mintegral="MTGSDKSplash.framework MTGSDK.framework MTGSDKReward.framework MTGSDKNativeAdvanced.framework MTGSDKInterstitial.framework MTGSDKInterstitialVideo.framework AnyThinkMintegralInterstitialAdapter.framework AnyThinkMintegralRewardedVideoAdapter.framework AnyThinkMintegralNativeAdapter.framework MTGSDKBidding.framework MTGSDKBanner.framework AnyThinkMintegralBannerAdapter.framework AnyThinkMintegralSplashAdapter.framework"


# Toutiao 7
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/TT/BUAdSDK.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/TT/BUAdSDK.bundle tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/TT/BUFoundation.framework tmp

#AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/TT/AnyThinkTTBannerAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/TT/AnyThinkTTInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/TT/AnyThinkTTRewardedVideoAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/TT/AnyThinkTTNativeAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/TT/AnyThinkTTSplashAdapter.framework tmp


toutiao="BUAdSDK.framework BUAdSDK.bundle/ AnyThinkTTBannerAdapter.framework AnyThinkTTInterstitialAdapter.framework AnyThinkTTRewardedVideoAdapter.framework AnyThinkTTNativeAdapter.framework BUFoundation.framework AnyThinkTTSplashAdapter.framework"

# IronSource 8
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/IronSource/IronSource.framework tmp
#AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/IronSource/AnyThinkIronSourceInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/IronSource/AnyThinkIronSourceRewardedVideoAdapter.framework tmp

ironsource="IronSource.framework AnyThinkIronSourceInterstitialAdapter.framework AnyThinkIronSourceRewardedVideoAdapter.framework"


# Facebook 9
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Facebook/FBAudienceNetwork.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Facebook/FBSDKCoreKit.framework tmp

## AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Facebook/AnyThinkFacebookBannerAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Facebook/AnyThinkFacebookInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Facebook/AnyThinkFacebookRewardedVideoAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Facebook/AnyThinkFacebookNativeAdapter.framework tmp

facebook="FBAudienceNetwork.framework FBSDKCoreKit.framework AnyThinkFacebookBannerAdapter.framework AnyThinkFacebookInterstitialAdapter.framework AnyThinkFacebookRewardedVideoAdapter.framework AnyThinkFacebookNativeAdapter.framework"


## adcolony 10
#cp -r ../ex/iOS/TopOnANE/TopOnANE/Thirds/AdColony/AdColony.framework tmp
## AnyThink
#cp -r ../ex/iOS/TopOnANE/TopOnANE/Thirds/AdColony/AnyThinkAdColonyInterstitialAdapter.framework tmp
#cp -r ../ex/iOS/TopOnANE/TopOnANE/Thirds/AdColony/AnyThinkAdColonyRewardedVideoAdapter.framework tmp
#
#
#adcolony="AdColony.framework AnyThinkAdColonyInterstitialAdapter.framework AnyThinkAdColonyRewardedVideoAdapter.framework"


#Baidu
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Baidu/BaiduMobAdSDK.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Baidu/baidumobadsdk.bundle tmp
# AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Baidu/AnyThinkBaiduBannerAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Baidu/AnyThinkBaiduInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Baidu/AnyThinkBaiduRewardedVideoAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Baidu/AnyThinkBaiduNativeAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Baidu/AnyThinkBaiduSplashAdapter.framework tmp

baidu="BaiduMobAdSDK.framework baidumobadsdk.bundle/ AnyThinkBaiduBannerAdapter.framework AnyThinkBaiduInterstitialAdapter.framework AnyThinkBaiduRewardedVideoAdapter.framework AnyThinkBaiduNativeAdapter.framework AnyThinkBaiduSplashAdapter.framework"

#maio
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Maio/Maio.framework tmp

# AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Maio/AnyThinkMaioInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Maio/AnyThinkMaioRewardedVideoAdapter.framework tmp

maio="Maio.framework AnyThinkMaioInterstitialAdapter.framework AnyThinkMaioRewardedVideoAdapter.framework"

#nend
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Nend/NendAd.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Nend/NendAdResource.bundle tmp

# AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Nend/AnyThinkNendBannerAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Nend/AnyThinkNendInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Nend/AnyThinkNendNativeAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Nend/AnyThinkNendRewardedVideoAdapter.framework tmp

nend="NendAd.framework AnyThinkNendBannerAdapter.framework AnyThinkNendInterstitialAdapter.framework AnyThinkNendNativeAdapter.framework AnyThinkNendRewardedVideoAdapter.framework NendAdResource.bundle"


#fyber
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Fyber/IASDKCore.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Fyber/IASDKMRAID.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Fyber/IASDKResources.bundle tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Fyber/IASDKVideo.framework tmp

# AnyThink
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Fyber/AnyThinkFyberBannerAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Fyber/AnyThinkFyberInterstitialAdapter.framework tmp
cp -r ../ex/iOS/TopOnSDK/TopOnANE/Thirds/Fyber/AnyThinkFyberRewardedVideoAdapter.framework tmp


fyber="IASDKCore.framework IASDKMRAID.framework IASDKResources.bundle/ IASDKVideo.framework AnyThinkFyberBannerAdapter.framework AnyThinkFyberInterstitialAdapter.framework AnyThinkFyberRewardedVideoAdapter.framework"


cp ./ios/libTopOnSDK.a tmp
cp ./ios/libTopOnSDK-iphonesimulator.a tmp


cd tmp


#test
 pathString="${AnyThink} ${mintegral} ${toutiao}"

#pathString="${admob} ${AnyThink} ${mintegral} ${gdt} ${unity} ${toutiao} ${baidu} ${applovin} ${facebook} ${ironsource} ${maio} ${nend} ${fyber}"

unzip ./TopOnAdvertLib.swc


adt -package -target ane ../TopOnAdvert.ane ../extension.xml -swc TopOnAdvertLib.swc -platform iPhone-ARM -platformoptions ../platformoptions.xml library.swf ${pathString} libTopOnSDK.a

#-platform iPhone-x86 -platformoptions ../platformoptions.xml library.swf ${pathString} libTopOnSDK-iphonesimulator.a
cd ..


rm -rf tmp
