//
//  Month.m
//  Cal
//
//  Created by Mr.Right on 2017/10/4.
//  Copyright © 2017年 Mr.Right. All rights reserved.
//

#import "Month.h"
#import "Calendar.h"

@implementation Month
@synthesize m_nMonthNum, m_nDayLength, m_nWeekdayOfFirstDay;
- (id) initWithYear: (int) year AndMonth: (int) month{
    self = [super init];
    if(self){
        self->m_nMonthNum = month;
        NSString *str = [NSString stringWithFormat:@"%d-%d-01", year, self->m_nMonthNum];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *date=[dateFormatter dateFromString:str];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear fromDate: date];
        self->m_nWeekdayOfFirstDay = (int)components.weekday;
        
        NSRange dayRange = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
        self->m_nDayLength = (unsigned int)dayRange.length;
        
    }
    
    return self;
}

- (void) printMonthTitle{
    for(int i = 1; i <= 7; ++i){
        if(i == 1){
            printf("%2s ", "日");
        }else{
            NSString *monthNum = [Calendar exchangeArabicToChinese:(i - 1)];
            printf("%2s ", [monthNum UTF8String]);
//            if(i == 2){
//                printf("%2s ", [moncalthNum UTF8String]);
//            }else if(i == 3){
//                printf("%5s", [monthNum UTF8String]);
//            }else if(i == 5){
//                printf(" %4s", [monthNum UTF8String]);
//            }else{
//                printf("%4s", [monthNum UTF8String]);
//            }
        }
    }
}

- (void) printMonthWithoutNum{
    [self printMonthTitle];
    printf("\n");
    int weekdayOfFirstDay = [self m_nWeekdayOfFirstDay];
    int dayLength = [self m_nDayLength];

    for(int i = 1; i < weekdayOfFirstDay; ++i){
        printf("%2s ", " ");
    }
    long count = weekdayOfFirstDay - 1;
    for(int i = 1; i <= dayLength; ++i){
        
        printf("%2d ", i);
        ++count;
        if(count == 7){
            printf("\n");
            count = 0;
        }
    }
    printf("\n");
}

- (void)printMonthWithNum{
    printf("%10s%s月\n", "", [[Calendar exchangeArabicToChinese:self->m_nMonthNum] UTF8String]);
    [self printMonthTitle];
    int weekdayOfFirstDay = [self m_nWeekdayOfFirstDay];
    int dayLength = [self m_nDayLength];
    
    for(int i = 1; i < weekdayOfFirstDay; ++i){
        printf("   ");
    }
    long count = weekdayOfFirstDay - 1;
    for(int i = 1; i <= dayLength; ++i){
        //        printf("%2s ", [[NSString stringWithFormat:@"%d",i] UTF8String]);
        printf("%2d ", i);
        ++count;
        if(count == 7){
            printf("\n");
            count = 0;
        }
    }
    printf("\n");
}
@end
