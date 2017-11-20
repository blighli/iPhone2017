//
//  mycal.h
//  Cal
//
//  Created by 黄建永 on 2017/11/18.
//  Copyright © 2017年 黄建永. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mycal : NSObject

int isLeapYear(int year);
void printMonthTitle(int year,int month);
void printMonth(int year,int month);
void printYear(int year);


@end
