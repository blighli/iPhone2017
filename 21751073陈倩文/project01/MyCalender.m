//
//  MyCalender.m
//  cal_cqw
//
//  Created by 陈倩文 on 2017/10/9.
//  Copyright © 2017年 陈倩文. All rights reserved.
//

#import "MyCalender.h"
#import "DateCalculator.h"

@implementation MyCalender

/*
 十月 2017
 日 一 二 三 四 五 六
 1  2  3  4  5  6  7
 8  9 10 11 12 13 14
 15 16 17 18 19 20 21
 22 23 24 25 26 27 28
 29 30 31
 */
-(id) init{
    self = [super init];
    if (self){
        monName = [NSArray arrayWithObjects:@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月",nil];
        weekName= [NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六",nil];
        nleapYear = [[NSArray alloc] initWithObjects:@"0",@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31",nil];
        leapYear = [[NSArray alloc] initWithObjects:@"0",@"31",@"29",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31",nil];
        AllYears = [[NSArray alloc] initWithObjects:nleapYear,leapYear,nil];
    }
    return self;
}
- (void) printMonth:(int)month AndYear:(int)year {
    printf("%s %d\n",[monName[month-1] UTF8String],year);
    for (int i=0; i<6;i++){
        printf("%s ",[weekName[i] UTF8String]);
    }
    printf("%s\n",[weekName[6] UTF8String]);
    
    BOOL isLeap =[DateCalculator isLeapYear:year];
    int daysThisMonth = [AllYears[isLeap][month] intValue];
    int daysTillLastMonth = [DateCalculator daysOfUntilLastMonth:month AndYear:year];
    int position = daysTillLastMonth % 7+1;
    if(position%7 !=0){
        for (int k=1; k<=position*3; k++) {
            printf(" ");
        }
    }
    for (int j=1;j<daysThisMonth;j++){
        if ((position+j) % 7 == 0){
            printf("%2d\n",j);
        }
        else{
            printf("%2d ",j);
        }
    }
    printf("%2d\n",daysThisMonth);
}
/*
2017

一月                  二月                  三月
日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六
' '*21 + ' ' + ' '*21
1  2  3  4  5  6  7            1  2  3  4            1  2  3  4
8  9 10 11 12 13 14   5  6  7  8  9 10 11   5  6  7  8  9 10 11
15 16 17 18 19 20 21  12 13 14 15 16 17 18  12 13 14 15 16 17 18
22 23 24 25 26 27 28  19 20 21 22 23 24 25  19 20 21 22 23 24 25
29 30 31              26 27 28              26 27 28 29 30 31

四月                  五月                  六月
日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六
1      1  2  3  4  5  6               1  2  3
2  3  4  5  6  7  8   7  8  9 10 11 12 13   4  5  6  7  8  9 10
9 10 11 12 13 14 15  14 15 16 17 18 19 20  11 12 13 14 15 16 17
16 17 18 19 20 21 22  21 22 23 24 25 26 27  18 19 20 21 22 23 24
23 24 25 26 27 28 29  28 29 30 31           25 26 27 28 29 30
30
七月                  八月                  九月
日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六
1         1  2  3  4  5                  1  2
2  3  4  5  6  7  8   6  7  8  9 10 11 12   3  4  5  6  7  8  9
9 10 11 12 13 14 15  13 14 15 16 17 18 19  10 11 12 13 14 15 16
16 17 18 19 20 21 22  20 21 22 23 24 25 26  17 18 19 20 21 22 23
23 24 25 26 27 28 29  27 28 29 30 31        24 25 26 27 28 29 30
30 31
十月                 十一月                十二月
日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六
1  2  3  4  5  6  7            1  2  3  4                  1  2
8  9 10 11 12 13 14   5  6  7  8  9 10 11   3  4  5  6  7  8  9
15 16 17 18 19 20 21  12 13 14 15 16 17 18  10 11 12 13 14 15 16
22 23 24 25 26 27 28  19 20 21 22 23 24 25  17 18 19 20 21 22 23
29 30 31              26 27 28 29 30        24 25 26 27 28 29 30
31
*/
- (void) printYear:(int)year {
    printf("                             %d\n\n",year);
    
    BOOL isLeap = [DateCalculator isLeapYear:year];
    
    for (int group = 1;group<=4;group++){
        //first row
        printf("%s                   %s                   %s                   \n",[monName[group*3-3] UTF8String],[monName[group*3-2] UTF8String],[monName[group*3-1] UTF8String]);
        
        for (int j=0;j<3;j++){
            for (int i=0; i<=6;i++){
                printf("%s ",[weekName[i] UTF8String]);
            }
            printf("    ");
        }
        printf("\n");
        
        int monthDay1 = [AllYears[isLeap][group*3-2] intValue];
        int monthDay2 = [AllYears[isLeap][group*3-1] intValue];
        int monthDay3 = [AllYears[isLeap][group*3] intValue];
        int daysTillLastMonth = [DateCalculator daysOfUntilLastMonth:group*3-2 AndYear:year];
        int position1 = (daysTillLastMonth) % 7+1;
        if(position1 == 7){
            position1 = 0;
        }
        int position2 = (position1+monthDay1) % 7;
        int position3 = (position2+monthDay2) % 7;
        int count1 = 1,count2 =1 ,count3=1;
        for(int row=0;row<5;row++){
            if(row==0){
                for (int k=1; k<=position1*3; k++) {
                    printf(" ");
                }
            }
            for(int i=count1;i<=7*(row+1)-position1;i++){
                if(count1 > monthDay1) break;
                printf("%2d ",i);
                count1++;
            }
            if(row==4){
                int temp = 35 - monthDay1 - position1;
                for (int k=1; k<=temp*3; k++) {
                    printf(" ");
                }
                printf(" ");
            }
            else{
                printf(" ");
            }
            
            
            if(row==0){
                for (int k=1; k<=position2*3; k++) {
                    printf(" ");
                }
            }
            for(int i=count2;i<=7*(row+1)-position2;i++){
                if(count2 > monthDay2) break;
                printf("%2d ",i);
                count2++;
            }
            if(row==4){
                int temp = 35 - monthDay2 - position2;
                for (int k=1; k<=temp*3; k++) {
                    printf(" ");
                }
                printf(" ");
            }
            else{
                printf(" ");
            }
            
        
            if(row==0){
                for (int k=1; k<=position3*3; k++) {
                    printf(" ");
                }
            }
            for(int i=count3;i<=7*(row+1)-position3;i++){
                if(count3 > monthDay3) break;
                printf("%2d ",i);
                count3++;
            }
            printf("\n");
            if(count3 == monthDay3) break;
        }
        printf("\n");
    }
}
@end
