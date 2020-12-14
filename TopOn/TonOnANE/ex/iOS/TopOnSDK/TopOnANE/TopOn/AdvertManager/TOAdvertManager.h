//
//  TOAdvertManager.h
//  //
//  Created by 洋吴 on 2019/3/14.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOProtocal.h"
#import "NSDate+TODate.h"
#import "TOSearchManager.h"

@interface TOAdvertManager : NSObject

@property (nonatomic,weak)id<TOProtocal> delegate;

@property (nonatomic,strong)TOUnitModel *ivUnitModel;
@property (nonatomic,strong)TOUnitModel *rvUnitModel;
@property (nonatomic,strong)TOUnitModel *splashModel;
@property (nonatomic,strong)TOUnitModel *nativeBannerModel;
@property (nonatomic,strong)TOUnitModel *bannerModel;
@property (nonatomic,strong)TOUnitModel *nativeModel;

@property (nonatomic,strong)TOSearchManager *searchManager;

//临时方案
@property (nonatomic,assign)BOOL isReadyInterstital;

+ (TOAdvertManager *)manager;

- (instancetype)initSDK;

- (BOOL) startSDKWithAppId:(NSString *)appId appKey:(NSString *)appKey;
@end


