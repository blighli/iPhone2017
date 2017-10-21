//
//  GetYearAndMonth.h
//  command-cal
//
//  Created by Edith.S on 2017/10/6.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetYearAndMonth : NSObject

@property(nonatomic) NSInteger currentYear;
@property(nonatomic) NSInteger currentMonth;

//获取当前的年份和月份
-(void) getYearAndMonth;

@end
