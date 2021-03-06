//
//  NSDate+TODate.m
//
//  Created by 洋吴 on 2019/4/2.
//  Copyright © 2019 yodo1. All rights reserved.
//

#import "NSDate+TODate.h"

@implementation NSDate (TODate)

+ (NSInteger )timeIntervalFromLastTime:(NSString *)lastTime ToCurrentTime:(NSString *)currentTime{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSDate *lastDates = [dateFormatter dateFromString:lastTime];
    
    NSDate *currentDates = [dateFormatter dateFromString:currentTime];
    //上次时间
    NSDate *lastDate = [lastDates dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastDates]];
    //当前时间
    NSDate *currentDate = [currentDates dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentDates]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    return intevalTime;
}

+ (NSString *)getCurrentTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
}

+ (long long)getDateTimeTOMilliSeconds{

    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];

    long long totalMilliseconds = interval*1000 ;

    return totalMilliseconds;

}


@end
