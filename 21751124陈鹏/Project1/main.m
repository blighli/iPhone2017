//
//  main.m
//  Cal
//
//  Created by Mr.Right on 2017/10/2.
//  Copyright © 2017年 Mr.Right. All rights reserved.
//
//#ifdef DEBUG
//#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#else
//#define NSLog(...)
//#endif
#import <Foundation/Foundation.h>
#import "Calendar.h"
#import "Year.h"

#include <stdio.h>
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        if(argc == 1){
            Year *year = [[Year alloc] init];
            Calendar *cal = [[Calendar alloc] init];
            [cal printCalendarWithYearAndAMonth:year];
        }else if(argc == 2){
            int yearNum = atoi(argv[1]);
            if([Calendar checkLArgLegalityWithYear:yearNum] == YES){
                Year *year = [[Year alloc] initWithYear:yearNum];
                Calendar *cal = [[Calendar alloc] init];
                [cal printCalendarWithYearAndAllMonth:year];
            }
        }else if(argc == 3){
            int monthNum = atoi(argv[1]);
            int yearNum = atoi(argv[2]);
            if([Calendar checkLArgLegalityWithYear:yearNum AndMonth:monthNum] == YES){
                Year *year = [[Year alloc] initWithYear:yearNum AndMonth:monthNum];
                Calendar *cal = [[Calendar alloc] init];
                [cal printCalendarWithYearAndAMonth:year];
            }
        }else{
            printf("usage: cal [-jy] [[month] year]\n"
                   "cal [-j] [-m month] [year]\n");
        }
        
    }
    
    return 0;
}
