//
//  PrintYearAndMonth.m
//  Project01
//
//  Created by YanYufei on 2017/10/9.
//  Copyright © 2017年 YanYufei. All rights reserved.
//

#import "PrintYearAndMonth.h"
#import "Day.h"

@implementation PrintYearAndMonth
//输出每个月的日历的函数
//输出一个月的日历
- (void) printMonth:(int)year yue:(int)yue{
    NSNumber *none = [[NSNumber alloc] initWithInt:0];
    NSNumber *jan = [[NSNumber alloc] initWithInt:31];
    NSNumber *febLeapYear = [[NSNumber alloc] initWithInt:29];
    NSNumber *febNotLeapYear = [[NSNumber alloc] initWithInt:28];;
    NSNumber *mar = [[NSNumber alloc] initWithInt:31];;
    NSNumber *apr = [[NSNumber alloc] initWithInt:30];;
    NSNumber *may = [[NSNumber alloc] initWithInt:31];;
    NSNumber *june = [[NSNumber alloc] initWithInt:30];;
    NSNumber *july = [[NSNumber alloc] initWithInt:31];;
    NSNumber *aug = [[NSNumber alloc] initWithInt:31];;
    NSNumber *sep = [[NSNumber alloc] initWithInt:30];;
    NSNumber *oco = [[NSNumber alloc] initWithInt:31];;
    NSNumber *nov = [[NSNumber alloc] initWithInt:30];;
    NSNumber *dec = [[NSNumber alloc] initWithInt:31];;
    
    NSMutableArray *monthArray = [[NSMutableArray alloc] init];
    
    if([Day isLeapYear:year]){
        NSArray *arr = [[NSArray alloc] initWithObjects:none, jan, febLeapYear, mar, apr, may, june, july, aug, sep, oco, nov, dec, nil];
        [monthArray addObjectsFromArray:arr];
    } else {
        NSArray *arr = [[NSArray alloc] initWithObjects:none,jan,febNotLeapYear,mar,apr,may,june,july,aug,sep,oco,nov,dec, nil];
        [monthArray addObjectsFromArray:arr];
    }
    int day = 0;
    
    //考虑怎样使标题居中显示；
    //计算一个月份日历的长度
    NSString *calendarStr = [[NSString alloc] initWithFormat:@"%@", @" Su Mo Tu We Th Fr Sa"];
    //年份转让为字符串
    NSMutableString *yearStr = [[NSMutableString alloc] initWithFormat:@"%d", year];
    NSMutableString *monthStr = [PrintYearAndMonth transformMonthToEnglish:yue];
    [monthStr appendString:@" "];
    [monthStr appendString:yearStr];
    //计算标题长度
    int titleLen = (int)yearStr.length;
    //计算一个月日历的长度
    int calendarLen = (int)calendarStr.length;
    //计算左侧需要空出的空格数
    int blankLen = (calendarLen - titleLen) / 2;
    for(int i = 0; i< blankLen - 2; i++){
        printf(" ");
    }
    printf("%s\n", [monthStr UTF8String]);
    printf(" Su Mo Tu We Th Fr Sa\n");
    day = [Day daysOfUntilLastMonth:year yue:yue];

    //下面开始进行输出；
    //首先寻找这个月的1号是星期几？
    
    //主要就是在哪一个位置输出；
    
    /*
     一月 1
     日 一  二 三 四 五  六
     1
     2  3  4  5  6  7  8
     9 10 11 12 13 14 15
     16 17 18 19 20 21 22
     23 24 25 26 27 28 29
     30 31
     
     */
    
    int position = (day + 5) % 7 + 2;//fixed
    
    //注意:当position == 7的时候，第一行会留空；
    
    //确定Position后开始打印；
    //输出第一行前面的空格；
//    NSLog(@"position = %i", position);
    if (position == 7) {//fixed
    }else{
        for (int i = 0; i < position; i++) {
            printf("   ");
        }
    }
    
    //输出第一行；
    int i;
    for (i = 0; i < (6 - position) + 1;) {//??todo fixed？？原来就是6
        printf(" %2d",++i);
    }
    
    if (position == 7) {//fixed
    } else {
        printf("\n");
    }
    
    //输出第二行开始所有的；
    int count = 0;
    for (; i < [[monthArray objectAtIndex:yue] intValue]; ) {
        
        printf(" %2d",++i);
        
        count++;
        if (count == 7) {
            printf("\n");
            count = 0;
        }
    }
    //月份输出完毕，换行结束；
    printf("\n");
}

//输出全年的函数
- (void) printYear:(int)year{
    //首先居中打出年份；
    printf("                               %d\n\n",year);
    printf("       January               February               March\n");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf("\n");
    
    //开始打印一月的第一行；
    int day1 = 0;
    //上一年距离第一年第一天的天数；
    day1 = [Day daysOfUntilLastMonth:year yue:1];
    int position1 = (day1 + 5) % 7 + 2;//fixed
    
    if (position1 == 7) {
    }else{
        for (int i = 0; i < position1; i++) {
            printf("   ");
        }
    }
    
    int i1;
    if (position1 == 7) {
        for (i1 = 0; i1 < 7;) {
            printf(" %2d",++i1);
        }
    } else {
        for (i1 = 0; i1 < (6 - position1) + 1;) {
            printf(" %2d",++i1);
            
        }
        
    }
    
    //开始打印2月的第一行；
    int day2 = 0;
    day2 = [Day daysOfUntilLastMonth:year yue:2];
    int position2 = (day2 + 5) % 7 + 2;//fixed
    
    printf(" ");
    
    if (position2 == 7) {
    }else{
        for (int i = 0; i < position2; i++) {
            printf("   ");
        }
    }
    
    int i2;
    if (position2 == 7) {
        for (i2 = 0; i2 < 7;) {
            printf(" %2d",++i2);
        }
    } else {
        for (i2 = 0; i2 < (6 - position2) + 1;) {
            printf(" %2d",++i2);
            
        }
    }
    
    //开始打印3月的第一行；
    int day3 = 0;
    day3 = [Day daysOfUntilLastMonth:year yue:3];
    int position3 = (day3 + 5) % 7 + 2;//fixed
    
    printf(" ");
    
    if (position3 == 7) {
    }else{
        for (int i = 0; i < position3; i++) {
            printf("   ");
        }
    }
    
    int i3;
    if (position3 == 7) {
        for (i3 = 0; i3 < 7;) {
            printf(" %2d",++i3);
        }
    } else {
        for (i3 = 0; i3 < (6 - position3) + 1;) {
            printf(" %2d",++i3);
        }
    }
    
    printf("\n");
    
    int count1 = 0;
    int count2 = 0;
    int count3 = 0;
    BOOL flag1 = true;
    BOOL flag2 = true;
    BOOL flag3 = true;
    
    while (flag1 || flag2 || flag3) {
        //开始打印1月的第二行；
        for (; true; ) {
            if (i1 >= 31) {
                printf("   ");//第1个月全部打印完毕，打印空格；
                flag1 = false;
            }else{
                printf(" %2d",++i1);
            }
            count1++;
            if (count1 == 7) {
                count1 = 0;
                //打印2月的第二行;
                printf(" ");
                for (; true ; ) {
                    if (i2 >= ([Day isLeapYear:year] == true ? 29 : 28)) {
                        printf("   ");//第2个月全部打印完毕，打印空格；
                        flag2 = false;
                    }else{
                        printf(" %2d",++i2);
                    }
                    count2++;
                    if (count2 == 7) {
                        count2 = 0;
                        //打印3月的第二行；
                        printf(" ");
                        for (; true; ) {
                            if (i3 >= 31) {
                                flag3 = false;
                            } else {
                                printf(" %2d",++i3);
                            }
                            
                            count3++;
                            if (count3 == 7) {
                                count3 = 0;
                                printf("\n");
                                break;
                            }
                        }
                        break;
                    }
                }
                break;
            }
        }
    }
    
    //打印第2组；
    //总共四组，首先实现第2组；
    printf("        April                  May                   June\n");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf("\n");
    
    //开始打印4月的第一行；
    int day4 = 0;
    //上一年距离第一年第一天的天数；
    day4 = [Day daysOfUntilLastMonth:year yue:4];
    int position4 = (day4 + 5) % 7 + 2;//fixed
    
    if (position4 == 7) {
    }else{
        for (int i = 0; i < position4; i++) {
            printf("   ");
        }
    }
    
    int i4;
    if (position4 == 7) {
        for (i4 = 0; i4 < 7;) {
            printf(" %2d",++i4);
        }
    } else {
        for (i4 = 0; i4 < (6 - position4) + 1;) {
            printf(" %2d",++i4);
            
        }
        
    }
    
    //开始打印5月的第一行；
    int day5 = 0;
    day5 = [Day daysOfUntilLastMonth:year yue:5];
    int position5 = (day5 + 5) % 7 + 2;//fixed
    
    printf(" ");
    
    if (position5 == 7) {
    }else{
        for (int i = 0; i < position5; i++) {
            printf("   ");
        }
    }
    
    int i5;
    if (position5 == 7) {
        for (i5 = 0; i5 < 7;) {
            printf(" %2d",++i5);
        }
    } else {
        for (i5 = 0; i5 < (6 - position5) + 1;) {
            printf(" %2d",++i5);
            
        }
        
    }
    
    //开始打印6月的第一行；
    int day6 = 0;
    day6 = [Day daysOfUntilLastMonth:year yue:6];
    int position6 = (day6 + 5) % 7 + 2;//fixed
    
    printf(" ");
    
    if (position6 == 7) {
    }else{
        for (int i = 0; i < position6; i++) {
//            printf("   ");
            printf("  ");//fixed,少了一个空格
        }
    }
    
    int i6;
    if (position6 == 7) {
        for (i6 = 0; i6 < 7;) {
            printf(" %2d",++i6);
        }
    } else {
        for (i6 = 0; i6 < (6 - position6) + 1;) {
            printf(" %2d",++i6);
            
        }
        
    }
    printf("\n");
    
    int count4 = 0;
    int count5 = 0;
    int count6 = 0;
    BOOL flag4 = true;
    BOOL flag5 = true;
    BOOL flag6 = true;
    
    while (flag4 || flag5 || flag6) {
        //开始打印4月的第二行；
        for (; true; ) {
            if (i4 >= 30) {
                printf("   ");//第4个月全部打印完毕，打印空格；
                flag4 = false;
            }else{
                printf(" %2d",++i4);
            }
            count4++;
            if (count4 == 7) {
                count4 = 0;
                //打印5月的第二行;
                printf(" ");
                for (; true ; ) {
                    if (i5 >= 31) {
                        printf("   ");//第5个月全部打印完毕，打印空格；
                        flag5 = false;
                    }else{
                        printf(" %2d",++i5);
                    }
                    count5++;
                    if (count5 == 7) {
                        count5 = 0;
                        //打印6月的第二行；
                        printf(" ");
                        for (; true; ) {
                            if (i6 >= 30) {
                                flag6 = false;
                            }else{
                                printf(" %2d",++i6);
                            }
                            count6++;
                            if (count6 == 7) {
                                count6 = 0;
                                printf("\n");
                                break;
                            }
                        }
                        break;
                    }
                }
                break;
            }
        }
    }
    
    //打印第3组；
    //总共四组，首先实现第3组；
    printf("         July                 August               September\n");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf("\n");
    
    //开始打印7月的第一行；
    int day7 = 0;
    //上一年距离第一年第一天的天数；
    day7 = [Day daysOfUntilLastMonth:year yue:7];
    int position7 = (day7 + 5) % 7 + 2;//fixed
    
    if (position7 == 7) {
    }else{
        for (int i = 0; i < position7; i++) {
            printf("   ");
        }
    }
    
    int i7;
    if (position7 == 7) {
        for (i7 = 0; i7 < 7;) {
            printf(" %2d",++i7);
        }
    } else {
        for (i7 = 0; i7 < (6 - position7) + 1;) {
            printf(" %2d",++i7);
            
        }
        
    }
    
    //开始打印8月的第一行；
    int day8 = 0;
    day8 = [Day daysOfUntilLastMonth:year yue:8];
    int position8 = (day8 + 5) % 7 + 2;//fixed
    
    printf(" ");
    
    if (position8 == 7) {
    }else{
        for (int i = 0; i < position8; i++) {
            printf("   ");
        }
    }
    
    int i8;
    if (position8 == 7) {
        for (i8 = 0; i8 < 7;) {
            printf(" %2d",++i8);
        }
    } else {
        for (i8 = 0; i8 < (6 - position8) + 1;) {
            printf(" %2d",++i8);
            
        }
        
    }
    
    //开始打印9月的第一行；
    int day9 = 0;
    day9 = [Day daysOfUntilLastMonth:year yue:9];
    int position9 = (day9 + 5) % 7 + 2;//fixed
    
    printf(" ");
    
    if (position9 == 7) {
    }else{
        for (int i = 0; i < position9; i++) {
            printf("   ");
        }
    }
    
    int i9;
    if (position9 == 7) {
        for (i9 = 0; i9 < 7;) {
            printf(" %2d",++i9);
        }
    } else {
        for (i9 = 0; i9 < (6 - position9) + 1;) {
            printf(" %2d",++i9);
        }
    }
    printf("\n");
    
    int count7 = 0;
    int count8 = 0;
    int count9 = 0;
    BOOL flag7 = true;
    BOOL flag8 = true;
    BOOL flag9 = true;
    
    while (flag7 || flag8 || flag9) {
        //开始打印7月的第二行；
        for (; true; ) {
            if (i7 >= 31) {
                printf("   ");//第7个月全部打印完毕，打印空格；
                flag7 = false;
            }else{
                printf(" %2d",++i7);
            }
            count7++;
            if (count7 == 7) {
                count7 = 0;
                //打印8月的第二行;
                printf(" ");
                for (; true ; ) {
                    if (i8 >= 31) {
                        printf("   ");//第8个月全部打印完毕，打印空格；
                        flag8 = false;
                    }else{
                        printf(" %2d",++i8);
                    }
                    count8++;
                    if (count8 == 7) {
                        count8 = 0;
                        //打印9月的第二行；
                        printf(" ");
                        for (; true; ) {
                            if (i9 >= 30) {
                                flag9 = false;
                            }else{
                                printf(" %2d",++i9);
                            }
                            count9++;
                            if (count9 == 7) {
                                count9 = 0;
                                printf("\n");
                                break;
                            }
                        }
                        break;
                    }
                }
                break;
            }
        }
    }
    
    //打印第4组；
    //总共四组，首先实现第4组；
    printf("        October               November             December\n");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf(" Su Mo Tu We Th Fr Sa ");
    printf("\n");
    
    //开始打印10月的第一行；
    int day10 = 0;
    //上一年距离第一年第一天的天数；
    day10 = [Day daysOfUntilLastMonth:year yue:10];
    int position10 = (day10 + 5) % 7 + 2;//fixed
    
    if (position10 == 7) {
    }else{
        for (int i = 0; i < position10; i++) {
            printf("   ");
        }
    }
    
    int i10;
    if (position10 == 7) {
        for (i10 = 0; i10 < 7;) {
            printf(" %2d",++i10);
        }
    } else {
        for (i10 = 0; i10 < (6 - position10) + 1;) {
            printf(" %2d",++i10);
            
        }
        
    }
    
    //开始打印11月的第一行；
    int day11 = 0;
    day11 = [Day daysOfUntilLastMonth:year yue:11];
    int position11 = (day11 + 5) % 7 + 2;//fixed
    
    printf(" ");
    
    if (position11 == 7) {
    }else{
        for (int i = 0; i < position11; i++) {
            printf("   ");
        }
    }
    
    int i11;
    if (position11 == 7) {
        for (i11 = 0; i11 < 7;) {
            printf(" %2d",++i11);
        }
    } else {
        for (i11 = 0; i11 < (6 - position11) + 1;) {
            printf(" %2d",++i11);
            
        }
        
    }
    
    //开始打印12月的第一行；
    int day12 = 0;
    day12 = [Day daysOfUntilLastMonth:year yue:12];
    int position12 = (day12 + 5) % 7 + 2;//fixed
    
    printf(" ");
    
    if (position12 == 7) {
    }else{
        for (int i = 0; i < position12; i++) {
            printf("   ");
        }
    }
    
    int i12;
    if (position12 == 7) {
        for (i12 = 0; i12 < 7;) {
            printf(" %2d",++i12);
        }
    } else {
        for (i12 = 0; i12 < (6 - position12) + 1;) {
            printf(" %2d",++i12);
            
        }
        
    }
    printf("\n");
    
    int count10 = 0;
    int count11 = 0;
    int count12 = 0;
    BOOL flag10 = true;
    BOOL flag11 = true;
    BOOL flag12 = true;
    
    while (flag10 || flag11 || flag12) {
        //开始打印10月的第二行；
        for (; true; ) {
            if (i10 >= 31) {
                printf("   ");//第7个月全部打印完毕，打印空格；
                flag10 = false;
            }else{
                printf(" %2d",++i10);
            }
            count10++;
            if (count10 == 7) {
                count10 = 0;
                //打印11月的第二行;
                printf(" ");
                for (; true ; ) {
                    if (i11 >= 30) {
                        printf("   ");//第8个月全部打印完毕，打印空格；
                        flag11 = false;
                    }else{
                        printf(" %2d",++i11);
                    }
                    count11++;
                    if (count11 == 7) {
                        count11 = 0;
                        //打印12月的第二行；
                        printf(" ");
                        for (; true; ) {
                            if (i12 >= 31) {
                                flag12 = false;
                            }else{
                                printf(" %2d",++i12);
                            }
                            count12++;
                            if (count12 == 7) {
                                count12 = 0;
                                printf("\n");
                                break;
                            }
                        }
                        break;
                    }
                }
                break;
            }
        }
    }
    printf("\n");
}

+ (NSMutableString *) transformMonthToEnglish:(int)month{
    switch (month) {
        case  1:
            return [[NSMutableString alloc] initWithFormat:@"January"];
            break;
        case  2:
            return [[NSMutableString alloc] initWithFormat:@"February"];
            break;
        case  3:
            return [[NSMutableString alloc] initWithFormat:@"March"];
            break;
        case  4:
            return [[NSMutableString alloc] initWithFormat:@"April"];
            break;
        case  5:
            return [[NSMutableString alloc] initWithFormat:@"May"];
            break;
        case  6:
            return [[NSMutableString alloc] initWithFormat:@"June"];
            break;
        case  7:
            return [[NSMutableString alloc] initWithFormat:@"July"];
            break;
        case  8:
            return [[NSMutableString alloc] initWithFormat:@"August"];
            break;
        case  9:
            return [[NSMutableString alloc] initWithFormat:@"September"];
            break;
        case  10:
            return [[NSMutableString alloc] initWithFormat:@"October"];
            break;
        case  11:
            return [[NSMutableString alloc] initWithFormat:@"November"];
            break;
        case  12:
            return [[NSMutableString alloc] initWithFormat:@"December"];
            break;
        default:
            break;
    }
    return [[NSMutableString alloc] initWithFormat:@""];;
}
                                 
@end
