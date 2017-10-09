//
//  Cal.h
//  project01
//
//  Created by 周新哲 on 2017/10/10.
//  Copyright © 2017年 周新哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cal : NSObject

+ (NSString *)calToday;

+ (NSString *)calAYear:(int)year;

+ (NSString *)calAMonth:(int)month andAYear:(int)year;

+ (NSString *)showCalByMonth:(NSInteger)month andYear:(NSInteger)year;

+ (NSDate *)GMT2Locale:(NSDate *)GMTDate;

@end
