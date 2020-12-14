//
//  TOConst.h
//
//  Created by 洋吴 on 2019/3/14.
//  Copyright © 2019 yodo1. All rights reserved.
//

//数据库名称
#define kDBName       @"kDB.db"
//存储表名
#define kTableName    @"kTable"

//unit维度存储
#define kUnitConfig           @"kUnitConfig"
#define kIVModel              @"kIVModel"
#define kRVModel              @"kRVModel"
#define kNativeModel          @"kNativeModel"
#define kbannerModel          @"kbannerModel"
#define kNativeBannerModel    @"kNativeBannerModel"
#define kSplashModel          @"kSplashModel"

#define kUserDefault            [NSUserDefaults standardUserDefaults]
#define kWillEnterBackground  @"kWillEnterBackground"


//#define kSettingURL       @"https://server.-.cn/api/v1/batch"
//#define kGDPRURL          @"https://server.-.cn/api/v1/global"
//#define kDataReportURL    @"https://server.-.cn/report"

//广告上次展示时间
#define kBannerLastShowTime @"kBannerLastShowTime"

#define kIVLastShowTime @"kIVLastShowTime"

#define kRVLastShowTime @"kRVLastShowTime"

#define kNativeLastShowTime @"kNativeLastShowTime"

//字符串是否为空
#define kISNullString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kISNullArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0 ||[array isEqual:[NSNull null]])
//字典是否为空
#define kISNullDict(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0 || [dic isEqual:[NSNull null]])
//是否是空对象
#define kISNullObject(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//判断对象是否为空,为空则返回默认值
#define D_StringFix(_value,_default) ([_value isKindOfClass:[NSNull class]] || !_value || _value == nil || [_value isEqualToString:@"(null)"] || [_value isEqualToString:@"<null>"] || [_value isEqualToString:@""] || [_value length] == 0)?_default:_value

#define UI_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define UI_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define UI_IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREENSIZE_IS_35  (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)
#define SCREENSIZE_IS_40  (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define SCREENSIZE_IS_47  (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define SCREENSIZE_IS_55  (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0)
//判断iPHoneXr
#define SCREENSIZE_IS_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)

//判断iPHoneX、iPHoneXs
#define SCREENSIZE_IS_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
#define SCREENSIZE_IS_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)

//判断iPhoneXs Max
#define SCREENSIZE_IS_XS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)

#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)


//判断iphone 7p 8p
#define SCREENSIZE_IS_8P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
//判断iphone 7 8 6sp
#define SCREENSIZE_IS_6SP ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2001), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)

typedef enum {
    BannerAlignLeft               = 1 << 0,
    BannerAlignHorizontalCenter   = 1 << 1,
    BannerAlignRight              = 1 << 2,
    BannerAlignTop                = 1 << 3,
    BannerAlignVerticalCenter     = 1 << 4,
    BannerAlignBottom             = 1 << 5,
}BannerAlign;

typedef enum{
    kADTypeBanner,
    kADTypeNativeBanner,
    kADTypeVideo,
    kADTypeIterstital,
    kADTypeNative,
    kADTypeNativeSplash
} ADType;


