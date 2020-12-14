//
//  TOAdvertManager.m
//
//  Created by 洋吴 on 2019/3/14.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "TOAdvertManager.h"
#import "TODataBaseTools.h"
#import "TOAdatper.h"
#import "MJExtension.h"
#import "TOHTTPParameter.h"

@interface TOAdvertManager ()

@property (nonatomic, strong)TODataBaseTools *dbTools;

@property (nonatomic, strong)TOAdatper *adapter;

@end

@implementation TOAdvertManager


+ (TOAdvertManager *)manager{
    static TOAdvertManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TOAdvertManager alloc]initSDK];
    });
    return manager;
}

- (instancetype)initSDK{
    if (self = [super init]) {
        _dbTools = [TODataBaseTools dbTools];
        _searchManager = [TOSearchManager shareManager];
        self.adapter = [TOAdatper adatper];
        self.delegate = self.adapter;
    }
    return self;
}


#pragma mark 初始化聚合SDK
- (BOOL)startSDKWithAppId:(NSString *)appId appKey:(NSString *)appKey{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];

    [self setupDefaultSetting];
    self.adapter = [TOAdatper adatper];
    self.delegate = self.adapter;
    [self clearADShowTime];
    
    return [self.delegate initSDKWithAppId:appId appKey:appKey];;
}

- (void)clearADShowTime{
    
    NSString *bannerUnitId = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"bannerPlacement"];
    if (bannerUnitId) {
        
        [self.searchManager putLastShowTime:[NSDate getCurrentTime] index:@"0" placementID:bannerUnitId];
    }
    
    NSString *rvUnitId = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"rewardVideoPlacement"];
    if (rvUnitId) {
        
        [self.searchManager putLastShowTime:[NSDate getCurrentTime] index:@"0" placementID:rvUnitId];
    }
    
    NSString *nativeUnitId = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"nativePlacement"];
    if (nativeUnitId) {
        [self.searchManager putLastShowTime:[NSDate getCurrentTime] index:@"0" placementID:nativeUnitId];
    }
    
    NSString *nativeBannerUnitId = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"nativeBannerPlacement"];
    if (nativeBannerUnitId) {
        
        [self.searchManager putLastShowTime:[NSDate getCurrentTime] index:@"0" placementID:nativeBannerUnitId];
    }
    
}

- (void)setupDefaultSetting{
    
    if (!kISNullString([[[NSBundle mainBundle]infoDictionary]objectForKey:@"nativeBannerPlacement"])) {
        //设置unit模型
        NSString *bannerStatus = kISNullString([[[NSBundle mainBundle]infoDictionary]objectForKey:@"nativeBannerStatus"]) ? @"1" : [[[NSBundle mainBundle]infoDictionary]objectForKey:@"nativeBannerStatus"];
        
        NSDictionary *bannerDict = @{@"adOrder":@"1",
                                     @"maxTimeInterval":@"0",
                                     @"sid":@"",
                                     @"minTimeInterval":@"0",
                                     @"status":bannerStatus,
                                     @"unitID":[[[NSBundle mainBundle]infoDictionary]objectForKey:@"nativeBannerPlacement"],
                                     @"name":@""};
        [self.dbTools putObject:bannerDict withId:kNativeBannerModel];
    }
    
    if (!kISNullString([[[NSBundle mainBundle]infoDictionary]objectForKey:@"bannerPlacement"])) {
        //设置unit模型
        NSString *bannerStatus = kISNullString([[[NSBundle mainBundle]infoDictionary]objectForKey:@"bannerStatus"]) ? @"1" : [[[NSBundle mainBundle]infoDictionary]objectForKey:@"bannerStatus"];
        
        NSDictionary *bannerDict = @{@"adOrder":@"1",
                                     @"maxTimeInterval":@"0",
                                     @"sid":@"",
                                     @"minTimeInterval":@"0",
                                     @"status":bannerStatus,
                                     @"unitID":[[[NSBundle mainBundle]infoDictionary]objectForKey:@"bannerPlacement"],
                                     @"name":@""};
        [self.dbTools putObject:bannerDict withId:kbannerModel];
    }
    
    if (!kISNullString([[[NSBundle mainBundle]infoDictionary]objectForKey:@"interstitialConfig"])) {
        NSString *jsonString = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"interstitialConfig"];
        NSError *error = nil;
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments
                                                          error:nil];
        if(jsonObject != nil && error == nil){
            
            [self.dbTools putObject:jsonObject withId:kIVModel];
        }
    }
    
    if (!kISNullString([[[NSBundle mainBundle]infoDictionary]objectForKey:@"rewardVideoPlacement"])) {
        
        NSString *rvStatus = kISNullString([[[NSBundle mainBundle]infoDictionary]objectForKey:@"rewardVideoStatus"]) ? @"1":[[[NSBundle mainBundle]infoDictionary]objectForKey:@"rewardVideoStatus"];
        
        NSDictionary *RVDict = @{@"adOrder":@"1",
                                 @"maxTimeInterval":@"0",
                                 @"sid":@"",
                                 @"minTimeInterval":@"0",
                                 @"status":rvStatus,
                                 @"unitID":[[[NSBundle mainBundle]infoDictionary]objectForKey:@"rewardVideoPlacement"],
                                 @"name":@""};
        [self.dbTools putObject:RVDict withId:kRVModel];
    }
    
    if (!kISNullString([[[NSBundle mainBundle]infoDictionary]objectForKey:@"nativePlacement"])) {
        NSString *nativeStatus = kISNullString([[[NSBundle mainBundle]infoDictionary]objectForKey:@"nativeStatus"])?@"1":[[[NSBundle mainBundle]infoDictionary]objectForKey:@"nativeStatus"];
        NSDictionary *nativeDict = @{@"adOrder":@"1",
                                     @"sid":@"",
                                     @"maxTimeInterval":@"0",
                                     @"minTimeInterval":@"0",
                                     @"status":nativeStatus,
                                     @"unitID":[[[NSBundle mainBundle]infoDictionary]objectForKey:@"nativePlacement"],
                                     @"name":@""};
        [self.dbTools putObject:nativeDict withId:kNativeModel];
    }
    
    if (!kISNullString([[[NSBundle mainBundle]infoDictionary]objectForKey:@"splashPlacement"])) {
        NSString *splashStatus = kISNullString([[[NSBundle mainBundle]infoDictionary]objectForKey:@"splashStatus"]) ? @"1" : [[[NSBundle mainBundle]infoDictionary]objectForKey:@"splashStatus"];
        NSDictionary *splashDict = @{@"adOrder":@"1",
                                     @"sid":@"",
                                     @"maxTimeInterval":@"0",
                                     @"minTimeInterval":@"0",
                                     @"status":splashStatus,
                                     @"unitID":[[[NSBundle mainBundle]infoDictionary]objectForKey:@"splashPlacement"],
                                     @"name":@""};
        [self.dbTools putObject:splashDict withId:kSplashModel];
    }
    
}

#pragma mark switchMethod
void TODelegateMapping(SEL oldSEL,SEL defaultSEL, SEL newSEL)
{
    Class aClass = objc_getClass("UIViewController");
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

 void DelegateMapping(SEL oldSEL,SEL defaultSEL, SEL newSEL)
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


+ (void)load {
    
    TODelegateMapping(@selector(presentViewController:animated:completion:),
                       @selector(TopOnDefaultPresentViewcontroller:animated:completion:),
                       @selector(TopOnMapPresentViewcontroller:animated:completion:));
        
}

#pragma mark 弹出控制器
- (void)TopOnDefaultPresentViewcontroller:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    
    
}

- (void)TopOnMapPresentViewcontroller:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    [self TopOnMapPresentViewcontroller:viewControllerToPresent animated:flag completion:completion];
        
    for (id object in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([object isKindOfClass:[UIImageView class]]) {
            [object removeFromSuperview];
        }
    }
}

- (void)applicationEnterBackground{
    
    [kUserDefault setValue:[[TOHTTPParameter parameter]timestamp] forKey:kWillEnterBackground];
}

@end
