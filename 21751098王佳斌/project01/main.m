//
//  main.m
//  cal_w
//
//  Created by 王佳斌 on 2017/10/7.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mycal.h"

int main(int argc,const char* argv[]){
    mycal *cal = [[mycal alloc] init];
    if(argc == 1){
    //没有参数输出当前月份
        NSDate * currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps;
        comps =[calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay)
                           fromDate:currentDate];
        int year = (int)[comps year];
        int month = (int)[comps month];
        [cal PrtbyMonth:month Andyear:year];
    }
    else if(argc == 2){
        //用atoi函数将argc数组转为整数
        int year = atoi(argv[1]);
        if( 1 <= year && year<= 9999)
            [cal PrtbyYear:year];//按年输出
        else
            printf("输入年份必须在1...9999范围内");
    }
    else if(argc == 3){
        int month = atoi(argv[1]);
        int year = atoi(argv[2]);
        if((1 <= year && year<= 9999)&&(1 <= month && month <= 12))
            [cal PrtbyMonth:month Andyear:year];
        else
            printf("输入年份必须在1...9999范围内，且输入月份必须在1...12内");
    }
    else{
        printf("错误的输入格式");
    }

    
    return 0;
}
