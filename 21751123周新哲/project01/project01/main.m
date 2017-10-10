//
//  main.m
//  project01
//
//  Created by 周新哲 on 2017/10/10.
//  Copyright © 2017年 周新哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cal.h"

/**
 根据不同的参数，输出对应的结果
 @param argc 参数个数
 @param argv 参数值。当参数个数为2时，argv[1]表示年份；当参数个数为3时，argv[1]表示月份，argv[2]表示年份ß
 */
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        switch (argc) {
            case 1: {
                NSString *calString = [Cal showCalByToday];
                NSLog(@"%@\n",calString);
                break;
            }
            case 2:{
                int year = atoi(argv[1]);
                if (year<1 || year>9999) {
                    NSLog(@"cal: year %d not in range 1..9999", year);
                    return 0;
                } else {
                    NSString *calString = [Cal showCalByYear:year];
                    NSLog(@"%@\n",calString);
                }
                break;
            }
            case 3:{
                int month = atoi(argv[1]);
                int year = atoi(argv[2]);
                if (month<1 || month>12) {
                    NSLog(@"cal: %d is neither a month number (1..12) nor a name", month);
                } else if (year<1 || year>9999) {
                    NSLog(@"cal: year %d not in range 1..9999", year);
                } else {
                    NSString *calString = [Cal showCalByMonth:month andYear:year];
                    NSLog(@"%@\n",calString);
                }
                break;
            }
            default:
                NSLog(@"usage: cal [[month] year]");
                break;
        }
    }
    return 0;
}
