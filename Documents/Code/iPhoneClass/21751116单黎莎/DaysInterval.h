//
//  DaysInterval.h
//  command-cal
//
//  Created by Edith.S on 2017/10/6.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DaysInterval : NSObject
//判断输入的年份是否为闰年
+(BOOL) isLeapYear:(NSInteger) year;
//计算从公元元年到上一年共有多少天
+(NSInteger) daysInBetweenUntilLastYear:(NSInteger) currentYear;
//计算从元年到上一个月有多少天
+(NSInteger) daysInBetweenUntilYear:(NSInteger) currentYear month:(NSInteger) currentMonth;
+(NSMutableArray*) monthsInYear:(NSInteger) year;
@end
