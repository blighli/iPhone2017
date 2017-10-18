//
//  DateCalculator.h
//  cal_cqw
//
//  Created by 陈倩文 on 2017/10/9.
//  Copyright © 2017年 陈倩文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateCalculator : NSObject
+ (BOOL) isLeapYear:(int)year;

//公元0年到上一年共多少天
+ (int)daysOfUntilLastYear:(int)year;

//公元0年到上一月共计天数
+ (int)daysOfUntilLastMonth:(int)month AndYear:(int)year;

@end
