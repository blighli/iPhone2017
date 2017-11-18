//
//  GetDate.m
//  caldate
//
//  Created by lihang  Xu on 2017/10/10.
//  Copyright © 2017年 lihang  Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetDate.h"

@implementation GetDate

- (void) getToday{
    
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:date];
    
    _yearNow = (int)[d year];
    _monthNow = (int)[d month];
    
   
}

 //判断得到的日期是否为闰年
+ (BOOL)isLeapYear:(int)year{
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        return true;
    }
    else{
        return false;
    }
}
//计算从公元0年到你输入的上一年总共有多少天；
+ (int)daysOfUntilLastYear:(int)year{
    
    int day = 0;
    BOOL isLeap;
    for(int i = 1 ; i < year ; i++){
        
        isLeap = [GetDate isLeapYear:year];
        if(isLeap){
            day += 366;
        }
        else{
            day += 365;
        }
    }
    return day;
}

//计算公元0年到你输入上个月共有多少天；
+ (int)daysOfUntilLastMonth:(int)year andMonth:(int)month{
    
    NSNumber *none = [[NSNumber alloc] initWithInt:0];
    NSNumber *oddMonth = [[NSNumber alloc] initWithInt:31];
    NSNumber *evenMonth = [[NSNumber alloc] initWithInt:30];
    
    NSNumber *febLeap = [[NSNumber alloc] initWithInt:29];
    NSNumber *febNotLeap = [[NSNumber alloc] initWithInt:28];
    
    int day = [GetDate daysOfUntilLastYear:year];
    //首先计算0年到上一年有多少天；
    NSMutableArray *monthArray = [[NSMutableArray alloc] init];
   
    NSArray *arr = [[NSArray alloc] initWithObjects:none,oddMonth,[GetDate isLeapYear:year]?febLeap:febNotLeap,oddMonth,evenMonth,oddMonth,evenMonth,oddMonth,oddMonth,evenMonth,oddMonth,evenMonth,oddMonth, nil];
    [monthArray addObjectsFromArray:arr];
    
    
    for(int i = 1 ; i < month ; i++){
        day += [[monthArray objectAtIndex:i] intValue];
    }
    day += 1;
    return day;
}

@end
