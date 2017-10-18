//
//  Date.m
//  caldate
//
//  Created by lihang  Xu on 2017/10/10.
//  Copyright © 2017年 lihang  Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDate:NSObject

@property(nonatomic) int yearNow;
@property(nonatomic) int monthNow;

- (const char * )getWeekdayByYearday:(int)Y andMonth:(int)M andDay:(int)D;
- (void)getToday;
+ (BOOL)isLeapYear:(int)year;
+ (int)daysOfUntilLastYear:(int)year;
+ (int)daysOfUntilLastMonth:(int)year andMonth:(int)month;
@end
