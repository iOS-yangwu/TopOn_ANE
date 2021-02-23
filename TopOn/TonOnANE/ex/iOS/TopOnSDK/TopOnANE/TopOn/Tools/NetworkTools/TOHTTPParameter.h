//
//  Utils.h

//
//  Created by 洋吴 on 2019/3/14.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TOHTTPParameter : NSObject

typedef enum {
    kInitSDK,
    kTriggerLoadAd,
    kLoadAdCallBack,
    kTriggerShowAd,
    kShowAdResult,
    kRewardedInfo,
    kDidClickAd,
    kIsReady,
    kSessionStart,
    kSessionEnd
}DataReportType;

+ (TOHTTPParameter *)parameter;

//获取网络请求参数
- (NSDictionary *)getHTTPParameter;

- (NSDictionary *)getDataReportParameterWithType:(DataReportType)type
                                     placementid:(NSString *)placementid
                                           reson:(NSString *)reson
                                          result:(NSString *)result
                                          adType:(NSString *)adType
                                          extra1:(NSString *)extra1
                                          extra2:(NSString *)extra2
                                          extra3:(NSString *)extra3;

- (NSString *)timestamp;

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


@end


