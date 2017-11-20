//
//  main.m
//  Cal
//
//  Created by 黄建永 on 2017/11/18.
//  Copyright © 2017年 黄建永. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mycal.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int year,yearNow;
        int month,monthNow;
        
        if (argc == 2) {//执行“cal”命令,此时argc = 2;argv[1] = cal
            
            //计算当前年月；
            NSDate *now = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |
                 NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
            
            yearNow = [dateComponent year];
            monthNow = [dateComponent month];
            //int day = [dateComponent day];
            //printf("%d,%d",yearNow,monthNow);
            
            //打印当前年月日历
            printMonth(yearNow,monthNow);
        }
        
        else if(argc == 3){//执行“cal 2017”类命令，这个argv[2]表示年份；
            int year = atoi(argv[2]);
            if(year<1||year>9999)
                printf("\n请输入年份：0~9999\n");
            else
                printYear(year);
        }
        
        else if(argc == 4){//执行“cal 11 2017”类命令；argv[2]表示月份，argv[3]表示年份
            
            //用atoi()函数将字符串转换成整型
            month = atoi(argv[2]);
            year = atoi(argv[3]);

            //打印要求打印的 年月日历
            if(year<1||year>9999 ||month<1||month>12)
                printf("\n请输入年份：0~9999，月份：1～12\n");
            else
                printMonth(year,month);
            }
        
        else{
            printf("请输入正确的格式！");
        }
    }
    return 0;
}
