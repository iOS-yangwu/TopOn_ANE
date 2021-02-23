//
//  GDPR.h
//  Unity-iPhone
//
//  Created by 洋吴 on 2019/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDPR: NSObject

typedef NS_ENUM(NSInteger, DataConsentSet) {
    
    ConsentSetUnknown = 0,
    DataConsentSetPersonalized = 1,
    DataConsentSetNonpersonalized = 2,
};

//+(GDPR*)shareInstance;

//- (void)inProtectedAreas;

//- (void)sendGDPRRequest;

//- (BOOL)presentViewControllerInProtectArea;

@end

NS_ASSUME_NONNULL_END
