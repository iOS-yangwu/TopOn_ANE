//
//  TONetWorkTools.h
//
//  Created by 洋吴 on 2019/3/14.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface TOHTTPSessionManager : NSObject

typedef NS_ENUM(NSInteger, HttpStatusCode) {
    
    /// 200 OK
    TOStatusCode_OK = 200,
    
    /// 204 No Content
    TOStatusCode_NOCONTENT = 204
};


@property (nonatomic,strong)AFHTTPSessionManager * _Nullable manager;

+ (TOHTTPSessionManager *_Nullable)manager;

- (void)POST:(NSString *_Nonnull)url params:(NSDictionary *_Nullable)params timeoutInterval:(NSString *_Nullable)timeoutInterval success:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObj))success failure:(void (^_Nullable)(NSError * _Nullable error))failure;

- (void)GET:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params timeoutInterval:(NSString *_Nullable)timeoutInterval success:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObj))success failure:(void (^_Nullable)(NSError * _Nullable error))failure;

@end

