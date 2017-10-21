//
//  myCal.m
//  Project01
//
//  Created by 王奇 on 2017/10/10.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "myCal.h"

static int DAYSOFMONTH[12] = {
    31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
};

static char* WEEKDAY[] = {
    "日", "一", "二", "三", "四", "五", "六"
};

static char* MONTH[] = {
    "一月", "二月", "三月", "四月", "五月", "六月",
    "七月", "八月", "九月", "十月", "十一月", "十二月"
};

@implementation myCal

@synthesize year;

// 判断是否为闰年
- (BOOL) isLeapYear:(long) y
{
    if(((y%4 == 0) && (y%100 != 0)) || (y%400 == 0)) {
        return YES;
    } else {
        return NO;
    }
}

// 计算当前实例年月的第一天是周几
- (long) weekdayOfYearAndMonth: (long) month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:1];
    NSCalendar *cal = [[NSCalendar alloc]
                       initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [cal dateFromComponents:comps];
    NSDateComponents *weekdaycomp = [cal components:NSCalendarUnitWeekday fromDate:date];
    
    return [weekdaycomp weekday];
}

-(void) printYear
{
    for(int i=1; i<=12; i++){
        [self printMonth:i];
        printf("\n");
    }
    
}

-(void) printMonth: (long) month
{
    if ([self isLeapYear: year]) {
        DAYSOFMONTH[1] = 29;
    } else {
        DAYSOFMONTH[1] = 28;
    }
    
    // 打印日历表头
    printf("\t\t%s\t%4ld\n", MONTH[month-1], year);
    for (int i=0; i<7; i++)
        printf("%s\t", WEEKDAY[i]);
    printf("\n");
    
    int firstday = (int)[self weekdayOfYearAndMonth: month];
    
    // 找到当前月第一天的位置
    for(int k=1; k<firstday; k++)
        printf("\t");
    
    // 打印日期
    for (int i=1; i<=DAYSOFMONTH[month-1]; i++) {
        printf("%2d\t", i);
        if ((firstday+i-1)%7 == 0)
            printf("\n");
    }
    printf("\n");
    
}

@end
