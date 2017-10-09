//
//  Calendar.h
//  Cal
//
//  Created by Mr.Right on 2017/10/4.
//  Copyright © 2017年 Mr.Right. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Year;
@interface Calendar : NSObject
+ (BOOL) checkLArgLegalityWithYear:(int)year;
+ (BOOL) checkLArgLegalityWithYear:(int)year AndMonth:(int)month;
+ (NSString*) exchangeArabicToChinese:(int)num;
- (void) printCalendarWithYearAndAMonth:(Year*)year;
- (void) printCalendarWithYearAndAllMonth:(Year*)year;

@end
