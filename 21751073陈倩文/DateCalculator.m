//
//  DateCalculator.m
//  cal_cqw
//
//  Created by 陈倩文 on 2017/10/9.
//  Copyright © 2017年 陈倩文. All rights reserved.
//

#import "DateCalculator.h"

@implementation DateCalculator
+ (BOOL) isLeapYear:(int)year {
    if ((year%4==0 && year%100!=0)|| year%400==0) {
        return YES;
    }else{
        return NO;
    }
}
+ (int) daysOfUntilLastYear:(int)year {
    int days = 0;
    BOOL isLeap;
    for(int i=1;i<year;i++){
        isLeap = [DateCalculator isLeapYear:i];
        if(isLeap){
            days += 366;
        }else{
            days += 365;
        }
    }
    return days;
}
+ (int) daysOfUntilLastMonth:(int)month AndYear:(int)year {
    int days = [DateCalculator daysOfUntilLastYear:year];
    NSArray *nleapYear = [[NSArray alloc] initWithObjects:@"0",@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31",nil];
    NSArray *leapYear = [[NSArray alloc] initWithObjects:@"0",@"31",@"29",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31",nil];
    //NSArray *years = [[NSArray alloc] initWithObjects:nleapYear,leapYear,nil];
    NSArray *years;
    BOOL isLeap = [DateCalculator isLeapYear:year];
    if(isLeap){
        years = leapYear;
    }else{
        years = nleapYear;
    }
    for (int i=1;i<month;i++){
        days+= [years[i] intValue];
    }
    return days;
}
@end
