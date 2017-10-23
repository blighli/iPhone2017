//
//  main.m
//  Project01
//
//  Created by YanYufei on 2017/9/27.
//  Copyright © 2017年 YanYufei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrintYearAndMonth.h"
#import "Day.h"
#import "PresentYearAndMonth.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int year, yue;
        PrintYearAndMonth *printYearObj = [[PrintYearAndMonth alloc] init];
        PrintYearAndMonth *printMonthObj = [[PrintYearAndMonth alloc] init];
    
        
        if (argc == 1) {
            //执行“cal”命令；
            //执行该命令时argc = 2;argv[1] = cal;argv[2] = null
            
            //计算当前年月；
            PresentYearAndMonth *yearAndMonthNow = [[PresentYearAndMonth alloc] init];
            [yearAndMonthNow yearAndMonth];
            
            year = yearAndMonthNow.presentYear;
            yue = yearAndMonthNow.presentMonth;
            
            [printMonthObj printMonth:year yue:yue];
//            NSLog(@"1111");
        }else if(argc == 2){
            //执行“cal 2014”命令；
            //这个argv2表示年份；
            NSString *argv2 = [NSString stringWithUTF8String:argv[1]];
            
            [printYearObj printYear:[argv2 intValue]];
//            NSLog(@"2222");
        }else if(argc == 3){
            //执行“cal 10 2014”命令；
            //这一步是为了把传递进来的char * argv参数转化为 OC中的NSString；
            NSString *argv2 = [NSString stringWithUTF8String:argv[1]];
            NSString *argv3 = [NSString stringWithUTF8String:argv[2]];
            [printMonthObj printMonth:[argv3 intValue] yue:[argv2 intValue]];
            //NSLog(@"44444");
        }
    }
//    NSLog(@"hahahah");
    return 0;
}
