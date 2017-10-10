//
//  main.m
//  command-cal
//
//  Created by Edith.S on 2017/10/6.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetYearAndMonth.h"
#import "PrintCal.h"
#import "InputCorrect.h"
#import "DaysInterval.h"

int main(int argc, const char * argv[]) {
    //int argc, char *argv[] 表示程序运行的环境变量。
    //int argc表示环境变量的个数，char *argv[] 为存储具体环境变量的字符串指针数组。
    //用户的输入从argv[1]开始
    @autoreleasepool {
        // insert code here...
        NSInteger year,month;
        PrintCal *printMonth = [[PrintCal alloc]init];
        PrintCal *printYear = [[PrintCal alloc]init];
        
        //判断获取的参数有几个，根据输入的个数来确定输出的是当前月还是指定年或者指定月
        if (argc == 2) {
            //只获取一个输入，argv[0]存储的是地址 argv[1]存储的是输入— —cal，argv[2]=nil
            //需要输出的是当前月
            //获取当前年月
            GetYearAndMonth *currentYearAndMonth = [[GetYearAndMonth alloc] init];
            [currentYearAndMonth getYearAndMonth];
            year = currentYearAndMonth.currentYear;
            month = currentYearAndMonth.currentMonth;
            //printf("当前年：%d 当前月：%d\n",year,month);
            [printMonth printYear:year andMonth:month];
        }//输入cal打印当前年当前月— —验证通过
        else if(argc == 3){ //  输入变量为cal 年份
            NSString *yearStr = [NSString stringWithUTF8String:argv[2]];
            InputCorrect *isNum = [[InputCorrect alloc] init];
            if([isNum isNumber:yearStr]){
                if(yearStr.intValue <= 9999){
                [printYear printYear:[yearStr intValue]];
                }
                else{
                    printf("cal: year %d not in range 1..9999\n",yearStr.intValue);
                }
            }else{
                printf("%s is not a cal instruction\n",yearStr);
            }
        }
        else if (argc ==4){//输入为cal 月份 年份
            NSString *monthStr = [NSString stringWithUTF8String:argv[2]];
            NSString *yearStr = [NSString stringWithUTF8String:argv[3]];
            InputCorrect *isNum = [[InputCorrect alloc] init];
            BOOL isMonth = [isNum isNumber:monthStr];
            BOOL isYear = [isNum isNumber:yearStr];
            if (isMonth && isYear) {
                if(monthStr.intValue <= 12){
                    if (yearStr.intValue <= 9999) {
                        [printYear printYear:[yearStr intValue] andMonth:[monthStr intValue]];
                    }else{
                        printf("cal: year %d not in range 1..9999\n",yearStr.intValue);
                    }//判断年份在1~9999内
                }
                else{
                    printf("cal: month %d not in range 1..12\n",monthStr.intValue);
                }//判断月份在1~12内

            }else{
                printf("cal %s %s is not a cal instruction\n",monthStr,yearStr);
            }//判断输入都合法
            
        }
        else{
            printf("THIS is not a cal instruction\n");
        }
        

    }//@autoreleasepool结束
    return 0;
}
