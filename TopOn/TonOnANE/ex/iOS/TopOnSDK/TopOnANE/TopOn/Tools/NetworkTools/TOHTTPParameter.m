//
//  Utils.m

//
//  Created by 洋吴 on 2019/3/14.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "TOHTTPParameter.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CommonCrypto/CommonDigest.h>
#import "Reachability.h"
#import "TOConst.h"
#import "TOSettingModel.h"
#import "MJExtension.h"
#import "TOSearchManager.h"
#import "TOAdvertManager.h"
#import <WebKit/WebKit.h>


@interface TOHTTPParameter ()

@property(nonatomic,strong)NSString *platform;
@property(nonatomic,strong)NSString *osVersion;
@property(nonatomic,strong)NSString *appVersion;
@property(nonatomic,strong)NSString *appVersionCode;
@property(nonatomic,strong)NSString *brand;
@property(nonatomic,strong)NSString *model;
@property(nonatomic,strong)NSString *packageName;
@property(nonatomic,strong)NSString *language;
@property(nonatomic,strong)NSString *timeZone;
@property(nonatomic,strong)NSString *channel;
@property(nonatomic,strong)NSString *screenSize;
@property(nonatomic,strong)NSString *userType;


@end

@implementation TOHTTPParameter

+ (TOHTTPParameter *)parameter{
    static TOHTTPParameter *m_parameter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_parameter = [[self alloc]init];
    });
    return m_parameter;
}


#pragma mark ================DataReport Parameter================
- (NSDictionary *)getDataReportParameterWithType:(DataReportType)type
                                     placementid:(NSString *)placementid
                                           reson:(NSString *)reson
                                          result:(NSString *)result
                                          adType:(NSString *)adType
                                          extra1:(NSString *)extra1
                                          extra2:(NSString *)extra2
                                          extra3:(NSString *)extra3{
    
    return @{@"nullData":@"nullData"};
}


#pragma mark json字符串转化为字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return @{};
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&err];
    
    if(err){
        
        return @{};
    }

    return dic;
}

- (NSArray *)toArrayWithJsonString:(NSString *)jsonString{
    if (jsonString != nil) {
        NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:&err];
 
        if (err) {
            
            return nil;
        }
        
        if (jsonObject != nil){
            return jsonObject;
        }else{
            // 解析错误
            return nil;
        }
    }
    return nil;
}




- (NSString *)platform{
    if (!_platform) {
        _platform = @"ios";
    }
    return _platform;
}

- (NSString *)osVersion{
    if (!_osVersion) {
        _osVersion = [[UIDevice currentDevice]systemVersion];
    }
    return _osVersion;
}

- (NSString *)appVersion{
    if (!_appVersion) {
        _appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    }
    return _appVersion;
}

-(NSString *)appVersionCode{
    if (!_appVersionCode) {
        _appVersionCode = [[UIDevice currentDevice]systemVersion];
    }
    return _appVersionCode;
}

-(NSString *)brand{
    if (!_brand) {
        _brand = @"apple";
    }
    return _brand;
}

- (NSString *)model{
    if (!_model) {
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *model = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
        if (model) {
            _model = [self currentModel:model];
        }else{
            _model = @"";
        }
    }
    return _model;
}

- (NSString *)packageName{
    if (!_packageName) {
        _packageName = [NSBundle mainBundle].bundleIdentifier;
    }
    return _packageName;
}


- (NSString *)getNetworkType{
    
    NSString *netconnType = @"";
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络
        {
            
            netconnType = @"NotReachable";
        }
            break;
            
        case ReachableViaWiFi:// Wifi
        {
            netconnType = @"Wifi";
        }
            break;
        case ReachableViaWWAN:// 手机自带网络
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            
            NSString *currentStatus = info.currentRadioAccessTechnology;
            
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
                
                netconnType = @"GPRS";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                
                netconnType = @"EDGE";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
                
                netconnType = @"WCDMA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
                
                netconnType = @"HSDPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
                
                netconnType = @"HSUPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                
                netconnType = @"CDMA1x";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                
                netconnType = @"CDMAEVDORev0";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                
                netconnType = @"CDMAEVDORevA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                
                netconnType = @"CDMAEVDORevB";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
                
                netconnType = @"eHRPD";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                
                netconnType = @"LTE";
            }
        }
            break;
            
        default:
            break;
    }
    
    return netconnType;
}

-(NSString *)language{
    if (!_language) {
        _language = [[kUserDefault  objectForKey:@"AppleLanguages"] objectAtIndex:0];
    }
    return _language;
}

- (NSString *)timeZone{
    if (!_timeZone) {
        _timeZone = [NSTimeZone localTimeZone].abbreviation;
    }
    return _timeZone;
}

- (NSString *)screenSize{
    if (!_screenSize) {
        CGRect screenBounds = [[UIScreen mainScreen]bounds];
        CGFloat screenScale = [UIScreen mainScreen].scale;
        CGFloat screenWidth = screenBounds.size.width * screenScale;
        CGFloat screenHeight = screenBounds.size.height * screenScale;
        _screenSize = [NSString stringWithFormat:@"%.f x %.f",screenWidth,screenHeight];
        
    }
    return _screenSize;
    
}


- (NSString *)userType{
    if (!_userType) {
        _userType = @"0";
    }
    return _userType;
}

//创建session
- (NSString *)createSession{
    
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return uuid;
}

#pragma mark some func
- (NSString *)timestamp{
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f", time];
}

- (NSString *)currentModel:(NSString *)phoneModel {
    //iphone
    if ([phoneModel isEqualToString:@"iPhone3,1"] ||
        [phoneModel isEqualToString:@"iPhone3,2"])   return @"iPhone 4";
    if ([phoneModel isEqualToString:@"iPhone4,1"])   return @"iPhone 4S";
    if ([phoneModel isEqualToString:@"iPhone5,1"] ||
        [phoneModel isEqualToString:@"iPhone5,2"])   return @"iPhone 5";
    if ([phoneModel isEqualToString:@"iPhone5,3"] ||
        [phoneModel isEqualToString:@"iPhone5,4"])   return @"iPhone 5C";
    if ([phoneModel isEqualToString:@"iPhone6,1"] ||
        [phoneModel isEqualToString:@"iPhone6,2"])   return @"iPhone 5S";
    if ([phoneModel isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([phoneModel isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([phoneModel isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([phoneModel isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([phoneModel isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([phoneModel isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([phoneModel isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([phoneModel isEqualToString:@"iPhone10,1"] ||
        [phoneModel isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([phoneModel isEqualToString:@"iPhone10,2"] ||
        [phoneModel isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([phoneModel isEqualToString:@"iPhone10,3"] ||
        [phoneModel isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([phoneModel isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([phoneModel isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([phoneModel isEqualToString:@"iPhone11,6"]||
        [phoneModel isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([phoneModel isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([phoneModel isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([phoneModel isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    //ipad
    if ([phoneModel isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([phoneModel isEqualToString:@"iPad2,1"] ||
        [phoneModel isEqualToString:@"iPad2,2"] ||
        [phoneModel isEqualToString:@"iPad2,3"] ||
        [phoneModel isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([phoneModel isEqualToString:@"iPad3,1"] ||
        [phoneModel isEqualToString:@"iPad3,2"] ||
        [phoneModel isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([phoneModel isEqualToString:@"iPad3,4"] ||
        [phoneModel isEqualToString:@"iPad3,5"] ||
        [phoneModel isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([phoneModel isEqualToString:@"iPad4,1"] ||
        [phoneModel isEqualToString:@"iPad4,2"] ||
        [phoneModel isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([phoneModel isEqualToString:@"iPad5,3"] ||
        [phoneModel isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([phoneModel isEqualToString:@"iPad6,3"] ||
        [phoneModel isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7-inch";
    if ([phoneModel isEqualToString:@"iPad6,7"] ||
        [phoneModel isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9-inch";
    if ([phoneModel isEqualToString:@"iPad6,11"] ||
        [phoneModel isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([phoneModel isEqualToString:@"iPad7,1"] ||
        [phoneModel isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2";
    if ([phoneModel isEqualToString:@"iPad7,3"] ||
        [phoneModel isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
    //new
    if ([phoneModel isEqualToString:@"iPad7,5"] ||
        [phoneModel isEqualToString:@"iPad7,6"]) return @"iPad 6th generation";
    
    if ([phoneModel isEqualToString:@"iPad8,1"] ||
        [phoneModel isEqualToString:@"iPad8,2"] || ([phoneModel isEqualToString:@"iPad8,3"])||([phoneModel isEqualToString:@"iPad8,4"])) return @"iPad Pro 11-inch";
    if ([phoneModel isEqualToString:@"iPad8,5"] ||
        [phoneModel isEqualToString:@"iPad8,6"] || ([phoneModel isEqualToString:@"iPad8,7"])||([phoneModel isEqualToString:@"iPad8,8"])) return @"iPad Pro 12.9-inch";
    if ([phoneModel isEqualToString:@"iPad11,3"] ||
        [phoneModel isEqualToString:@"iPad11,4"]) return @"iPad Air 3rd generation";
    
    if ([phoneModel isEqualToString:@"iPad2,5"] ||
        [phoneModel isEqualToString:@"iPad2,6"] ||
        [phoneModel isEqualToString:@"iPad2,7"]) return @"iPad mini";
    if ([phoneModel isEqualToString:@"iPad4,4"] ||
        [phoneModel isEqualToString:@"iPad4,5"] ||
        [phoneModel isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if ([phoneModel isEqualToString:@"iPad4,7"] ||
        [phoneModel isEqualToString:@"iPad4,8"] ||
        [phoneModel isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if ([phoneModel isEqualToString:@"iPad5,1"] ||
        [phoneModel isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
    //ipod
    if ([phoneModel isEqualToString:@"iPod1,1"]) return @"iTouch";
    if ([phoneModel isEqualToString:@"iPod2,1"]) return @"iTouch2";
    if ([phoneModel isEqualToString:@"iPod3,1"]) return @"iTouch3";
    if ([phoneModel isEqualToString:@"iPod4,1"]) return @"iTouch4";
    if ([phoneModel isEqualToString:@"iPod5,1"]) return @"iTouch5";
    if ([phoneModel isEqualToString:@"iPod7,1"]) return @"iTouch6";
    //Simulator
    if ([phoneModel isEqualToString:@"i386"] || [phoneModel isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return phoneModel;
    
}


- (NSString *)getIDFA{
    
    return [ASIdentifierManager sharedManager].isAdvertisingTrackingEnabled ? [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString] : @"";
    
}

- (NSString *)getIDFV{
    
    return [UIDevice currentDevice].identifierForVendor.UUIDString ? [UIDevice currentDevice].identifierForVendor.UUIDString : @"";
    
}


- (NSString *)getUserAgent{
    
    NSUserDefaults *uDefault = kUserDefault ;
    NSString *defaultUserAgent = [uDefault objectForKey:@"UserAgent"];
    if (kISNullString(defaultUserAgent)) {
        WKWebViewConfiguration* webViewConfig = WKWebViewConfiguration.new;
        webViewConfig.allowsInlineMediaPlayback = YES;
        
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0,0,1,1) configuration:webViewConfig];
        wkWebView.backgroundColor = [UIColor clearColor];
        wkWebView.hidden = YES;
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:wkWebView];
        [wkWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
            if (result != nil) {
                [kUserDefault setValue:result forKey:@"UserAgent"];
            }
        }];
        return [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
    }else{
        return defaultUserAgent;
    }
    
}


//MD5
- (NSString *) md5:(NSString *) str{
    
    if (!str) return nil;
    const char *cStr = str.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
}


-(NSString *)convertToJsonData:(NSDictionary *)dict

{

    NSError *error;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString;

    if (!jsonData) {

        jsonString = @"";

    }else{

        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;

}

@end

