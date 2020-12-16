//
//  TOAdatper.m
//
//  Created by 洋吴 on 2019/3/21.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "TOAdatper.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkNative/AnyThinkNative.h>
#import <AnyThinkInterstitial/AnyThinkInterstitial.h>
#import <AnyThinkRewardedVideo/AnyThinkRewardedVideo.h>
#import <AnyThinkBanner/AnyThinkBanner.h>
#import "AdmobBannerManager.h"
#import "TOAdvertANEUtils.h"
#import "TOAdvertManager+nativeSplash.h"
#import "TOOriginNavtiveAdView.h"
#import "TOUtils.h"


@interface TOAdatper ()<
ATNativeADDelegate,
ATInterstitialDelegate,
ATNativeBannerDelegate,
ATNativeSplashDelegate,
ATRewardedVideoDelegate,
ATBannerDelegate>



@property(nonatomic, strong)NSString *nativeBannerUnitID;

@property(nonatomic, strong)NSString *bannerUnitID;

@property(nonatomic, strong)NSString *rvUnitID;

@property(nonatomic, strong)NSString *nativeUnitID;

@property(nonatomic, strong)NSString *ivUnitID;

@property(nonatomic, strong)NSString *splashUnitID;

@property(nonatomic, strong)ATNativeBannerView *nativeBanner;

@property(nonatomic, strong)UIView *banner;

@property(nonatomic, strong)TONativeADView *nativeView;

@property(nonatomic, assign)BOOL onReward;

@property(nonatomic, strong)UIViewController *rootVC;

@end

@implementation TOAdatper

#pragma mark instance
#pragma mark -
+ (TOAdatper *)adatper{
    static TOAdatper *adatper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        adatper = [[TOAdatper alloc]init];
    });
    return adatper;
}


- (BOOL)initSDKWithAppId:(NSString *)appId appKey:(NSString *)appKey{
    
    return [[ATAPI sharedInstance] startWithAppID:appId appKey:appKey error:nil];
}

#pragma mark - load ads
#pragma mark -
- (void) loadADWithPlacementId:(NSString *)placementId adType:(ADType)type nativeFrame:(CGRect)frame{
    
    if (type == kADTypeNative) {
        
        self.nativeUnitID = placementId;
        CGRect frameF = [TOUtils transformationToOCCoordinates:frame];
        [[ATAdManager sharedManager] loadADWithPlacementID:placementId extra:@{kExtraInfoNativeAdTypeKey:@(ATGDTNativeAdTypeSelfRendering), kATExtraNativeImageSizeKey:kATExtraNativeImageSize690_388,kExtraInfoNativeAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(frameF.size.width, frameF.size.height)]} delegate:self];
        
    }else if(type == kADTypeIterstital){
        
        self.ivUnitID = placementId;
        [[ATAdManager sharedManager]loadADWithPlacementID:placementId extra:nil delegate:self];
   
    }else if (type == kADTypeVideo){
        

        self.rvUnitID = placementId;
        NSString *idfv = [UIDevice currentDevice].identifierForVendor.UUIDString;
        [[ATAdManager sharedManager]loadADWithPlacementID:placementId extra:@{kATAdLoadingExtraUserIDKey:idfv} delegate:self];
       
    }else if (type == kADTypeNativeSplash){
        
        self.splashUnitID = placementId;
        [ATNativeSplashWrapper loadNativeSplashAdWithPlacementID:placementId extra:@{kExtraInfoNativeAdTypeKey:@(ATGDTNativeAdTypeSelfRendering), kExtraInfoNativeAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) -30.0f, 400.0f)], kATExtraNativeImageSizeKey:kATExtraNativeImageSize690_388} customData:nil delegate:self];
        
        
    }else if(type == kADTypeNativeBanner){
        
        self.nativeBannerUnitID = placementId;
        [ATNativeBannerWrapper loadNativeBannerAdWithPlacementID:placementId extra:@{kExtraInfoNativeAdTypeKey:@(ATGDTNativeAdTypeSelfRendering), kATExtraNativeImageSizeKey:kATExtraNativeImageSize690_388} customData:nil delegate:self];
        
    }else if (type == kADTypeBanner){
        
        self.bannerUnitID = placementId;
        [[ATAdManager sharedManager] loadADWithPlacementID:placementId extra:@{kATAdLoadingExtraBannerAdSizeKey:[NSValue valueWithCGSize:CGSizeMake([self adSize].size.width, [self adSize].size.height)]} delegate:self];
    }
}

#pragma mark - isReady ads
#pragma mark -
- (BOOL)isReadyADWithADType:(ADType)type {
    
    if (type == kADTypeNativeBanner) {
        
        return self.nativeBannerUnitID?[ATNativeBannerWrapper nativeBannerAdReadyForPlacementID:self.nativeBannerUnitID]:NO;
        
    }else if (type == kADTypeIterstital){
        
        return self.ivUnitID?[[ATAdManager sharedManager] interstitialReadyForPlacementID:self.ivUnitID]:NO;

    }else if (type == kADTypeVideo){
        
        return self.rvUnitID?[[ATAdManager sharedManager] rewardedVideoReadyForPlacementID:self.rvUnitID]:NO;
        
    }else if (type == kADTypeNativeSplash){
        
        return self.splashUnitID?[ATNativeSplashWrapper splashNativeAdReadyForPlacementID:self.splashUnitID]:NO;
        
    }else if (type == kADTypeNative){
        
        return self.nativeUnitID?[[ATAdManager sharedManager] nativeAdReadyForPlacementID:self.nativeUnitID]:NO;
        
    }else if (type == kADTypeBanner){
        
        return self.bannerUnitID?[[ATAdManager sharedManager] bannerAdReadyForPlacementID:self.bannerUnitID]:NO;
    }else{
        
        return NO;
    }
}

#pragma mark - show ads
#pragma mark -
- (void)showADWithADType:(ADType)type {
    
    if (type == kADTypeNativeBanner) {
        
        [self showNativeBanner];
        
    }else if (type == kADTypeIterstital){
        
        [[ATAdManager sharedManager] showInterstitialWithPlacementID:self.ivUnitID
                                                    inViewController:self.rootVC
                                                            delegate:self];
        
    }else if (type == kADTypeVideo){
        
        [[ATAdManager sharedManager] showRewardedVideoWithPlacementID:self.rvUnitID
                                                     inViewController:self.rootVC
                                                             delegate:self];
        

    }else if (type == kADTypeNativeSplash){
        
        [self showSplash];
        
    }else if(type == kADTypeNative){
        
        [self showNative];
        
    }else if(type == kADTypeBanner){
        
        [self showBanner];
    }
}



#pragma mark - splash
#pragma mark -
- (void)showSplash{
    
    [ATNativeSplashWrapper showNativeSplashAdWithPlacementID:self.splashUnitID extra:nil delegate:self];
}


#pragma mark - native
#pragma mark -
- (void)layoutNativeWithX:(CGFloat)x Y:(CGFloat)y W:(CGFloat)w H:(CGFloat)h{
    
    ATNativeADConfiguration *config = [[ATNativeADConfiguration alloc] init];
    config.delegate = self;
    CGRect configFrame = CGRectZero;
    config.renderingViewClass = [TOOriginNavtiveAdView class];
    configFrame = [TOUtils transformationToOCCoordinates:CGRectMake(x, y, w, h)];
    config.ADFrame = configFrame;
    //防止重复添加AdView
    if (self.nativeView) {
        return;
    }
    self.nativeView = [[ATAdManager sharedManager] retriveAdViewWithPlacementID:self.nativeUnitID configuration:config];
    self.nativeView.mediaView.frame = self.nativeView.bounds;
    self.nativeView.hidden = YES;
    
}

- (void)showNative{
    
    self.nativeView.hidden = NO;
    [self.nativeView bringSubviewToFront:self.nativeView.sponsorIV];
    [self.rootVC.view addSubview:self.nativeView];
}

- (void)removeNative {
    
    if (self.nativeView) {
        self.nativeView.hidden = YES;
        [self.nativeView removeFromSuperview];
        self.nativeView = nil;
    }
}


#pragma mark - banner
#pragma mark -
- (void)showNativeBanner{
    
    if (self.nativeBannerUnitID) {
        
        if (self.nativeBanner.superview && self.nativeBanner.superview.alpha == 0) {
            
            self.nativeBanner.superview.alpha = 1;
            
        }else{
            if ([self isReadyADWithADType:kADTypeNativeBanner]) {
                self.nativeBanner = [ATNativeBannerWrapper retrieveNativeBannerAdViewWithPlacementID:self.nativeBannerUnitID extra:@{kATNativeBannerAdShowingExtraBackgroundColorKey:[UIColor whiteColor],kATNativeBannerAdShowingExtraHideCloseButtonFlagKey:@YES,kATNativeBannerAdShowingExtraAdSizeKey:[NSValue valueWithCGSize:CGSizeMake([self adSize].size.width, [self adSize].size.height)]} delegate:self];
                [self.nativeBanner setFrame:[self adSize]];
                if (self.nativeBanner) {
                    [[AdmobBannerManager sharedInstance]removeAdView:self.nativeBanner];
                    [[AdmobBannerManager sharedInstance]setAdView:self.nativeBanner];
                }else{
                }
                
                [[AdmobBannerManager sharedInstance]showBanner:self.rootVC.view];
            }
        }
    }
    
}

- (void)showBanner{
    
    if (self.bannerUnitID) {
        
        if (self.banner.superview && self.banner.superview.alpha == 0) {
            
            
            self.banner.superview.alpha = 1;
        }else{
            
            ATBannerView *bannerView = [[ATAdManager sharedManager] retrieveBannerViewForPlacementID:self.bannerUnitID];
            bannerView.translatesAutoresizingMaskIntoConstraints = NO;
            self.banner = bannerView;
            [self.banner setFrame:[self adSize]];
            if (self.banner) {
                [[AdmobBannerManager sharedInstance]removeAdView:self.banner];
                [[AdmobBannerManager sharedInstance]setAdView:self.banner];
            }else{
            }
            [[AdmobBannerManager sharedInstance]showBanner:self.rootVC.view];
            
        }
    }
}

- (void)hideBanner {
    
    if (self.nativeBanner) {
        [[AdmobBannerManager sharedInstance]hideBanner];
    }
    
    if (self.banner) {
        [[AdmobBannerManager sharedInstance]hideBanner];
    }
}

- (void)removeBanner {
    
    if (self.nativeBanner) {
        [[AdmobBannerManager sharedInstance]removeAdView:self.nativeBanner];
    }
    
    if (self.banner) {
        [[AdmobBannerManager sharedInstance]removeAdView:self.banner];
    }
}

- (void)setBannerAlign:(NSString *)align offset:(CGPoint)offset {
    
    [[AdmobBannerManager sharedInstance]setLastOffsetX:offset.x];
    [[AdmobBannerManager sharedInstance]setLastOffsetY:offset.y];
    [[AdmobBannerManager sharedInstance]setBannerAlign:[align intValue]];
}

#pragma mark - AT Loading Delegate
#pragma mark -
- (void)didFailToLoadADWithPlacementID:(NSString *)placementID error:(NSError *)error {
    
    if ([self.bannerUnitID isEqualToString:placementID]) {
        
        TopOnAdvertSendANEMessage(BannerLoadFail,kTopOnBannerCode,@"",@"");
        UnitySendMessage("AdObject", "TOBannerAdLoadFail", "");
        
    }else if ([self.ivUnitID isEqualToString:placementID]){
        
        TopOnAdvertSendANEMessage(InterstitialLoadFail,kTopOnIntersCode,@"",@"");
        UnitySendMessage("AdObject", "TOInterstitialAdLoadFail", "");
        
    }else if ([self.rvUnitID isEqualToString:placementID]){
        
        TopOnAdvertSendANEMessage(VideoLoadFail,kTopOnVideoCode,@"",@"");
        UnitySendMessage("AdObject", "TOVideoAdLoadFail", "");

        
    }else if ([self.nativeUnitID isEqualToString:placementID]){
        
        TopOnAdvertSendANEMessage(NativeLoadFail,kTopOnNativeCode,@"",@"");
        UnitySendMessage("AdObject", "TONativeAdLoadFail", "");
    }
}

- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    
    if ([self.bannerUnitID isEqualToString:placementID]) {
        
        TopOnAdvertSendANEMessage(BannerDidLoad,kTopOnBannerCode,@"",@"");
        UnitySendMessage("AdObject", "TOBannerAdLoad", "");

    }else if ([self.ivUnitID isEqualToString:placementID]){
        
        TopOnAdvertSendANEMessage(InterstitialDidLoad,kTopOnIntersCode,@"",@"");
        UnitySendMessage("AdObject", "TOInterstitialAdLoad", "");

    }else if ([self.rvUnitID isEqualToString:placementID]){
        
        TopOnAdvertSendANEMessage(VideoDidLoad,kTopOnVideoCode,@"",@"");
        UnitySendMessage("AdObject", "TOVideoAdLoaded", "");

    }else if ([self.nativeUnitID isEqualToString:placementID]){
        
        UnitySendMessage("AdObject", "TONativeAdLoaded", "");

    }else{
        
    }
}

#pragma mark - rewardVideo delegate
#pragma mark -
- (void)rewardedVideoDidClickForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(VideoCilck,kTopOnVideoCode,@"",@"");
    UnitySendMessage("AdObject", "TOVideoAdPlayClicked", "");

}


- (void)rewardedVideoDidCloseForPlacementID:(NSString *)placementID rewarded:(BOOL)rewarded extra:(NSDictionary *)extra {

    
    UnitySendMessage("AdObject", "TOVideoAdPlayClosed", "");

    if (self.onReward) {
        
        TopOnAdvertSendANEMessage(VideoClose,kTopOnVideoCode,@"reward_status",@"1");

        self.onReward = NO;
        
        
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.onReward) {
                
                TopOnAdvertSendANEMessage(VideoClose,kTopOnVideoCode,@"reward_status",@"1");
               
            }else{
                
                TopOnAdvertSendANEMessage(VideoClose,kTopOnVideoCode,@"reward_status",@"0");
    
            }
            self.onReward = NO;
        });
    }
}

- (void)rewardedVideoDidRewardSuccessForPlacemenID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    self.onReward = YES;
    
    UnitySendMessage("AdObject", "TOVideoAdDidRewardedSuccess", "");

    
}



- (void)rewardedVideoDidEndPlayingForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    UnitySendMessage("AdObject", "TOVideoAdPlayEnd", "");

}


- (void)rewardedVideoDidFailToPlayForPlacementID:(NSString *)placementID error:(NSError *)error extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(VideoShowFail, kTopOnVideoCode,@"",@"");
    UnitySendMessage("AdObject", "TOVideoAdPlayFail", "");

}


- (void)rewardedVideoDidStartPlayingForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(VideoShow,kTopOnVideoCode,@"",@"");
    UnitySendMessage("AdObject", "TOVideoAdPlayStart", "");

}

#pragma mark - interstitial delegate
#pragma mark -
- (void)interstitialDidClickForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(InterstitialClick,kTopOnIntersCode,@"",@"");
    UnitySendMessage("AdObject", "TOInterstitialAdClick", "");

}


- (void)interstitialDidCloseForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(InterstitialClose,kTopOnIntersCode,@"",@"");
    UnitySendMessage("AdObject", "TOInterstitialAdClose", "");

}


- (void)interstitialDidEndPlayingVideoForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    UnitySendMessage("AdObject", "TOInterstitialAdsEndPlaying", "");

}


- (void)interstitialDidFailToPlayVideoForPlacementID:(NSString *)placementID error:(NSError *)error extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(InterstitialShowFail,kTopOnIntersCode,@"",@"");
    UnitySendMessage("AdObject", "TOInterstitialAdFailedToPlay", "");

}


- (void)interstitialDidShowForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(InterstitialShow,kTopOnIntersCode,@"",@"");
    UnitySendMessage("AdObject", "TOInterstitialAdShow", "");

}


- (void)interstitialDidStartPlayingVideoForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    UnitySendMessage("AdObject", "TOInterstitialAdsStartPlayVideo", "");

}


- (void)interstitialFailedToShowForPlacementID:(NSString *)placementID error:(NSError *)error extra:(NSDictionary *)extra {
    
    UnitySendMessage("AdObject", "TOInterstitialAdsShowFail", "");

}


#pragma mark - native banner delegate
#pragma mark -
-(void) didFinishLoadingNativeBannerAdWithPlacementID:(NSString *)placementID{
    
    TopOnAdvertSendANEMessage(NativeBannerDidLoad,kTopOnNativeBannerCode,@"",@"");
    UnitySendMessage("AdObject", "TONativeBannerAdLoad", "");

}

-(void) didFailToLoadNativeBannerAdWithPlacementID:(NSString*)placementID error:(NSError*)error{
    
    TopOnAdvertSendANEMessage(NativeBannerLoadFail,kTopOnNativeBannerCode,@"",@"");
    UnitySendMessage("AdObject", "TONativeBannerAdLoadFail", "");

}


- (void)didAutorefreshNativeBannerAdInView:(ATNativeBannerView *)bannerView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    
}


- (void)didClickCloseButtonInNativeBannerAdView:(ATNativeBannerView *)bannerView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(NativeBannerClose,kTopOnNativeBannerCode,@"",@"");
}


- (void)didClickNativeBannerAdInView:(ATNativeBannerView *)bannerView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(NativeBannerClick,kTopOnNativeBannerCode,@"",@"");
    UnitySendMessage("AdObject", "TONativeBannerAdDidClick", "");

}


- (void)didFailToAutorefreshNativeBannerAdInView:(ATNativeBannerView *)bannerView placementID:(NSString *)placementID extra:(NSDictionary *)extra error:(NSError *)error {
    
}


- (void)didShowNativeBannerAdInView:(ATNativeBannerView *)bannerView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(NativeBannerDidShow,kTopOnNativeBannerCode,@"",@"");
    UnitySendMessage("AdObject", "TONativeBannerAdDidShow", "");

}

#pragma mark - banner delegate
#pragma mark -
-(void) bannerView:(ATBannerView*)bannerView failedToAutoRefreshWithPlacementID:(NSString*)placementID error:(NSError*)error{
    
}
-(void) bannerView:(ATBannerView*)bannerView didShowAdWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra{
    
    TopOnAdvertSendANEMessage(BannerDidShow,kTopOnBannerCode,@"",@"");
    UnitySendMessage("AdObject", "TOBannerAdDidShow", "");

}

-(void) bannerView:(ATBannerView*)bannerView didClickWithPlacementID:(NSString*)placementID extra:(NSDictionary *)extra{
    
    TopOnAdvertSendANEMessage(BannerClick,kTopOnBannerCode,@"",@"");
    UnitySendMessage("AdObject", "TOBannerAdDidClick", "");

}

-(void) bannerView:(ATBannerView*)bannerView didAutoRefreshWithPlacement:(NSString*)placementID extra:(NSDictionary *)extra{
    
}

-(void) bannerView:(ATBannerView*)bannerView didTapCloseButtonWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra{
    
    TopOnAdvertSendANEMessage(BannerClose,kTopOnBannerCode,@"",@"");
    UnitySendMessage("AdObject", "TOBannerAdDidClickCloseButton", "");

}

#pragma mark - native delegate
#pragma mark -
- (void)didClickNativeAdInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(NativeClick, kTopOnNativeCode,@"",@"");
    UnitySendMessage("AdObject", "TONativeAdDidClick", "");

}


- (void)didEndPlayingVideoInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(NativeEndPlay, kTopOnNativeCode,@"",@"");
    
}


- (void)didEnterFullScreenVideoInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
}


- (void)didExitFullScreenVideoInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
}


- (void)didShowNativeAdInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(NativeDidShow, kTopOnNativeCode,@"",@"");
    UnitySendMessage("AdObject", "TONativeAdDidShow", "");

    adView.mainImageView.hidden = [adView isVideoContents];

}


- (void)didStartPlayingVideoInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(NativeStartPlay, kTopOnNativeCode,@"",@"");
}


#pragma mark - nativeSplash
#pragma mark -
-(void) finishLoadingNativeSplashAdForPlacementID:(NSString*)placementID{
    
}

-(void) failedToLoadNativeSplashAdForPlacementID:(NSString*)placementID error:(NSError*)error{
    
    [[TOAdvertManager manager]failToLoadSplash];
    
}

- (void)didClickNaitveSplashAdForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
}

- (void)didCloseNativeSplashAdForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    if ([TOAdvertManager manager].backgroundView) {
        [TOAdvertManager manager].backgroundView.alpha = 0;
        [[TOAdvertManager manager].backgroundView removeFromSuperview];
        [TOAdvertManager manager].backgroundView = nil;
    }
    
    [ATNativeSplashWrapper loadNativeSplashAdWithPlacementID:placementID extra:@{kExtraInfoNativeAdTypeKey:@(ATGDTNativeAdTypeSelfRendering), kExtraInfoNativeAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) -30.0f, 400.0f)], kATExtraNativeImageSizeKey:kATExtraNativeImageSize690_388} customData:nil delegate:[TOAdatper adatper]];
    TopOnAdvertSendANEMessage(XCodeSendSixty, kXcodeSendMessage,@"",@"");
}

- (void)didShowNativeSplashAdForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    
    TopOnAdvertSendANEMessage(SplashDidShow, kTopOnSplashCode,@"",@"");
   
}

#pragma mark - lazying loading
#pragma mark -
- (UIViewController *)rootVC{
    
    if (!_rootVC) {
        _rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return _rootVC;
}

- (CGRect)adSize {
    CGRect gadSize = CGRectMake(0, 0, 320, 50);
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        gadSize = CGRectMake(0, 0, 728, 90);;
    }
    return gadSize;
}



@end
