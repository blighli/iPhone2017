//
//  Cal.m
//  project01
//
//  Created by 周新哲 on 2017/10/10.
//  Copyright © 2017年 周新哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cal.h"

//月份
static NSString* MONTH[] = {@" 一月",@" 二月",@" 三月",@" 四月",@" 五月",@" 六月",@" 七月",@" 八月",@" 九月",@" 十月",@"十一月",@"十二月"};

@implementation Cal

/**
 获取当前时间的日历
 @return 日历字符串，带表头
 */
+ (NSString *)showCalByToday{
    NSDate *date = [NSDate date];
    date = [Cal GMT2Locale:date];//将时间转换为本地时间
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth;//获取年月
    NSDateComponents *conponents = [cal components:unitFlags fromDate:date];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的conponents里面；
    NSInteger year = [conponents year];
    NSInteger month = [conponents month];
    NSMutableString *result = [[NSMutableString alloc] initWithFormat:@"\n"];
    //日历表头，居中显示
    NSString *title = [NSString stringWithFormat:@"    %@ %ld\n",MONTH[month-1],year];
    NSString *subTitle = @"日 一 二 三 四 五 六\n";
    [result appendFormat:@"%@%@",title,subTitle];
    [result appendString:[Cal buildMonthCal:month :year]];
    return result;
}

/**
 获取指定年份的年日历
 @param year 年份
 @return 日历字符串，带表头
 */
+ (NSString *)showCalByYear:(int)year{
    //最终日历字符串
    NSMutableString *result = [[NSMutableString alloc] initWithFormat:@"\n%32d\n\n",year];
    //获取每个月的日历，按行拆分到数组中，每个日历占8行，共12个月
    NSMutableArray *monthCalArray = [[NSMutableArray alloc] init];
    for (int m = 1; m <= 12; m++) {
        NSString *monthCalString = [Cal buildMonthCal:m :year];
        NSMutableArray *eachMonthArray = [[monthCalString componentsSeparatedByString:@"\n"] mutableCopy];
        [monthCalArray addObject:eachMonthArray];
    }
    //每组三个月的日历，共四组，每个月8行
    for (int i = 0; i < 4; i++) {
        NSString *title;
        if(i<3) title = [NSString stringWithFormat:@"       %@                %@                 %@        \n",MONTH[3*i],MONTH[3*i+1],MONTH[3*i+2]];
        else title = [NSString stringWithFormat:@"       %@                 %@                %@       \n",MONTH[3*i],MONTH[3*i+1],MONTH[3*i+2]];
        NSString *subTitle = @"日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n";
        [result appendFormat:@"%@%@",title,subTitle];
        //拼接8行，组成三个月
        for (int j = 0; j < 6; j++) {
            //拼接每一行
            for (int k = 3*i; k < 3*i+3; k++) {
                NSMutableString *eachMonthLine = [monthCalArray[k][j] mutableCopy];
                while (eachMonthLine.length<20) {
                    if (j == 1) {
                        break;
                    }
                    [eachMonthLine appendFormat:@" "];
                }
                [result appendFormat:@"%@",eachMonthLine];
                if (k < 3*i+2) [result appendFormat:@"  "];
            }
            if(i != 3 || j != 5) [result appendFormat:@"\n"];
        }
    }
    return result;
}

/**
 获取指定年份和月份的日历
 @param month 月份
 @param year 年份
 @return 日历字符串，带表头
 */
+(NSString *)showCalByMonth:(NSInteger)month andYear:(NSInteger)year{
    NSMutableString *result = [[NSMutableString alloc] initWithFormat:@"\n"];
    //日历表头，居中显示
    NSString *title = [NSString stringWithFormat:@"    %@ %ld\n",MONTH[month-1],year];
    NSString *subTitle = @"日 一 二 三 四 五 六\n";
    [result appendFormat:@"%@%@",title,subTitle];
    [result appendString:[Cal buildMonthCal:month :year]];
    return result;
}

/**
 构建月日历
 @param month 月份
 @param year 年份
 @return 日历字符串
 */
+ (NSString *)buildMonthCal:(NSInteger)month :(NSInteger)year{
    NSDateComponents *firstComponets = [[NSDateComponents alloc] init];
    [firstComponets setMonth:month];
    [firstComponets setYear:year];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *first = [cal dateFromComponents:firstComponets];//每月第一天
    firstComponets = [cal components:NSCalendarUnitWeekday fromDate:first];//提取每月第一天是星期几
    NSInteger weekday = [firstComponets weekday];//周日对应1，周一对应2,以此类推
    NSMutableString *result = [NSMutableString stringWithFormat:@""];
    //得到当前月中天的取值范围
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:first];
    int maxDay = (int)range.length;
    
    int weekdayCount = 1;
    int dayCount = 1;
    //计算第一天前的空白
    for (;weekday > 1;weekday--,weekdayCount++) {
        [result appendString:@"   "];
    }
    int rowCount = 0;
    //循环追加每行
    while (dayCount <= maxDay) {
        rowCount++;//行数+1
        //循环追加每天
        while (weekdayCount <= 7) {
            if (weekdayCount <= 6) [result appendFormat:@"%2d ",dayCount];
            else [result appendFormat:@"%2d",dayCount];
            weekdayCount++;
            dayCount++;
            if (dayCount>maxDay) break;
        }
        //追加最后一行后的留白
        while (weekdayCount <= 7) {
            if (weekdayCount <= 6) [result appendFormat:@"   "];
            else [result appendFormat:@"  "];
            weekdayCount++;
        }
        weekdayCount = 1;//重置每周第一天
        if (dayCount <= maxDay) {
            [result appendFormat:@"\n"];
        }
    }
    //如果只有五行，加一行空行
    if (rowCount == 5) {
        [result appendFormat:@"\n"];
    }
    return result;
}

/**
 将GMT时间转化为本地时间
 @param GMTDate GMT时间
 @return 本地时间
 */
+ (NSDate *)GMT2Locale:(NSDate *)GMTDate{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:GMTDate];
    return [GMTDate dateByAddingTimeInterval:interval];
}

@end
