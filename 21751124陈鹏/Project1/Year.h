//
//  Year.h
//  Cal
//
//  Created by Mr.Right on 2017/10/4.
//  Copyright © 2017年 Mr.Right. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Month;
@interface Year : NSObject
{
    int m_nYear;
    int m_nMonthNum;
    NSArray *m_aMonths;
}

@property int m_nYear;
@property int m_nMonthNum;

- (id) init;
- (id) initWithYear: (int) year;
- (id) initWithYear: (int) year AndMonth: (int) month;
- (NSArray*) createMonthsArray;
- (NSArray*) getMonths;
@end
