//
//  TODataModel.h
//
//  Created by 洋吴 on 2019/4/1.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSettingModel : NSObject

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *appID;

@property(nonatomic,strong)NSString *appKey;

@property(nonatomic,strong)NSString *appSecret;

@property(nonatomic,strong)NSString *cacheTimeS;

@property(nonatomic,strong)NSString *requestTimeoutMs;

@property(nonatomic,strong)NSString *sdkPlatform;

@property(nonatomic,strong)NSString *sid;

@property(nonatomic,strong)NSString *extra;

@property(nonatomic,strong)NSString *timeout_use_cache;

@end

@interface TOUnitModel : NSObject

@property(nonatomic,strong)NSString *adOrder;

@property(nonatomic,strong)NSString *maxTimeInterval;

@property(nonatomic,strong)NSString *minTimeInterval;

@property(nonatomic,strong)NSString *status;

@property(nonatomic,strong)NSString *unitID;

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *sid;

@property(nonatomic,strong)NSString *extra;

//@property(nonatomic,assign)int nowIndex;

@end


NS_ASSUME_NONNULL_END
