//
//  Cal.m
//  project01
//
//  Created by 周新哲 on 2017/10/10.
//  Copyright © 2017年 周新哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cal.h"

@implementation Cal

+ (NSString *)calToday{
    NSDate *date = [NSDate date];
    date = [Cal GMT2Locale:date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth;//获取年月
    NSDateComponents *conponents = [cal components:unitFlags fromDate:date];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的conponents里面；
    NSInteger year = [conponents year];
    NSInteger month = [conponents month];
    return [Cal showCalByMonth:month andYear:year];
}

+ (NSString *)calAYear:(int)year{
    
    return @"";
}

+ (NSString *)calAMonth:(int)month andAYear:(int)year{
    return @"";
}

+ (NSString *)showCalByMonth:(NSInteger)month andYear:(NSInteger)year{
    return @"";
    
}

+ (NSDate *)GMT2Locale:(NSDate *)GMTDate{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:GMTDate];
    return [GMTDate dateByAddingTimeInterval:interval];
}

@end
