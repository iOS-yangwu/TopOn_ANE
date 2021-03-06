//
//  NSDate+TODate.h
//  Created by 洋吴 on 2019/4/2.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (TODate)

+ (NSInteger)timeIntervalFromLastTime:(NSString *)lastTime ToCurrentTime:(NSString *)currentTime;

+ (NSString *)getCurrentTime;

+ (long long)getDateTimeTOMilliSeconds;

@end

NS_ASSUME_NONNULL_END
