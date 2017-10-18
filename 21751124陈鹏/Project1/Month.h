//
//  Month.h
//  Cal
//
//  Created by Mr.Right on 2017/10/4.
//  Copyright © 2017年 Mr.Right. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Month : NSObject
{
    int m_nMonthNum;
    int m_nWeekdayOfFirstDay;
    unsigned int m_nDayLength;
}

@property int m_nMonthNum;
@property int m_nWeekdayOfFirstDay;
@property unsigned int m_nDayLength;

- (id) initWithYear: (int) year AndMonth: (int) month;
- (void) printMonthTitle;
- (void) printMonthWithoutNum;
- (void)printMonthWithNum;

@end
