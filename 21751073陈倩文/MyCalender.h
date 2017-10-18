//
//  MyCalender.h
//  cal_cqw
//
//  Created by 陈倩文 on 2017/10/9.
//  Copyright © 2017年 陈倩文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCalender : NSObject
{
    NSArray *monName;
    NSArray *weekName;
    NSArray *leapYear;
    NSArray *nleapYear;
    NSArray *AllYears;
}
- (id) init;
- (void) printMonth:(int)month AndYear:(int)year;
- (void) printYear:(int)year;
@end
