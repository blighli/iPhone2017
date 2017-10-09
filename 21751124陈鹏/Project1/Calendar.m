//
//  Calendar.m
//  Cal
//
//  Created by Mr.Right on 2017/10/4.
//  Copyright © 2017年 Mr.Right. All rights reserved.
//

#import "Calendar.h"
#import "Year.h"
#import "Month.h"
@implementation Calendar
//验证参数中年份的合法性
+ (BOOL) checkLArgLegalityWithYear:(int)year{
    if(year <= 0 || year > 9999){
        if(year == 0){
            printf("cal: year 0 not in range 1..9999\n");
        }else if(year < 0){
            printf("cal: illegal option -- %d\n"
                   "usage: ./cal [-jy] [[month] year]\n"
                   "cal [-j] [-m month] [year]\n", -year);
        }else if(year > 9999){
            printf("cal: year %d not in range 1..9999\n", year);
        }
        return NO;
    }
    return YES;
}
//验证参数中年份和月份的合法性
+ (BOOL) checkLArgLegalityWithYear:(int)year AndMonth:(int)month{
    if(![Calendar checkLArgLegalityWithYear:year]){
        return NO;
    }
    if(month <= 0 || month > 12){
        if(month == 0){
            printf("cal: 0 is neither a month number (1..12) nor a name\n");
        }else if(month < 0){
            printf("cal: illegal option -- %d\n"
                   "usage: ./cal [-jy] [[month] year]\n"
                   "cal [-j] [-m month] [year]\n", -month);
        }else if(month > 12){
            printf("cal: %d is neither a month number (1..12) nor a name\n", month);
        }
        return NO;
    }
    return YES;
}
//将1..12的阿拉伯数字转化为汉字
+ (NSString*) exchangeArabicToChinese:(int)num{
    NSString *str = nil;
    switch(num){
        case 1:
            str = @"一";
            break;
        case 2:
            str = @"二";
            break;
        case 3:
            str = @"三";
            break;
        case 4:
            str = @"四";
            break;
        case 5:
            str = @"五";
            break;
        case 6:
            str = @"六";
            break;
        case 7:
            str = @"七";
            break;
        case 8:
            str = @"八";
            break;
        case 9:
            str = @"九";
            break;
        case 10:
            str = @"十";
            break;
        case 11:
            str = @"十一";
            break;
        case 12:
            str = @"十二";
            break;
        default:
            break;
    }
    return str;
}
//打印某年的某月
- (void) printCalendarWithYearAndAMonth: (Year*) year{
    int yearNum =  [year m_nYear];
    int monthNum = [year m_nMonthNum];
    NSArray *months = [year getMonths];
    NSString *month = [Calendar exchangeArabicToChinese:monthNum];
    printf("%8s月 %d\n", [month UTF8String], yearNum);
    Month *temp = [months objectAtIndex:0];
    [temp printMonthWithoutNum];
}
//打印某年的全部月份
-(void) printCalendarWithYearAndAllMonth:(Year *)year{
    int yearNum =  [year m_nYear];
    NSArray *months = [year getMonths];
    printf("%33d\n\n", yearNum);
    for(int i = 0; i < [months count]; i += 3){
        NSArray *temp = [NSArray arrayWithObjects:[months objectAtIndex:i], [months objectAtIndex:i + 1], [months  objectAtIndex:i + 2], nil];
        //控制十一月、十二月的格式
        if(i < 9){
            printf("%12s月%20s月%23s月\n", [[Calendar exchangeArabicToChinese:[[temp objectAtIndex:0] m_nMonthNum]] UTF8String], [[Calendar exchangeArabicToChinese:[[temp objectAtIndex:1] m_nMonthNum]] UTF8String], [[Calendar exchangeArabicToChinese:[[temp objectAtIndex:2] m_nMonthNum]] UTF8String]);
        }else{
            printf("%12s月%23s月%23s月\n", [[Calendar exchangeArabicToChinese:[[temp objectAtIndex:0] m_nMonthNum]] UTF8String], [[Calendar exchangeArabicToChinese:[[temp objectAtIndex:1] m_nMonthNum]] UTF8String], [[Calendar exchangeArabicToChinese:[[temp objectAtIndex:2] m_nMonthNum]] UTF8String]);
        }
        
        for(int j = 0; j < [temp count]; ++j){
            Month *month = [temp objectAtIndex:j];
            [month printMonthTitle];
            printf(" ");
        }
        printf("\n");
        
        int dayLengths[3] = {[[temp objectAtIndex:0] m_nDayLength], [[temp objectAtIndex:1] m_nDayLength], [[temp objectAtIndex:2] m_nDayLength]};
        //查询三个月中周数最多的月份
        int t;
        int a = (dayLengths[0] - 1 + [[temp objectAtIndex:0] m_nWeekdayOfFirstDay] + 7) / 7;
        int b = (dayLengths[1] - 1 + [[temp objectAtIndex:1] m_nWeekdayOfFirstDay] + 7) / 7;
        int c = (dayLengths[2] - 1 + [[temp objectAtIndex:2] m_nWeekdayOfFirstDay] + 7) / 7;
        if(a > b){
            t = a;
        }else{
            t = b;
        }
        if(t < c){
            t = c;
        }
        
        
        int counts[3] = {1, 1, 1};  //记录三个月每个月的日期
        for(int n = 0; n < t; ++n){
            for(int j = 0; j < [temp count]; ++j){
                int control = 0;    //控制7天换行
                Month *month = [temp objectAtIndex:j];
                if(n == 0){
                    for(int k = 1; k < [month m_nWeekdayOfFirstDay]; ++k){
                        printf("   ");
                        ++control;
                    }
                }
                while(control < 7){
                    if(counts[j] <= dayLengths[j]){
                        printf("%2d ", counts[j]);
                        ++counts[j];
                    }else{
                        printf("%2s ", " ");
                    }
                    ++control;
                    if(control == 7){
                        printf(" ");
                    }
                }
            }
            printf("\n");
        }
    }
}

@end
