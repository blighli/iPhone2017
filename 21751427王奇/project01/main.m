//
//  main.m
//  Project01
//
//  Created by 王奇 on 2017/10/10.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "myCal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        myCal *cal = [[myCal alloc] init];
        
        // 输出当前月的日历
        if (argc == 1) {

            // 获取代表公历的NSCalendar对象
            NSCalendar *gregorian = [[NSCalendar alloc]
                                     initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            // 获取当前日期
            NSDate* dt = [NSDate date];
            // 定义一个时间字段的旗标，指定将会获取指定年、月的信息
            unsigned unitFlags = NSCalendarUnitYear |
            NSCalendarUnitMonth | NSCalendarUnitWeekday;
            // 获取不同时间字段的信息
            NSDateComponents* comp = [gregorian components: unitFlags
                                                  fromDate:dt];
            // 获取各时间字段的数值
//            NSLog(@"现在是%ld年" , comp.year);
//            NSLog(@"现在是%ld月 " , comp.month);
//            NSLog(@"现在是星期%ld" , comp.weekday);
            
            [cal setYear:comp.year];
            [cal printMonth:comp.month];
            
        // 输出特定年的日历
        } else if (argc == 2) {
            
            [cal setYear:atoi(argv[1])];
            [cal printYear];
        
        // 输出特定年月的日历
        } else if (argc == 3) {
            
            [cal setYear:atoi(argv[2])];
            [cal printMonth: atoi(argv[1])];
            
        } else {
            NSLog(@"参数错误");
        }
    }
    return 0;
}
