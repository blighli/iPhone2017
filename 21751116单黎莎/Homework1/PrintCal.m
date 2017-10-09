//
//  PrintCal.m
//  command-cal
//
//  Created by Edith.S on 2017/10/6.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import "PrintCal.h"
#import "DaysInterval.h"

@implementation PrintCal

+(NSString*) monthDisplayWith:(NSInteger)monthNum{
    NSArray *monthArray = [[NSArray alloc] initWithObjects:@"一月", @"二月", @"三月", @"四月", @"五月", @"六月",@"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月", nil];
    //NSLog(@"%lu", (unsigned long)[monthArray count]);
    return [monthArray objectAtIndex:monthNum-1];
}


/**
  根据传入的年份打印出对应的年历
  输出格式：年份居中显示，年份与下方空出一行；一行三个月，月历与月历之间的间隔为两个空格

 
    需要完成的工作:
    1、居中显示年份：一行64格子，左侧留白为（64-年份占用格数）/2
    2、分组打印月份
 
 @param currentYear 需要展示的年份
 */
-(void) printYear:(NSInteger)currentYear{
    //获取月份的天数信息的数组
        NSMutableArray *monthDaysArray = [NSMutableArray arrayWithArray:[DaysInterval monthsInYear:currentYear]];
    //将年份转换为字符串
    NSString *yearStr = [NSString stringWithFormat:@"%d",(int)currentYear];
    //居中显示年份
    //计算左侧留白
    NSNumber *margin = [NSNumber numberWithInt: (int)(64-yearStr.length)];
    for (int i = 0; i<[margin intValue]*0.5; i++) {
        printf(" ");
    }
    printf("%d\n",currentYear);
    
    //打印一二三月
    {
        //打印月份
        printf("        一月                  二月                  三月\n");
        //打印星期行
        [PrintCal printWeekTitles];
        
        //计算1.1是星期几，确定位置
        NSInteger intervalDays1 = [DaysInterval daysInBetweenUntilYear:currentYear month:1];
        NSInteger position1 = (intervalDays1%7+6)%7;
        //打印一月的第一行
        for (int i = 0; i<position1; i++) {
            printf("   ");
        }
        NSInteger date1 = 1;
        for (; date1 <=(7-position1); date1++) {
            printf("%2d ",(int)date1);
        }//输出至第一个周六，多空一格
        printf(" ");
        
        //计算2.1是周几，确定位置并输出第一行
        NSInteger intervalDays2 = [DaysInterval daysInBetweenUntilYear:currentYear month:2];
        NSInteger position2 = (intervalDays2%7+6)%7;
        //打印二月的第一行
        for (int i = 0; i<position2; i++) {
            printf("   ");
        }
        NSInteger date2 = 1;
        for (; date2 <=(7-position2); date2++) {
            printf("%2d ",(int)date2);
        }//输出至第一个周六，多空一格
        printf(" ");
        
        //计算3.1是周几，确定位置并输出第一行
        NSInteger intervalDays3 = [DaysInterval daysInBetweenUntilYear:currentYear month:3];
        NSInteger position3 = (intervalDays3%7+6)%7;
        for (int i = 0; i<position3; i++) {
            printf("   ");
        }
        //打印三月的第一行
        NSInteger date3 = 1;
        for (; date3 <=(7-position3); date3++) {
            printf("%2d ",(int)date3);
        }//输出至第一个周六，换行
        printf("\n");
        
        //输出第二行
        BOOL end1 = false;
        BOOL end2 = false;
        BOOL end3 = false;
        NSInteger count1 = 0;
        NSInteger count2 = 0;
        NSInteger count3 = 0;
        //printf("this");
        //printf("%d\n",end1&&end2&&end3);      0
        //判断是否所有的月份都打印结束了
        while(!(end1&&end2&&end3)){
            while (true) {
                //当date大于月份天数的时候，只输出空格
                if (date1>[[monthDaysArray objectAtIndex:0] intValue]) {
                    printf("   ");
                    end1 = true;
                }else{
                    //没打印完则继续打印
                    printf("%2d ",(int)date1);
                    date1++;
                }//end if0.1
                count1++;
                //每输出7个日期，则输出2个空格，然后打印二月
                if (count1 == 7) {
                    //重置count
                    count1 =0;
                    //打印二月
                    printf(" ");
                    while (true) {
                        //根据是否为闰年确定二月的天数
                        //date2 > ([DaysInterval isLeapYear:currentYear] == true? 29 : 28
                        if (date2>[[monthDaysArray objectAtIndex:1] intValue]) {
                            printf("   ");
                            end2 = true;
                        }else{
                            printf("%2d ",(int)date2);
                            date2++;
                        }//end if0.2
                        count2++;
                        
                        if (count2 == 7) {
                            count2 = 0;
                            printf(" ");
                            while (true) {
                                if (date3>[[monthDaysArray objectAtIndex:2] intValue]) {
                                    end3 = true;
                                }else{
                                    printf("%2d ",(int)date3);
                                    date3++;
                                }
                                count3++;
                                if (count3 ==7) {
                                    count3 =0;
                                    printf("\n");
                                    break;//跳出while3
                                }//endif 0.3
                            }//while3
                            break;//跳出while2
                        }//endif2
                    }//while2
                    break;//跳出while1
                }//end if1
            }//while1
            
        }//while0
    }//结束打印一二三月
    // 格式验证正确

    
    //打印四五六月
    {
        printf("        四月                  五月                  六月\n");
        //打印星期行
        [PrintCal printWeekTitles];
        
        //计算1.1是星期几，确定位置
        NSInteger intervalDays4 = [DaysInterval daysInBetweenUntilYear:currentYear month:4];
        NSInteger position4 = (intervalDays4%7+6)%7;
        //打印一月的第一行
        for (int i = 0; i<position4; i++) {
            printf("   ");
        }
        NSInteger date4 = 1;
        for (; date4 <=(7-position4); date4++) {
            printf("%2d ",(int)date4);
        }//输出至第一个周六，多空一格
        printf(" ");
        
        //计算2.1是周几，确定位置并输出第一行
        NSInteger intervalDays5 = [DaysInterval daysInBetweenUntilYear:currentYear month:5];
        NSInteger position5 = (intervalDays5%7+6)%7;
        //打印二月的第一行
        for (int i = 0; i<position5; i++) {
            printf("   ");
        }
        NSInteger date5 = 1;
        for (; date5 <=(7-position5); date5++) {
            printf("%2d ",(int)date5);
        }//输出至第一个周六，多空一格
        printf(" ");
        
        //计算3.1是周几，确定位置并输出第一行
        NSInteger intervalDays6 = [DaysInterval daysInBetweenUntilYear:currentYear month:6];
        NSInteger position6 = (intervalDays6%7+6)%7;
        for (int i = 0; i<position6; i++) {
            printf("   ");
        }
        //打印三月的第一行
        NSInteger date6 = 1;
        for (; date6 <=(7-position6); date6++) {
            printf("%2d ",(int)date6);
        }//输出至第一个周六，换行
        printf("\n");
        
        //输出第二行
        BOOL end4 = false;
        BOOL end5 = false;
        BOOL end6 = false;
        NSInteger count4 = 0;
        NSInteger count5 = 0;
        NSInteger count6 = 0;

        //判断是否所有的月份都打印结束了
        while(!(end4&&end5&&end6)){
            while (true) {
                //当date大于月份天数的时候，只输出空格
                if (date4>[[monthDaysArray objectAtIndex:3] intValue]) {
                    printf("   ");
                    end4 = true;
                }else{
                    //没打印完则继续打印
                    printf("%2d ",(int)date4);
                    date4++;
                }//end if0.1
                count4++;
                //每输出7个日期，则输出2个空格，然后打印二月
                if (count4 == 7) {
                    //重置count
                    count4 =0;
                    //打印五月
                    printf(" ");
                    while (true) {
                        //根据是否为闰年确定二月的天数
                        if (date5>[[monthDaysArray objectAtIndex:4] intValue]) {
                            printf("   ");
                            end5 = true;
                        }else{
                            printf("%2d ",(int)date5);
                            date5++;
                        }//end if0.2
                        count5++;
                        
                        if (count5 == 7) {
                            count5 = 0;
                            printf(" ");
                            while (true) {
                                if (date6>[[monthDaysArray objectAtIndex:5] intValue]) {
                                    end6 = true;
                                }else{
                                    printf("%2d ",(int)date6);
                                    date6++;
                                }
                                count6++;
                                if (count6 ==7) {
                                    count6 =0;
                                    printf("\n");
                                    break;//跳出while3
                                }//endif 0.3
                            }//while3
                            break;//跳出while2
                        }//endif2
                    }//while2
                    break;//跳出while1
                }//end if1
            }//while1
            
        }//while0
    }//结束打印四五六月
    
    //打印七八九月
    {
        printf("        七月                  八月                  九月\n");
        //打印星期行
        [PrintCal printWeekTitles];
        
        //计算1.1是星期几，确定位置
        NSInteger intervalDays7 = [DaysInterval daysInBetweenUntilYear:currentYear month:7];
        NSInteger position7 = (intervalDays7%7+6)%7;
        //打印一月的第一行
        for (int i = 0; i<position7; i++) {
            printf("   ");
        }
        NSInteger date7 = 1;
        for (; date7 <=(7-position7); date7++) {
            printf("%2d ",(int)date7);
        }//输出至第一个周六，多空一格
        printf(" ");
        
        //计算2.1是周几，确定位置并输出第一行
        NSInteger intervalDays8 = [DaysInterval daysInBetweenUntilYear:currentYear month:8];
        NSInteger position8 = (intervalDays8%7+6)%7;
        //打印二月的第一行
        for (int i = 0; i<position8; i++) {
            printf("   ");
        }
        NSInteger date8 = 1;
        for (; date8 <=(7-position8); date8++) {
            printf("%2d ",(int)date8);
        }//输出至第一个周六，多空一格
        printf(" ");
        
        //计算3.1是周几，确定位置并输出第一行
        NSInteger intervalDays9 = [DaysInterval daysInBetweenUntilYear:currentYear month:9];
        NSInteger position9 = (intervalDays9%7+6)%7;
        for (int i = 0; i<position9; i++) {
            printf("   ");
        }
        //打印三月的第一行
        NSInteger date9 = 1;
        for (; date9 <=(7-position9); date9++) {
            printf("%2d ",(int)date9);
        }//输出至第一个周六，换行
        printf("\n");
        
        //输出第二行
        BOOL end7 = false;
        BOOL end8 = false;
        BOOL end9 = false;
        NSInteger count7 = 0;
        NSInteger count8 = 0;
        NSInteger count9 = 0;
        
        //判断是否所有的月份都打印结束了
        while(!(end7&&end8&&end9)){
            while (true) {
                //当date大于月份天数的时候，只输出空格
                if (date7>[[monthDaysArray objectAtIndex:6] intValue]) {
                    printf("   ");
                    end7 = true;
                }else{
                    //没打印完则继续打印
                    printf("%2d ",(int)date7);
                    date7++;
                }//end if0.1
                count7++;
                //每输出7个日期，则输出2个空格，然后打印二月
                if (count7 == 7) {
                    //重置count
                    count7 =0;
                    //打印五月
                    printf(" ");
                    while (true) {
                        //根据是否为闰年确定二月的天数
                        if (date8>[[monthDaysArray objectAtIndex:7] intValue]) {
                            printf("   ");
                            end8 = true;
                        }else{
                            printf("%2d ",(int)date8);
                            date8++;
                        }//end if0.2
                        count8++;
                        
                        if (count8 == 7) {
                            count8 = 0;
                            printf(" ");
                            while (true) {
                                if (date9>[[monthDaysArray objectAtIndex:8] intValue]) {
                                    end9 = true;
                                }else{
                                    printf("%2d ",(int)date9);
                                    date9++;
                                }
                                count9++;
                                if (count9 ==7) {
                                    count9 =0;
                                    printf("\n");
                                    break;//跳出while3
                                }//endif 0.3
                            }//while3
                            break;//跳出while2
                        }//endif2
                    }//while2
                    break;//跳出while1
                }//end if1
            }//while1
            
        }//while0
    }//结束打印七八九月
    
    //打印十十一十二月
    {
        printf("        十月                 十一月                十二月\n");
        //打印星期行
        [PrintCal printWeekTitles];
        
        //计算1.1是星期几，确定位置
        NSInteger intervalDays10 = [DaysInterval daysInBetweenUntilYear:currentYear month:10];
        NSInteger position10 = (intervalDays10%7+6)%7;
        //打印一月的第一行
        for (int i = 0; i<position10; i++) {
            printf("   ");
        }
        NSInteger date10 = 1;
        for (; date10 <=(7-position10); date10++) {
            printf("%2d ",(int)date10);
        }//输出至第一个周六，多空一格
        printf(" ");
        
        //计算2.1是周几，确定位置并输出第一行
        NSInteger intervalDays11 = [DaysInterval daysInBetweenUntilYear:currentYear month:11];
        NSInteger position11 = (intervalDays11%7+6)%7;
        //打印二月的第一行
        for (int i = 0; i<position11; i++) {
            printf("   ");
        }
        NSInteger date11 = 1;
        for (; date11 <=(7-position11); date11++) {
            printf("%2d ",(int)date11);
        }//输出至第一个周六，多空一格
        printf(" ");
        
        //计算3.1是周几，确定位置并输出第一行
        NSInteger intervalDays12 = [DaysInterval daysInBetweenUntilYear:currentYear month:12];
        NSInteger position12 = (intervalDays12%7+6)%7;
        for (int i = 0; i<position12; i++) {
            printf("   ");
        }
        //打印三月的第一行
        NSInteger date12 = 1;
        for (; date12 <=(7-position12); date12++) {
            printf("%2d ",(int)date12);
        }//输出至第一个周六，换行
        printf("\n");
        
        //输出第二行
        BOOL end10 = false;
        BOOL end11 = false;
        BOOL end12 = false;
        NSInteger count10 = 0;
        NSInteger count11 = 0;
        NSInteger count12 = 0;
        
        //判断是否所有的月份都打印结束了
        while(!(end10&&end11&&end12)){
            while (true) {
                //当date大于月份天数的时候，只输出空格
                if (date10>[[monthDaysArray objectAtIndex:9] intValue]) {
                    printf("   ");
                    end10 = true;
                }else{
                    //没打印完则继续打印
                    printf("%2d ",(int)date10);
                    date10++;
                }//end if0.1
                count10++;
                //每输出10个日期，则输出2个空格，然后打印二月
                if (count10 == 7) {
                    //重置count
                    count10 =0;
                    //打印五月
                    printf(" ");
                    while (true) {
                        //根据是否为闰年确定二月的天数
                        if (date11>[[monthDaysArray objectAtIndex:10] intValue]) {
                            printf("   ");
                            end11 = true;
                        }else{
                            printf("%2d ",(int)date11);
                            date11++;
                        }//end if0.2
                        count11++;
                        
                        if (count11 == 7) {
                            count11 = 0;
                            printf(" ");
                            while (true) {
                                if (date12>[[monthDaysArray objectAtIndex:11] intValue]) {
                                    end12 = true;
                                }else{
                                    printf("%2d ",(int)date12);
                                    date12++;
                                }
                                count12++;
                                if (count12 ==7) {
                                    count12 =0;
                                    printf("\n");
                                    break;//跳出while3
                                }//endif 0.3
                            }//while3
                            break;//跳出while2
                        }//endif2
                    }//while2
                    break;//跳出while1
                }//end if1
            }//while1
            
        }//while0
    }//结束打印十十一十二月
    
}


/**
 根据传入的年份与月份打印出对应的月历
    此处需要注意，一个中文字占两格，一个英文字母占一格，所以当使用length来获取中文字符串长度（主要是获取月份长度和星期长度）的时候，需要*2
 
 需要完成的工作：
 1、标题居中显示：
  1.1 计算出月历的宽度，即显示的星期行有多少字符宽度
  1.2 将年份与月份都转换为字符串、计算出标题字符串的长度
  1.3 计算出左侧留白数量：（月历宽度-标题长度）/2
  1.4 打印标题
 2、打印星期行
 3、确定1号的位置：公元元年（1年）的第一天为周六，所以位置=（时间间隔+6）%7，星期行以周日为起点（0位置）
 4、打印月历

 @param currentYear 期待显示的年份
 @param currentMonth 期待显示的月份
 */
-(void)printYear:(NSInteger)currentYear andMonth:(NSInteger) currentMonth{
    NSInteger intervalDays =  0;
    NSMutableArray *monthDaysArray = [NSMutableArray arrayWithArray:[DaysInterval monthsInYear:currentYear]];
    //printf("当前年：%d 当前月：%d\n",currentYear,currentMonth);
//    for (int i = 0; i<currenMonth; i++) {
//        NSLog(@"%ld",(long)[[monthArray objectAtIndex:i] integerValue]);
//    }
    //验证结果：成功将12个月的信息正确存储到可变数组monthArray中
    //可以通过objectAtIndex: 以及integerValue来获取对应月份的天数
    
    //日历打印布局
    //1、标题居中显示
//    1.1 计算出月历的宽度，即显示的星期行有多少字符宽度
    NSString *weekTitle = [[NSString alloc] initWithFormat:@"%@",@"日 一 二 三 四 五 六"];
    NSInteger weekTitleLength = 20;
    
//    1.2 将年份与月份都转换为字符串、计算出标题字符串的长度
    //构造标题字符串
    NSMutableString *yearStr = [[NSMutableString alloc] initWithFormat:@"%ld",(long)currentYear];
    NSMutableString *monthStr = [[NSMutableString alloc] initWithString:[PrintCal monthDisplayWith:currentMonth]];
    
    NSMutableString *titleStr = [[NSMutableString alloc] initWithString:monthStr];
    [titleStr appendString:@" "];   //月份与年份之间有一个空格
    [titleStr appendString:yearStr]; //在标题中加入年份
    
    //计算标题长度：月字符串长度*2+1+年字符串
    NSInteger titleLength = monthStr.length*2 + 1 +yearStr.length;
    
//    1.3 计算出左侧留白数量：（月历宽度-标题长度）/2
    NSNumber *margin = [NSNumber numberWithInt:(int)(weekTitleLength - titleLength)*0.5];
    
//    1.4 打印标题
    //打印左侧空白
    for (int i = 0; i<margin.intValue; i++) {
        printf(" ");
    }
    //打印年月
    printf("%s\n",[titleStr UTF8String]);
    
//    2、打印星期行
    printf("%s\n",[weekTitle UTF8String]);
//    3、确定1号的位置
    //计算从公元元年一月一日到上一个月月末有多少天
    intervalDays = [DaysInterval daysInBetweenUntilYear:currentYear month:currentMonth];
    //NSLog(@"从公元元年一月一日到上一个月月末有 %ld 天", (long)intervalDays);
    //公元元年（1年）的第一天为周六，所以位置=（时间间隔+6）%7，星期行以周日为起点（0位置）
    //position代表的即为周几
    NSInteger position = (intervalDays%7+6)%7;
    //NSLog(@"周%d",position);
    //位置0为周日，顶格，位置一为周一，以此类推。
    //星期号占输出两个，使用%2d
    
//    4、打印月历
    //输出第一行前面的空格
    for (int i = 0; i < position; i++) {
       printf("   ");
    }
    
    NSInteger day = 1;
    for (; day <=(7-position); day++) {
        printf("%2d ",(int)day);
    }//输出至第一个周六，换行
    printf("\n");
    
    //输出其余
    NSInteger count = 0;
    for (; day<=[[monthDaysArray objectAtIndex:currentMonth-1] intValue];day++ ) {
    printf("%2d ",(int)day);
        //每行七个日期
        count ++;
        if (count%7 == 0) {
            printf("\n");
            //换行
        }
     //输出全部日期
    }
    printf("\n");
    
}


/**
 打印三个月的星期行
 */
+(void) printWeekTitles{
    NSMutableString *weeksTitles = [[NSMutableString alloc] init];
    NSString *weekTitle = [[NSString alloc] initWithFormat:@"%@",@"日 一 二 三 四 五 六  "];
    [weeksTitles appendString:weekTitle];
    [weeksTitles appendString:weekTitle];
    [weeksTitles appendString:weekTitle];
    printf("%s\n",[weeksTitles UTF8String]);
    
}

@end
