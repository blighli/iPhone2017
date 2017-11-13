//
//  main.m
//  cal_cqw
//
//  Created by 陈倩文 on 2017/10/7.
//  Copyright © 2017年 陈倩文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCalender.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int year = 0;
        int month = 0;
        MyCalender *myCalenderYearObj = [[MyCalender alloc] init];
        MyCalender *myCalenderMonthYearObj = [[MyCalender alloc] init];
        
        switch (argc) {
            //cal
            case 1:{
                NSDate *date = [NSDate date];
                NSCalendar *cal = [NSCalendar currentCalendar];
                unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
                NSDateComponents *comps = [cal components:unitFlags fromDate:date];
                //get current month and year
                year = (int)[comps year];
                month = (int)[comps month];
                [myCalenderMonthYearObj printMonth:month AndYear:year];
                break;
            }
            //cal 2017
            case 2:{
                NSString *argv1 = [NSString stringWithUTF8String:argv[1]];
                year = [argv1 intValue];
                if (year>9999||year<0){
                    printf("Input year %d is not in range(0,9999).\n",year);
                }
                else {
                    [myCalenderYearObj printYear:year];
                }
                break;
            }
            //cal 10 2017
            case 3:{
                NSString *argv1 = [NSString stringWithUTF8String:argv[1]];
                NSString *argv2 = [NSString stringWithUTF8String:argv[2]];
                month = [argv1 intValue];
                year = [argv2 intValue];
                if (year>9999||year<0){
                    printf("Input year %d is not in range(0,9999).\n",year);
                }else if (month>12||month<1){
                    printf("Input month %d is not in range(1,12).\n",month);
                }else{
                    [myCalenderMonthYearObj printMonth:month AndYear:year];
                }
                break;
            }
            default:{
                NSLog(@"Tips: your input is illegal");
                break;
            }
        }
        
    }
    return 0;
}
