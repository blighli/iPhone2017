//
//  DaysInterval.m
//  command-cal
//
//  Created by Edith.S on 2017/10/6.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import "DaysInterval.h"

@implementation DaysInterval

//判断闰年的标准：能整除4且不能整除100 或者 能整除400


/**
 判断输入年份是否为闰年

 @param year 需要判断的年份
 @return 闰年返回true，反之false
 */
+(BOOL) isLeapYear:(NSInteger) year{
    if ((year%4 == 0 && year%100 != 0 ) || (year%400 == 0 ) ){
        return  true;
    }else{
        return false;
    }
}


/**
 计算从公元元年(1年)到上一年年末共有多少天
 1. 计算公元元年至今一共有多少个闰年
 2. 天数= 365*年+闰年个数
 
 @param currentYear 输入的年份
 @return 从公元元年(1年)到上一年年末的天数
 */
+(NSInteger) daysInBetweenUntilLastYear:(NSInteger) currentYear{
    NSInteger intervalDays = 0;
//    BOOL isLeapYear;
    NSInteger leapYearCount = 0;
    
    //从公元元年开始循环，计算1年至去年的闰年数量
    for (int i = 1; i<currentYear; i++) {
        //如果是闰年，则闰年计数器+1
        if ([DaysInterval isLeapYear:i]) {
            leapYearCount++;
            //NSLog(@"%d,%d",i,leapYearCount);
        }
    }
    
    intervalDays = 365*(currentYear -1) + leapYearCount;
//    NSLog(@"公元元年至去年一共有 %ld 天", (long)intervalDays);
    
    return intervalDays;
}



+(NSMutableArray*) monthsInYear:(NSInteger) year{
    //初始化十二个月每个月的天数
    NSNumber *jan = [[NSNumber alloc] initWithInt:31];
    NSNumber *febLeap = [[NSNumber alloc] initWithInt:29];
    NSNumber *febNotLeapo = [[NSNumber alloc] initWithInt:28];
    NSNumber *mar = [[NSNumber alloc] initWithInt:31];
    NSNumber *apr  = [[NSNumber alloc] initWithInt:30];
    NSNumber *may  = [[NSNumber alloc] initWithInt:31];
    NSNumber *jun  = [[NSNumber alloc] initWithInt:30];
    NSNumber *jul  = [[NSNumber alloc] initWithInt:31];
    NSNumber *agu  = [[NSNumber alloc] initWithInt:31];
    NSNumber *sep  = [[NSNumber alloc] initWithInt:30];
    NSNumber *oct  = [[NSNumber alloc] initWithInt:31];
    NSNumber *nov  = [[NSNumber alloc] initWithInt:30];
    NSNumber *dec  = [[NSNumber alloc] initWithInt:31];
    
    NSMutableArray *monthArray = [[NSMutableArray alloc] init];
    //将输入年份的月天数信息存入数组
    if ([DaysInterval isLeapYear:year]) {
        NSArray *month = [[NSArray alloc] initWithObjects:jan,febLeap,mar,apr,may,jun,jul,agu,sep,oct,nov,dec, nil];
        [monthArray addObjectsFromArray:month];
    }else{
        NSArray *month = [[NSArray alloc] initWithObjects:jan,febNotLeapo,mar,apr,may,jun,jul,agu,sep,oct,nov,dec, nil];
        [monthArray addObjectsFromArray:month];
    }
    
    return monthArray;

}
/**
  计算从元年到上一个月有多少天

 @param currentYear 输入的年份
 @param currentMonth 输入的月份
 @return  从元年到上一个月月末的天数
 */
+(NSInteger) daysInBetweenUntilYear:(NSInteger) currentYear month:(NSInteger) currentMonth{
    //先计算到去年年末的间隔天数
    NSInteger intervalDays = [DaysInterval daysInBetweenUntilLastYear:currentYear];
    //printf("%d",currentYear);
    
    NSMutableArray *monthArray = [DaysInterval monthsInYear:currentYear];
    
    for (int i = 0; i<currentMonth-1; i++) {
        intervalDays += [[monthArray objectAtIndex:i] intValue];
        //NSLog(@"%d",[[monthArray objectAtIndex:i] intValue]);
    }
    return intervalDays;
}

@end
