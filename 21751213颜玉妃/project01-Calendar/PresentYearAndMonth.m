//
//  PresentYearAndMonth.m
//  Project01
//
//  Created by YanYufei on 2017/9/29.
//  Copyright © 2017年 YanYufei. All rights reserved.
//

//获取当前的年份和月份
#import "PresentYearAndMonth.h"

@implementation PresentYearAndMonth

- (void) yearAndMonth{
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    //这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    int uintFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    //把要从date中获取的uintFlags标示的日期元素存放在NSDateComponents类型的d中
    NSDateComponents *d = [cal components:uintFlags fromDate:date];
    _presentYear = (int)[d year];
    _presentMonth = (int)[d month];
    
}
@end
