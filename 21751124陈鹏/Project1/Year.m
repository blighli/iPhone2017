//
//  Year.m
//  Cal
//
//  Created by Mr.Right on 2017/10/4.
//  Copyright © 2017年 Mr.Right. All rights reserved.
//

#import "Year.h"
#import "Month.h"

@implementation Year
@synthesize m_nYear, m_nMonthNum;

-(id) init{
    self = [super init];
    if(self){
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear fromDate: [NSDate date]];

        self->m_nYear = (int)[components year];
        self->m_nMonthNum = (int)[components month];
        self->m_aMonths = [self createMonthsArray];
       
    }
    return self;
}

- (id) initWithYear: (int) year{
    self = [super init];
    if(self){
        self->m_nYear = year;
        self->m_nMonthNum = 0;
        self->m_aMonths = [self createMonthsArray];
    }
    return self;
}

- (id) initWithYear: (int) year AndMonth: (int) month{
    self = [super init];
    if(self){
        self->m_nYear = year;
        self->m_nMonthNum = month;
        self->m_aMonths = [self createMonthsArray];
    }
    return self;
}

- (NSArray*) createMonthsArray{
    NSArray *array = nil;
    if(self->m_nMonthNum == 0){
        int year = self->m_nYear;
        Month *month1 = [[Month alloc] initWithYear:year AndMonth:1];
        Month *month2 = [[Month alloc] initWithYear:year AndMonth:2];
        Month *month3 = [[Month alloc] initWithYear:year AndMonth:3];
        Month *month4 = [[Month alloc] initWithYear:year AndMonth:4];
        
        Month *month5 = [[Month alloc] initWithYear:year AndMonth:5];
        Month *month6 = [[Month alloc] initWithYear:year AndMonth:6];
        Month *month7 = [[Month alloc] initWithYear:year AndMonth:7];
        Month *month8 = [[Month alloc] initWithYear:year AndMonth:8];
        
        Month *month9 = [[Month alloc] initWithYear:year AndMonth:9];
        Month *month10 = [[Month alloc] initWithYear:year AndMonth:10];
        Month *month11 = [[Month alloc] initWithYear:year AndMonth:11];
        Month *month12 = [[Month alloc] initWithYear:year AndMonth:12];
        
        array = [NSArray arrayWithObjects:month1, month2, month3, month4, month5,
                 month6, month7, month8, month9, month10, month11, month12, nil];
    }else{
        Month *month = [[Month alloc] initWithYear:self->m_nYear AndMonth:self->m_nMonthNum];
        array = [NSArray arrayWithObjects:month, nil];
    }
    
    return array;
}

- (NSArray*) getMonths{
    return self->m_aMonths;
}

@end
