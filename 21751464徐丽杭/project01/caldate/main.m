//
//  main.m
//  caldate
//
//  Created by lihang  Xu on 2017/10/10.
//  Copyright © 2017年 lihang  Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PrintDate.h"
#import "GetDate.h"

int main(int argc, char *argv[]) {
    @autoreleasepool {
        
        int year,month;
        PrintDate *printMonthObj = [[PrintDate alloc] init];
        PrintDate *printYearObj = [[PrintDate alloc] init];
        
        if(argc == 2){//1.显示当前月份，cal命令
            GetDate *yearAndMonthNow = [[GetDate alloc] init];
            [yearAndMonthNow getToday];
            year = yearAndMonthNow.yearNow;
            month = yearAndMonthNow.monthNow;
        
            [printMonthObj printMonth:year andMonth:month];
        }
        else if(argc == 3){//2. 显示特定年份 cal 2018
            //转换成oc风格字符串
            NSString *inputYear=[NSString stringWithUTF8String:argv[2]];
            //年份是int格式，且不能为负
            if([inputYear intValue]>0)
                [printYearObj printYear:[inputYear intValue]];
        }
        else{//3.显示特定的年份和月份 cal 7 2017
            NSString *inputMonth=[NSString stringWithUTF8String:argv[2]];
            NSString *inputYear=[NSString stringWithUTF8String:argv[3]];
            if([inputYear intValue]>0&&[inputMonth intValue]>0&&[inputMonth intValue]<13)
                [printMonthObj printMonth:[inputYear intValue] andMonth:[inputMonth intValue]];;
        }
    }
    
    return 0;
}
