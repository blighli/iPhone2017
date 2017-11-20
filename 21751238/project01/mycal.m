//
//  mycal.m
//  Cal
//
//  Created by 黄建永 on 2017/11/18.
//  Copyright © 2017年 黄建永. All rights reserved.
//

#import "mycal.h"

@implementation mycal


//判断是否是闰年
int isLeapYear(int year)
{
    if(year%4 == 0 && (year%100)!=0 || year%400==0)
        return 1;
    else
        return 0;
}

//输出月份和年份标题
void printMonthTitle(int year,int month)
{
    printf("\n    ");
    switch (month)
    {
        case 1: printf("一月 %d",year);break;
        case 2: printf("二月 %d",year);break;
        case 3: printf("三月 %d",year);break;
        case 4: printf("四月 %d",year);break;
        case 5: printf("五月 %d",year);break;
        case 6: printf("六月 %d",year);break;
        case 7: printf("七月 %d",year);break;
        case 8: printf("八月 %d",year);break;
        case 9: printf("九月 %d",year);break;
        case 10: printf("十月 %d",year);break;
        case 11: printf("十一月 %d",year);break;
        case 12: printf("十二月 %d",year);break;
        default: break;
    }
    printf("\n");
}

//输出当前年月的日历
void printMonth(int year,int month)
{
    //求取打印日历的参数信息
    int Month[13] = {0,31,28,31,30,31,30,31,31,30,31,30,31};  //数组初始化用{ , , , };
    if(isLeapYear(year))
        Month[2] = 29;                                    //判断当前年份是否为闰年，并修改二月份的天数
    int count = (year-1)/4 - (year-1)/100 + (year-1)/400;  //计算1年1月1日与year年1月一日之间的闰年个数count
    int day1 = (year-1)*365 + count;            //计算1年1月1日与year年1月1日之间的天数 day1
    
    int day2 = 0;
    for(int i=1;i<month;i++)                  // 错误：for(int i=1;i<Month[month];i++)
        day2+=Month[i];                       //计算year年1月1日到year年month月1日 之间的天数day2
    
    //int weekday1 = (day1 + 1)%7;              //计算year年1月1日是星期几：weekday1
    int weekday2 = (day1 + day2 +1)%7;        //计算year年month月1日是星期几
                                              //注意⚠️：weekday2 = 0时为周日
    
    //打印year年month月的日历
    printMonthTitle(year,month);               //输出年份和月份标题
    printf("日 一 二 三 四 五 六\n");          //输出星期标题
    
    for(int i = 1; i <= weekday2; i++)
        printf("   ");
    for(int i = 1; i <= Month[month]; i++)
    {
        printf("%2d ",i);
        if((i+weekday2)%7 == 0)
            printf("\n");
    }
    printf("\n");
}

//输出当前年份的日历
void printYear(int year)
{
    int Month[13] = {0,31,28,31,30,31,30,31,31,30,31,30,31};  //数组初始化用{ , , , };
    Month[2] = isLeapYear(year) ? 29 : 28;                     //判断当前年份是否为闰年，并修改二月份的天数
    int count = (year-1)/4 - (year-1)/100 + (year-1)/400;  //计算1年1月1日与year年1月一日之间的闰年个数count
    int Day = (year-1)*365 + count;            //计算1年1月1日与year年1月1日之间的天数 Day
    
    int day[13] = {0};        //定义day数组，用来存放该年各月份第一天距1年1月1日之间天数
    int weekday[13] = {0};    //定义该年各月份第一天是星期几
    int i;
    for(i=1;i<=12;i++)   //计算day数组数值
    {
        day[i] = day[i-1] + Month[i-1];       //⚠️：day[i] = day[i] + Month[i-1];
        weekday[i] = (Day + day[i] + 1)%7;    //计算该年各月份第一天是星期几，其中weekday = 0 时为周日
        //printf("%d",day[i]);
        //printf("%d",weekday[i]);
    }
    
    int add[13];
    for(i=1;i<=12;i++)
        add[i] =1;       //add[]数组，用来记录每次打印到每个月的几号
    /*开始打印年日历*/
    printf("\t\t\t     %d \n\n",year);
    printf("\t一月\t\t      二月\t\t    三月\n");
//打印一二三月
    printf("日 一 二 三 四 五 六 ");          //输出星期标题
    printf(" 日 一 二 三 四 五 六 ");
    printf(" 日 一 二 三 四 五 六 ");
    printf("\n");  
    //打印一月份第一行
    for(i = 1; i <= weekday[1]; i++)
        printf("   ");
    for(i = 1; i <= Month[1]; i++)
    {
        printf("%2d ",i);
        if((i+weekday[1])%7 == 0)
            break;
    }
    printf(" ");
    add[1] = i+1;     //打印一月份第二行时从此处 开始打印
    
    //打印二月份第一行
    for(i = 1; i <= weekday[2]; i++)
        printf("   ");
    for(i = 1; i <= Month[2]; i++)
    {
        printf("%2d ",i);
        if((i+weekday[2])%7 == 0)
            break;
    }
    printf(" ");
    add[2] = i+1;     //打印二月份第二行时从此处开始打印
    
    //打印三月份第一行
    for(i = 1; i <= weekday[3]; i++)
        printf("   ");
    for(i = 1; i <= Month[3]; i++)
    {
        printf("%2d ",i);
        if((i+weekday[3])%7 == 0)
            break;
    }
    printf(" ");
    add[3] = i+1;     //打印三月份第二行时从此处开始打印
    
//开打印第2～6行
    int line = 2;
    int flag1,flag2,flag3;
    flag1 = flag2 = flag3 =0;
    int blank;   //定义第5行结束后的空格数目
    
    for(line = 2;line <= 6; line++)
    {
        printf("\n");
      //一月份
        for(i = add[1]; i <= Month[1]; i++)
        {
            printf("%2d ",i);
            if((i+weekday[1])%7 == 0)
                break;
        }
        add[1] = i+1;     //打印一月份第三行时从此处开始打印
        
        if(flag1 == 1)
        {
            for(i=1;i<=7;i++)
                printf("   ");
        }
        
        else if((add[1]>Month[1])&&(flag1 == 0))
        {
            blank = (7-(weekday[1] + Month[1])%7)%7;
            for(i = 1;i <= blank; i++)
                printf("   ");
            flag1 = 1;
        }
        printf(" ");
        
        
    //二月份
        for(i = add[2]; i <= Month[2]; i++)
        {
            printf("%2d ",i);
            if((i+weekday[2])%7 == 0)
                break;
        }
        add[2] = i+1;     //打印二月份第三行时从此处开始打印
        
        if(flag2 == 1)
        {
            for(i=1;i<=7;i++)
                printf("   ");
        }
        
        else if((add[2]>Month[2])&&(flag2 == 0))
        {
            blank = (7-(weekday[2] + Month[2])%7)%7;
            for(i = 1;i <= blank; i++)
                printf("   ");
            flag2 = 1;
        }
        printf(" ");
        
        
    //打印三月份
        for(i = add[3]; i <= Month[3]; i++)
        {
            printf("%2d ",i);
            if((i+weekday[3])%7 == 0)
                break;
        }
        add[3] = i+1;     //打印三月份第三行时从此处开始打印
        
        if(flag3 == 1)
        {
            for(i=1;i<=7;i++)
                printf("   ");
        }
        
        else if((add[3]>Month[3])&&(flag3 == 0))
        {
            blank = (7-(weekday[3] + Month[3])%7)%7;
            for(i = 1;i <= blank; i++)
                printf("   ");
            flag3 = 1;
        }
        printf(" ");
    }
    
//打印四五六月
    printf("\n\t四月\t\t      五月\t\t    六月\n");
    printf("日 一 二 三 四 五 六 ");          //输出星期标题
    printf(" 日 一 二 三 四 五 六 ");
    printf(" 日 一 二 三 四 五 六 ");
    printf("\n");  
    //打印四月份第一行
    for(i = 1; i <= weekday[4]; i++)
        printf("   ");
    for(i = 1; i <= Month[4]; i++)
    {
        printf("%2d ",i);
        if((i+weekday[4])%7 == 0)
            break;
    }
    printf(" ");
    add[4] = i+1;     //打印四月份第二行时从此处开始打印
    
    //打印五月份第一行
    for(i = 1; i <= weekday[5]; i++)
        printf("   ");
    for(i = 1; i <= Month[5]; i++)
    {
        printf("%2d ",i);
        if((i+weekday[5])%7 == 0)
            break;
    }
    printf(" ");
    add[5] = i+1;     //打印五月份第二行时从此处开始打印
    
    //打印六月份第一行
    for(i = 1; i <= weekday[6]; i++)
        printf("   ");
    for(i = 1; i <= Month[6]; i++)
    {
        printf("%2d ",i);
        if((i+weekday[6])%7 == 0)
            break;
    }
    printf(" ");
    add[6] = i+1;     //打印六月份第二行时从此处开始打印
    
    //开打印第2～6行
    flag1 = flag2 = flag3 =0;
    for(line = 2;line <= 6; line++)
    {
        printf("\n");
        //四月份
        for(i = add[4]; i <= Month[4]; i++)
        {
            printf("%2d ",i);
            if((i+weekday[4])%7 == 0)
                break;
        }
        add[4] = i+1;
        
        if(flag1 == 1)
        {
            for(i=1;i<=7;i++)
                printf("   ");
        }
        
        else if((add[4]>Month[4])&&(flag1 == 0))
        {
            blank = (7-(weekday[4] + Month[4])%7)%7;
            for(i = 1;i <= blank; i++)
                printf("   ");
            flag1 = 1;
        }
        printf(" ");
        
        //五月份
        for(i = add[5]; i <= Month[5]; i++)
        {
            printf("%2d ",i);
            if((i+weekday[5])%7 == 0)
                break;
        }
        add[5] = i+1;
        
        if(flag2 == 1)
        {
            for(i=1;i<=7;i++)
                printf("   ");
        }
        
        else if((add[5]>Month[5])&&(flag2 == 0))
        {
            blank = (7-(weekday[5] + Month[5])%7)%7;
            for(i = 1;i <= blank; i++)
                printf("   ");
            flag2 = 1;
        }
        printf(" ");
        
        
        //打印六月份
        for(i = add[6]; i <= Month[6]; i++)
        {
            printf("%2d ",i);
            if((i+weekday[6])%7 == 0)
                break;
        }
        
        add[6] = i+1;
    
        if(flag3 == 1)
        {
            for(i=1;i<=7;i++)
                printf("   ");
        }
        
        else if((add[6]>Month[6])&&(flag3 == 0))
        {
            blank = (7-(weekday[6] + Month[6])%7)%7;
            for(i = 1;i <= blank; i++)
                printf("   ");
            flag3 = 1;
        }
        printf(" ");
    }
    
//打印七八九月
    printf("\n\t七月\t\t      八月\t\t    九月\n");
    printf("日 一 二 三 四 五 六 ");          //输出星期标题
    printf(" 日 一 二 三 四 五 六 ");
    printf(" 日 一 二 三 四 五 六 ");
    printf("\n");
    //打印七月份第一行
    for(i = 1; i <= weekday[7]; i++)
        printf("   ");
    for(i = 1; i <= Month[7]; i++)
    {
        printf("%2d ",i);
        if((i+weekday[7])%7 == 0)
            break;
    }
    printf(" ");
    add[7] = i+1;
    
    //打印八月份第一行
    for(i = 1; i <= weekday[8]; i++)
        printf("   ");
    for(i = 1; i <= Month[8]; i++)
    {
        printf("%2d ",i);
        if((i+weekday[8])%7 == 0)
            break;
    }
    printf(" ");
    add[8] = i+1;
    
    //打印九月份第一行
    for(i = 1; i <= weekday[9]; i++)
        printf("   ");
    for(i = 1; i <= Month[9]; i++)
    {
        printf("%2d ",i);
        if((i+weekday[9])%7 == 0)
            break;
    }
    printf(" ");
    add[9] = i+1;
    
    //开打印第2～6行
    flag1 = flag2 = flag3 = 0;
    for(line = 2;line <= 6; line++)
    {
        printf("\n");
        //七月份
        for(i = add[7]; i <= Month[7]; i++)
        {
            printf("%2d ",i);
            if((i+weekday[7])%7 == 0)
                break;
        }
        add[7] = i+1;     //打印一月份第三行时从此处开始打印
        
        if(flag1 == 1)
        {
            for(i=1;i<=7;i++)
                printf("   ");
        }
        
        else if((add[7]>Month[7])&&(flag1 == 0))
        {
            blank = (7-(weekday[7] + Month[7])%7)%7;
            for(i = 1;i <= blank; i++)
                printf("   ");
            flag1 = 1;
        }
        printf(" ");
        
        //八月份
        for(i = add[8]; i <= Month[8]; i++)
        {
            printf("%2d ",i);
            if((i+weekday[8])%7 == 0)
                break;
        }
        add[8] = i+1;
        
        if(flag2 == 1)
        {
            for(i=1;i<=7;i++)
                printf("   ");
        }
        
        else if((add[8]>Month[8])&&(flag2 == 0))
        {
            blank = (7-(weekday[8] + Month[8])%7)%7;
            for(i = 1;i <= blank; i++)
                printf("   ");
            flag2 = 1;
        }
        printf(" ");
        
        //打印九月份
        for(i = add[9]; i <= Month[9]; i++)
        {
            printf("%2d ",i);
            if((i+weekday[9])%7 == 0)
                break;
        }
        add[9] = i+1;
        
        if(flag3 == 1)
        {
            for(i=1;i<=7;i++)
                printf("   ");
        }
        
        else if((add[9]>Month[9])&&(flag3 == 0))
        {
            blank = (7-(weekday[9] + Month[9])%7)%7;
            for(i = 1;i <= blank; i++)
                printf("   ");
            flag3 = 1;
        }
        printf(" ");
    }
    
    
    //打印十、十一、十二月
    printf("\n\t十月\t\t     十一月\t\t   十二月\n");
    printf("日 一 二 三 四 五 六 ");          //输出星期标题
    printf(" 日 一 二 三 四 五 六 ");
    printf(" 日 一 二 三 四 五 六 ");
    printf("\n");
    //打印十月份第一行
    for(i = 1; i <= weekday[10]; i++)
        printf("   ");
    for(i = 1; i <= Month[10]; i++)
    {
        printf("%2d ",i);
        if((i+weekday[10])%7 == 0)
            break;
    }
    printf(" ");
    add[10] = i+1;
    
    //打印十一月份第一行
    for(i = 1; i <= weekday[11]; i++)
        printf("   ");
    for(i = 1; i <= Month[11]; i++)
    {
        printf("%2d ",i);
        if((i+weekday[11])%7 == 0)
            break;
    }
    printf(" ");
    add[11] = i+1;
    
    //打印十二月份第一行
    for(i = 1; i <= weekday[12]; i++)
        printf("   ");
    for(i = 1; i <= Month[12]; i++)
    {
        printf("%2d ",i);
        if((i+weekday[12])%7 == 0)
            break;
    }
    printf(" ");
    add[12] = i+1;
    
    //开打印第2～6行
    flag1 = flag2 = flag3 = 0;
    for(line = 2;line <= 6; line++)
    {
        printf("\n");
        //十月份
        for(i = add[10]; i <= Month[10]; i++)
        {
            printf("%2d ",i);
            if((i+weekday[10])%7 == 0)
                break;
        }
        add[10] = i+1;
        
        if(flag1 == 1)
        {
            for(i=1;i<=7;i++)
                printf("   ");
        }
        
        else if((add[10]>Month[10])&&(flag1 == 0))
        {
            blank = (7-(weekday[10] + Month[10])%7)%7;
            for(i = 1;i <= blank; i++)
                printf("   ");
            flag1 = 1;
        }
        printf(" ");
        
        //十一月份
        for(i = add[11]; i <= Month[11]; i++)
        {
            printf("%2d ",i);
            if((i+weekday[11])%7 == 0)
                break;
        }
        add[11] = i+1;
        
        if(flag2 == 1)
        {
            for(i=1;i<=7;i++)
                printf("   ");
        }
        
        else if((add[11]>Month[11])&&(flag2 == 0))
        {
            blank = (7-(weekday[11] + Month[11])%7)%7;
            for(i = 1;i <= blank; i++)
                printf("   ");
            flag2 = 1;
        }
        printf(" ");
        
        //打印十二月份
        for(i = add[12]; i <= Month[12]; i++)
        {
            printf("%2d ",i);
            if((i+weekday[12])%7 == 0)
                break;
        }
        printf(" ");
        add[12] = i+1;
        
        
        if(flag3 == 1)
        {
            for(i=1;i<=7;i++)
                printf("   ");
        }
        
        else if((add[12]>Month[12])&&(flag3 == 0))
        {
            blank = (7-(weekday[12] + Month[12])%7)%7;
            for(i = 1;i <= blank; i++)
                printf("   ");
            flag3 = 1;
        }
        printf(" ");
    }
    printf("\n");
    
}


@end
