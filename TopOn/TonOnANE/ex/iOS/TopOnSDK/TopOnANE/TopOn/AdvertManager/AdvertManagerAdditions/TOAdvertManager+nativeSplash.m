//
//  TOAdvertManager+nativeSplash.m
//  TopOnSDK
//
//  Created by 洋吴 on 2019/6/20.
//  Copyright © 2019 洋吴. All rights reserved.
//

#import "TOAdvertManager+nativeSplash.h"
#import "NSDate+TODate.h"
#import <objc/runtime.h>
#import "TOAdvertANEUtils.h"
#import "TOHTTPParameter.h"

static NSString *backgroundTimeKey = @"backgroundTimeKey";
static void *backgroundViewKey = &backgroundViewKey;
static void *disLinkKey = &disLinkKey;


@implementation TOAdvertManager (nativeSplash)

#pragma mark 属性添加
- (void)setDisLink:(CADisplayLink *)disLink{
    
    objc_setAssociatedObject(self, &disLinkKey, disLink, OBJC_ASSOCIATION_RETAIN);
    
}

- (CADisplayLink *)disLink{
    
    return objc_getAssociatedObject(self, &disLinkKey);
}

- (void)setBackgroundView:(UIView *)backgroundView{
    
    objc_setAssociatedObject(self, &backgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN);
    
}
- (UIView *)backgroundView{
    
    return objc_getAssociatedObject(self, &backgroundViewKey);
}

- (void)setBackgroundTime:(NSString *)backgroundTime{
    
    objc_setAssociatedObject(self, &backgroundTimeKey,backgroundTime, OBJC_ASSOCIATION_COPY);
    
}


- (NSString *)backgroundTime{
    
    return objc_getAssociatedObject(self, &backgroundTimeKey);
}

#pragma mark 请求广告方法
- (void)loadNativeSplashWithPlacementId:(NSString*)placementId{
    
    TOUnitModel *sModel = [self splashModelByPlacementID:placementId];
    
    if(sModel.unitID != nil && [sModel.status isEqualToString:@"1"]){
        [self.delegate loadADWithPlacementId:sModel.unitID adType:kADTypeNativeSplash nativeFrame:CGRectZero];
    }
}

- (BOOL)isReadyNativeSplashWithPlacementId:(NSString *)placementId{
    
    TOUnitModel *sModel = [self splashModelByPlacementID:placementId];
    NSInteger minTimeInterval = [sModel.minTimeInterval integerValue];
    NSInteger maxTimeInterval = [sModel.maxTimeInterval integerValue];
    
    NSInteger idx = [[NSUserDefaults standardUserDefaults]integerForKey:@"splashIndex"]?[[NSUserDefaults standardUserDefaults]integerForKey:@"splashIndex"]:0;
    NSString *lastShowTime = [[NSUserDefaults standardUserDefaults]stringForKey:@"splashLastShowTime"]?[[NSUserDefaults standardUserDefaults]stringForKey:@"splashLastShowTime"]:@"0";
    
    
    //获取当前时间
    NSString *nowShowTime = [NSDate getCurrentTime];
    //这次展示距离上次展示时间
    NSInteger timeInterval = [NSDate timeIntervalFromLastTime:lastShowTime ToCurrentTime:nowShowTime];
    
    
    if ([sModel.status isEqualToString:@"1"]) {
        
        if (timeInterval >= minTimeInterval) {
            
            if (timeInterval >= maxTimeInterval && maxTimeInterval != 0) {
                
                return [self.delegate isReadyADWithADType:kADTypeNativeSplash];
                
            }else{
                
                if ([[self getAdsOrderWithIndex:idx adOrder:sModel.adOrder] isEqualToString:@"1"]) {
                    
                    return [self.delegate isReadyADWithADType:kADTypeNativeSplash];
                    
                }else{
                    
                    [self loadNativeSplashWithPlacementId:placementId];
                    idx = idx < sModel.adOrder.length - 1 ? idx+1 : 0;
                    [[NSUserDefaults standardUserDefaults] setInteger:idx forKey:@"splashIndex"];
                    return NO;
                }
            }
        }else{
            [self loadNativeSplashWithPlacementId:placementId];
            return NO;
        }
    }else{
        
        return NO;
    }
}


- (void)showNativeSplashWithPlacementId:(NSString *)placementId{
    
    
    [self.delegate showADWithADType:kADTypeNativeSplash];
    TOUnitModel *sModel = [self splashModelByPlacementID:placementId];
    [self saveNativeSplashWithUnitId:sModel.unitID adOrder:sModel.adOrder];
    
    
}

- (void)saveNativeSplashWithUnitId:(NSString *)unitId adOrder:(NSString *)adOrder{
    
    //数据上报
    if (!kISNullString(unitId)&& !kISNullString(adOrder)) {
        
        NSInteger interIndex = [[NSUserDefaults standardUserDefaults]integerForKey:@"splashIndex"] ? [[NSUserDefaults standardUserDefaults]integerForKey:@"splashIndex"] : 0;
        
        
        interIndex = interIndex < adOrder.length - 1 ? interIndex+1 : 0;
        
        [[NSUserDefaults standardUserDefaults]setInteger:interIndex forKey:@"splashIndex"];
        [[NSUserDefaults standardUserDefaults]setObject:[NSDate getCurrentTime] forKey:@"splashLastShowTime"];
    }
}

- (NSString *)getAdsOrderWithIndex:(NSInteger)index adOrder:(NSString *)adOrder{
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i=0; i<adOrder.length; i++) {
        [arrM addObject:[adOrder substringWithRange:NSMakeRange(i, 1)]];
    }
    if (index > adOrder.length - 1) {
        return arrM[0];
    }else{
        return arrM[index];
    }
    
}

- (TOUnitModel *)splashModelByPlacementID:(NSString *)placementID{
    
    if (![TOAdvertManager manager].splashModel) {
        
        TOSearchManager *searchManager = [TOSearchManager shareManager];
        TOUnitModel *splashModel = [searchManager getUnitConfigWithPlacementID:placementID];
        if (!splashModel) {
            splashModel = [searchManager getDefaultUnitConfigWithKey:kSplashModel unitId:nil];
        }
        [TOAdvertManager manager].splashModel = splashModel;
        return [TOAdvertManager manager].splashModel;
        
    }else{
        return [TOAdvertManager manager].splashModel;
    }
}

#pragma mark 方法交换
 void ANEDelegateMapping(SEL oldSEL,SEL defaultSEL, SEL newSEL)
{
    Class aClass = objc_getClass("CTAppController");
    if ( aClass == 0 )
    {
        
        return;
    }
    Class bClass = [TOAdvertManager class];
    class_addMethod(aClass, newSEL, class_getMethodImplementation(bClass, newSEL),nil);
    class_addMethod(aClass, oldSEL, class_getMethodImplementation(bClass, defaultSEL),nil);
    
    Method oldMethod = class_getInstanceMethod(aClass, oldSEL);
    Method newMethod = class_getInstanceMethod(aClass, newSEL);
    method_exchangeImplementations(oldMethod, newMethod);
    
}


- (BOOL)TopOnDefaultApplication:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)dic{
    return YES;
}

-(BOOL)TopOnMapApplication:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions{
    
    [self TopOnMapApplication:application didFinishLaunchingWithOptions:launchOptions];

    NSString *placementId =[NSBundle mainBundle].infoDictionary[@"splashPlacement"];
    
    TOAdvertManager *manager = [TOAdvertManager manager];
    
    
    //IAP
    NSString *IAP = [[NSUserDefaults standardUserDefaults]objectForKey:@"TOIAP"];
    IAP = IAP ? IAP : @"NO";
    NSString *firstLaunch = [[NSUserDefaults standardUserDefaults]objectForKey:@"FirstLaunch"];
    
    
    if ([IAP isEqualToString:@"YES"] || !firstLaunch) {
        
    }else{
        
        TOUnitModel *splashModel = [[TOSearchManager shareManager] getUnitConfigWithPlacementID:placementId];
        if (!splashModel) {
            splashModel = [[TOSearchManager shareManager] getDefaultUnitConfigWithKey:kSplashModel unitId:nil];
        }
        
        if (placementId&&[splashModel.status isEqualToString:@"1"]) {
            
            [manager startSDKWithAppId:[NSBundle mainBundle].infoDictionary[@"AppId"] appKey:[NSBundle mainBundle].infoDictionary[@"AppKey"]];
            
            [TOAdvertManager manager].disLink = [CADisplayLink displayLinkWithTarget:[TOAdvertManager manager] selector:@selector(linkMethod)];
            [[TOAdvertManager manager].disLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            [manager loadNativeSplashWithPlacementId:placementId];
            
           

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([manager isReadyNativeSplashWithPlacementId:placementId]){
                    
                    [manager showNativeSplashWithPlacementId:placementId];
                }else{
                    
                    [[TOAdvertManager manager] failToLoadSplash];
                    [manager loadNativeSplashWithPlacementId:placementId];
                }
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[TOAdvertManager manager] removeBackgroundView];
            });
        }else{
            
            
            
        }
    }
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"launched" forKey:@"FirstLaunch"];
    [kUserDefault removeObjectForKey:kWillEnterBackground];
    return YES;
}

- (void)removeBackgroundView{
    
    if (self.backgroundView) {
        self.backgroundView.alpha = 0;
        [self.backgroundView removeFromSuperview];
        self.backgroundView = nil;
        TopOnAdvertSendANEMessage(XCodeSendSixty, kTopOnSplashCode,@"",@"");
    }
}

- (void)TopOnDefaultApplicationWillEnterForground:(UIApplication*)application{
    
}
- (void)TopOnMapApplicationWillEnterForground:(UIApplication*)application{
    
    //热启动开关
    [self TopOnMapApplicationWillEnterForground:application];
    TOAdvertManager *manager = [TOAdvertManager manager];
    //热启动
    NSString *IAP = [[NSUserDefaults standardUserDefaults]objectForKey:@"TOIAP"];
    IAP = IAP ? IAP : @"NO";
    
    NSString *placementId = [NSBundle mainBundle].infoDictionary[@"splashPlacement"];
    
    TOUnitModel *splashModel = [[TOSearchManager shareManager] getUnitConfigWithPlacementID:placementId];
    
    if (!splashModel) {
        splashModel = [[TOSearchManager shareManager] getDefaultUnitConfigWithKey:kSplashModel unitId:nil];
    }
    
    if ([IAP isEqualToString:@"YES"]) {
        
    }else{
        
        if (placementId&&[splashModel.status isEqualToString:@"1"]) {
            
            NSString *leaveTime = [kUserDefault objectForKey:kWillEnterBackground];
            NSString *activeTime = [[TOHTTPParameter parameter]timestamp];
            NSString *timeD = @"5";
                       
           
           int t = ([activeTime intValue]-[leaveTime intValue]);
            
            if (t >[timeD intValue]&&leaveTime) {
                
                if ([manager isReadyNativeSplashWithPlacementId:placementId]) {
                    //暂停游戏
                    TopOnAdvertSendANEMessage(XCodeSendZERO, kXcodeSendMessage,@"",@"");
                    [manager showNativeSplashWithPlacementId:placementId];
                    
                }else{
                    
                    [manager loadNativeSplashWithPlacementId:placementId];
                }
            }
        }
    }
    [kUserDefault removeObjectForKey:kWillEnterBackground];
}

- (void)failToLoadSplash{
    
    
    if (self.backgroundView) {
        self.backgroundView.alpha = 0;
        [self.backgroundView removeFromSuperview];
        self.backgroundView = nil;
        TopOnAdvertSendANEMessage(XCodeSendSixty, kTopOnSplashCode,@"",@"");
    }
    
}

- (void)linkMethod{
    
    
    TopOnAdvertSendANEMessage(XCodeSendZERO, kXcodeSendMessage,@"",@"");
}

- (void)stopDisplayLink {

    
    if (self.disLink) {
        
        self.backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.backgroundView.frame];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.image = [self getTheLaunchImage];
        [self.backgroundView addSubview:imageView];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.backgroundView];
        
        [self.disLink invalidate];
        self.disLink = nil;
        
    }
}

#pragma mark 获取启动图片
- (UIImage *)getTheLaunchImage {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ANE" ofType :@"bundle"];
    
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *img_path = [bundle pathForResource:@"Default" ofType:@"png"];
    
    return [UIImage imageWithContentsOfFile:img_path];
}
#pragma mark Splash
- (void)showSplashWithIAP:(NSString *)IAP{
    
    [[NSUserDefaults standardUserDefaults]setValue:IAP forKey:@"TOIAP"];
    
}


+ (void)load {

    ANEDelegateMapping(@selector(application:didFinishLaunchingWithOptions:),
                @selector(TopOnDefaultApplication:didFinishLaunchingWithOptions:),
                @selector(TopOnMapApplication:didFinishLaunchingWithOptions:));

    ANEDelegateMapping(@selector(applicationWillEnterForeground:),
                          @selector(TopOnDefaultApplicationWillEnterForground:),
                          @selector(TopOnMapApplicationWillEnterForground:));

}

@end
