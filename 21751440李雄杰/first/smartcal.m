//
//   
//  smartcal
//
//  Created by xiongjie L  on 2017/10/3.
//  Copyright © 2017年 xiongjie L. All rights reserved.
//
#import "smartcal.h"

@implementation Cal

 
- (NSString *)calWithArgc:(int)argc andArgv:(const char **)argv {
    switch(argc) {
        case 1: {
            NSDate *now = [NSDate date];
            return [self calForDate:now];
            break;
        }
        case 2: {
            int year = atoi(argv[1]);
            if(year<1 || year>9999){
                return [NSString stringWithFormat:@"cal: year %d not in range 1..9999\n",year];
            }
            return [self calForYear:year];
            break;
        }
        case 3: {
            int month = atoi(argv[1]);
            int year = atoi(argv[2]);
            if(month<1 || month>12){
                return [NSString stringWithFormat:@"cal: %d is not a month number (1..12)\n",month];
            }
            if(year<1 || year>9999){
                return [NSString stringWithFormat:@"cal: year %d not in range 1..9999\n",year];
            }
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM";
            NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%4d-%2d",year,month]];
            return [self calForDate:date];
            break;
        }
        default:
            break;
    }
    return nil;
} // calWithArgc:andArgv:


 
- (NSString *)calForDate:(NSDate *)date {
    NSMutableString *retString = [NSMutableString stringWithFormat:@""];
   
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour fromDate:date];//自动转化为本地时间
    int year = (int)components.year;
    int month = (int)components.month;
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self GMT2Locale:date]];//转换为本地时间，避免时区问题
    int monthRange = (int)range.length;
   
    NSDateComponents *firstDayComponents = [[NSDateComponents alloc] init];
    [firstDayComponents setYear:year];
    [firstDayComponents setMonth:month];
    NSDate *firstDay = [calendar dateFromComponents:firstDayComponents];
    firstDayComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDay];
    int weekday = (int)firstDayComponents.weekday-1;//周日对应weekday为1
   
    NSString *title = [NSString stringWithFormat:@"      %4d %2d       \n",(int)components.year,(int)components.month];
    NSString *subTitle = @"Su Mo Tu We Th Fr Sa\n";
    [retString appendFormat:@"%@%@",title,subTitle];
    
    int day = 1;
    int col = 0;
    while(weekday>0){
        [retString appendString:@"   "];
        weekday--;
        col++;
    }
    while(day<=monthRange){
        while(col<7){
            if(col==6){
                [retString appendFormat:@"%2d",day];
            }
            else [retString appendFormat:@"%2d ",day];
            col++;
            day++;
            if(day>monthRange) break;
        }
        if(day>monthRange){
            while(col<7){
                if(col==6){
                    [retString appendString:@"  "];
                }
                else [retString appendString:@"   "];
                col++;
            }
            break;
        }
        col = 0;
        [retString appendString:@"\n"];
    }
    return retString;
} 


 
- (NSString *)calForYear:(int)year {
    NSMutableString *retString = [NSMutableString stringWithFormat:@""];
    [retString appendFormat:@"                             %4d                             \n\n",year];
    NSMutableArray *monthStringArray = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM";
    for(int month=1;month<=12;month++){
        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%4d-%2d",year,month]];
        NSString *monthString = [self calForDate:date];
        NSMutableArray *tempArray = [monthString componentsSeparatedByString:@"\n"].mutableCopy;
        [monthStringArray addObject:tempArray];
    }

    for(int i=0;i<12/3;i++){
        int returnFlag=0;
        int maxLineCount=(int)((NSMutableArray *)monthStringArray[3*i]).count;
        for(int m=3*i;m<3*(i+1);m++){
            int tempCount=(int)((NSMutableArray *)monthStringArray[m]).count;
            if(maxLineCount<tempCount){
                maxLineCount = tempCount;
            }
        }
        for(int m=3*i;m<3*(i+1);m++){
            int tempCount=(int)((NSMutableArray *)monthStringArray[m]).count;
            if(tempCount<maxLineCount){
                returnFlag = 1;
                NSMutableArray *tempMutableArray = (NSMutableArray *)monthStringArray[m];
                [tempMutableArray addObject:@"                    "];
            }
        }
        for(int m=0;m<maxLineCount;m++){
            for(int n=3*i;n<3*(i+1);n++){
            [retString appendFormat:@"%@",(NSMutableArray *)monthStringArray[n][m]];
            [retString appendString:@"  "];
            }
            [retString appendString:@"\n"];
        }
        if(!returnFlag){
            [retString appendString:@"\n"];
        }
    }
    return retString;
}

- (NSDate *)GMT2Locale:(NSDate *)GMTDate {
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:GMTDate];
    NSDate *localeDate = [GMTDate dateByAddingTimeInterval:interval];
    return localeDate;
}
@end