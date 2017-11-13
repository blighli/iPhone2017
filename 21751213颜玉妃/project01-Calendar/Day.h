//
//  Day.h
//  Project01
//
//  Created by YanYufei on 2017/10/9.
//  Copyright © 2017年 YanYufei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Day : NSObject
//类方法即可

//判断是否为闰年
+ (BOOL)isLeapYear:(int)year;

//计算从公元0年到输入的上一年总共有多少天
+ (int)daysOfUntilLastYear:(int)year;

//计算公元0年到输入上个月共有多少天
+ (int)daysOfUntilLastMonth:(int)year yue:(int)yue;

@end
