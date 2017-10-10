//
//  Cal.h
//  project01
//
//  Created by 周新哲 on 2017/10/10.
//  Copyright © 2017年 周新哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cal : NSObject

+ (NSString *)showCalByToday;

+ (NSString *)showCalByYear:(int)year;

+ (NSString *)showCalByMonth:(NSInteger)month andYear:(NSInteger)year;

+ (NSString *)buildMonthCal:(NSInteger)month :(NSInteger)year;

+ (NSDate *)GMT2Locale:(NSDate *)GMTDate;

@end
