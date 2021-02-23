//
//  GDPR.m
//  Unity-iPhone
//
//  Created by 洋吴 on 2019/9/4.
//

#import "GDPR.h"
#import "TOConst.h"
#import "TOHTTPSessionManager.h"
#import "PrivacyViewController.h"
#import "TOHTTPParameter.h"
#import "NSDate+TODate.h"


@implementation GDPR



//+(GDPR *)shareInstance{
//    
//    static GDPR *m_instance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        m_instance = [[GDPR alloc]init];
//    });
//    return m_instance;
//}
//
//- (void)inProtectedAreas{
//    
//    [self doDispatchAfterFunction];
//    
//}
//
//- (void)doDispatchAfterFunction{
//    
//    NSUserDefaults *userDefault = kUserDefault ;
//    NSString *isEurope = [userDefault valueForKey:kEurope];
//    NSString *presented = [userDefault valueForKey:@"hasPresentVC"];
//    //    [self presentDataConsentDialog];
//    
//    if ([isEurope isEqualToString:@"Europe"] && !presented) {
//        //欧洲国家弹框
//        [self presentDataConsentDialog];
//        
//    }else{
//        
//    }
//}
//
//
//- (void)sendGDPRRequest{
//    
//    NSUserDefaults *userDefault = kUserDefault ;
//    NSInteger contentStatus = [userDefault integerForKey:kGDPRStatus];
//    
//    //已设置同意
//    if (contentStatus == DataConsentSetPersonalized) {
//        [[TOHTTPSessionManager manager]GET:kGDPRURL params:[[TOHTTPParameter parameter] getEuropeHTTPParameter] timeoutInterval:@"60" success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
//            if (responseObj != nil) {
//                if (responseObj[@"detail"] != nil &&responseObj[@"detail"][@"isEU"] != nil) {
//                    if ([responseObj[@"detail"][@"isEU"] isKindOfClass:[NSNumber class]]) {
//                        NSString *isEU = [NSString stringWithFormat:@"%@",responseObj[@"detail"][@"isEU"]];
//                        if ([isEU isEqualToString:@"0"]) {
//                            //非欧洲
//                            [userDefault setValue:@"NonEurope" forKey:kEurope];
//                        }else{
//                            [userDefault setValue:@"Europe" forKey:kEurope];
//                        }
//                    }else{
//                        [userDefault setValue:@"NonEurope" forKey:kEurope];
//                    }
//                }else{
//                    [userDefault setValue:@"NonEurope" forKey:kEurope];
//                }
//            }else{
//                [userDefault setValue:@"NonEurope" forKey:kEurope];
//            }
//        } failure:^(NSError * _Nullable error) {
//            [userDefault setValue:@"NonEurope" forKey:kEurope];
//        }];
//        
//    }else if (contentStatus == DataConsentSetNonpersonalized){
//        
//        //用户不同意 请求server
//        [[TOHTTPSessionManager manager]GET:kGDPRURL params:[[TOHTTPParameter parameter] getEuropeHTTPParameter] timeoutInterval:@"60" success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
//            if (responseObj != nil) {
//                if (responseObj[@"detail"] != nil &&responseObj[@"detail"][@"isEU"] != nil) {
//                    if ([responseObj[@"detail"][@"isEU"] isKindOfClass:[NSNumber class]]) {
//                        NSString *isEU = [NSString stringWithFormat:@"%@",responseObj[@"detail"][@"isEU"]];
//                        if ([isEU isEqualToString:@"0"]) {
//                            //非欧洲
//                            [userDefault setValue:@"NonEurope" forKey:kEurope];
//                            [userDefault setInteger:DataConsentSetPersonalized forKey:kGDPRStatus];
//                        }else{
//                            [userDefault setValue:@"Europe" forKey:kEurope];
//                        }
//                    }else{
//                        [userDefault setValue:@"NonEurope" forKey:kEurope];
//                    }
//                }else{
//                    [userDefault setValue:@"NonEurope" forKey:kEurope];
//                }
//            }else{
//                [userDefault setValue:@"NonEurope" forKey:kEurope];
//            }
//        } failure:^(NSError * _Nullable error) {
//            [userDefault setValue:@"NonEurope" forKey:kEurope];
//        }];
//        
//    }else{
//        //未设置
//        NSString *countryCode = [userDefault objectForKey:kEurope];
//        if (countryCode != nil && [countryCode isEqualToString:@"NonEurope"]) {
//            //有国家信息_非欧盟地区
//            [userDefault setInteger:DataConsentSetPersonalized forKey:kGDPRStatus];
//            
//        }else if(countryCode != nil &&[countryCode isEqualToString:@"Europe"]){
//            //有国家信息_欧盟地区
//            
//        }else{
//            //无信息
//            //请求
//            [[TOHTTPSessionManager manager]GET:kGDPRURL params:[[TOHTTPParameter parameter] getEuropeHTTPParameter] timeoutInterval:@"60" success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
//                if (responseObj != nil) {
//                    if (responseObj[@"detail"] != nil &&responseObj[@"detail"][@"isEU"] != nil) {
//                        if ([responseObj[@"detail"][@"isEU"] isKindOfClass:[NSNumber class]]) {
//                            NSString *isEU = [NSString stringWithFormat:@"%@",responseObj[@"detail"][@"isEU"]];
//                            
//                            if ([isEU isEqualToString:@"1"]) {
//                                //欧洲
//                                //存储国家信息
//                                [userDefault setValue:@"Europe" forKey:kEurope];
//                                
//                            }else{
//                                //非欧洲
//                                [userDefault setValue:@"NonEurope" forKey:kEurope];
//                                [userDefault setInteger:DataConsentSetPersonalized forKey:kGDPRStatus];
//                            }
//                        }else{
//                            //未知
//                            [userDefault setInteger:DataConsentSetPersonalized forKey:kGDPRStatus];
//                        }
//                    }else{
//                        //非欧洲
//                        [userDefault setInteger:DataConsentSetPersonalized forKey:kGDPRStatus];
//                    }
//                }else{
//                    //未知
//                    [userDefault setInteger:DataConsentSetPersonalized forKey:kGDPRStatus];
//                }
//            } failure:nil];
//            
//        }
//    }
//}
//
//
////弹出控制器
//- (void)presentDataConsentDialog{
//    
//    PrivacyViewController *pvc = [PrivacyViewController new];
//    UIViewController *rootvc = [UIApplication sharedApplication].keyWindow.rootViewController;
//    pvc.responeCallback = ^{
//        
//        [rootvc dismissViewControllerAnimated:YES completion:nil];
//    };
//    
//    [rootvc presentViewController:pvc animated:YES completion:nil];
//    [kUserDefault setValue:@"yes" forKey:@"hasPresentVC"];
//    
//}
//
//- (BOOL)presentViewControllerInProtectArea{
//    
//    NSString *countryCode = [kUserDefault objectForKey:kEurope];
//    if (![countryCode isEqualToString:@"Europe"]) {
//        return false;
//    }else{
//        PrivacyViewController *pvc = [PrivacyViewController new];
//        UIViewController *rootvc = [UIApplication sharedApplication].keyWindow.rootViewController;
//        pvc.responeCallback = ^{
//            
//            [rootvc dismissViewControllerAnimated:YES completion:nil];
//        };
//        
//        [rootvc presentViewController:pvc animated:YES completion:nil];
//        
//    }
//    return true;
//    
//    
//}

@end
