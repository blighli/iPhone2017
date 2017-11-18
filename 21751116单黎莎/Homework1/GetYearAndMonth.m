//
//  GetYearAndMonth.m
//  command-cal
//
//  Created by Edith.S on 2017/10/6.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import "GetYearAndMonth.h"

@implementation GetYearAndMonth

-(void) getYearAndMonth{
    //创建一个新的date类型的变量，并将其初始化为当前的日期与时间
    NSDate *date = [NSDate date];
    //取得用户的当前逻辑日历
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    //确定需要获取的日期的单元，即：年月日
    //参考资料：https://my.oschina.net/CarlHuang/blog/140007
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *dateComponents = [cal components:unitFlags fromDate:date];
    
    self.currentYear = [dateComponents year];
    //printf("当前年：%d", self.currentYear);
    self.currentMonth = [dateComponents month];
    //printf("当前月：%d", self.currentMonth);
    
   // NSLog(@"%ld,%ld",(long)self.currentYear, (long)self.currentMonth);
}

@end
