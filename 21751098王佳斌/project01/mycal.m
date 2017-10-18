//
//  mycal.m
//  cal_w
//
//  Created by 王佳斌 on 2017/10/7.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "mycal.h"

static int DayofMonth[12] = {
    31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
};

static char* weeks ={
    "日 一 二 三 四 五 六 "
};

static char* month[] = {
    "一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"
};


@implementation mycal
- (BOOL) doLeap: (int) year{
    if ((year%4==0 && year%100!=0) || year%400==0){
        DayofMonth[1] = 29;
        return YES;
    }
    else{
        DayofMonth[1] = 28;
        return NO;
    }
}
- (int) firstday: (int) year{
  return  ((year-1)+(year-1)/4 -(year/100)+(year/400)+1)%7;
}
- (void) PrtbyMonth: (int)month Andyear:(int) year{
    [self doLeap : year];
    int day = [self firstday: year];
    for(int i =0;i < month-1; ++i){
        day += DayofMonth[i];
    }
    day %= 7;
    printf("    %d 月  %d 年\n",month,year);
    printf("%s",weeks);
    printf("\n");
    int Numofprt=0;
    //当计数器的值变0了其实可以停止输出
    //预先用空格填充本月一号之前的输出
    for(int i=0;i<day;++i)
        printf("   ");
    for(int i=0; i<6; ++i){
        for(int j=day ; j<7; ++j){
            if(Numofprt < DayofMonth[month-1]){
                Numofprt++;
                printf("%2d ",Numofprt);
                day = 0;
            }
        }
        
        printf("\n");
    }
}
- (void) PrtbyYear:(int)year {
    [self doLeap: year];
    int day = [self firstday:year];
    int tag_1,tag_2,tag_3;
    tag_1 = day;
    tag_2 = (tag_1 + DayofMonth[0])%7;
    tag_3 = (tag_2 + DayofMonth[1])%7;
    printf("%36d 年\n\n",year);
    for(int i=0; i < 12 ; i+= 3){
        if(i){
            tag_1 = (tag_3 + DayofMonth[i])%7;
            tag_2 = (tag_1 + DayofMonth[i+1])%7;
            tag_3 = (tag_2 + DayofMonth[i+2])%7;
        }
        //用三个计数器来计算输出的次数，当输出为0 输出‘  ’
        int cnt1 = 0,temp1=tag_1;
        int cnt2 = 0,temp2=tag_2;
        int cnt3 = 0,temp3=tag_3;
        printf("%15s%26s%26s\n",month[i],month[i+1],month[i+2]);
        for(int j=0;j<3;++j){
            printf("%s",weeks);
            printf("  ");
        }
        printf("\n");
        for(int j =0; j<6; ++j){
            if(j==0){
                int k=0;
                for(k=0;k<temp1;++k){
                    printf("   ");
                }
                for(k=temp1;k<7;++k){
                    printf("%2d ",++cnt1);
                }
                printf("  ");
                for(k=0;k<temp2;++k){
                    printf("   ");
                }
                for(k=temp2;k<7;++k){
                    printf("%2d ",++cnt2);
                }
                printf("  ");
                for(k=0;k<temp3;++k){
                    printf("   ");
                }
                for(k=temp3;k<7;++k){
                    printf("%2d ",++cnt3);
                }
            }
            else{
                for(int k=0;k<7; ++k){
                    if(cnt1<DayofMonth[i])
                        printf("%2d ",++cnt1);
                    else
                        printf("   ");
                }
                printf("  ");
                for(int k=0;k<7; ++k){
                    if(cnt2<DayofMonth[i+1])
                        printf("%2d ",++cnt2);
                    else
                        printf("   ");
                }
                printf("  ");
                for(int k=0;k<7; ++k){
                    if(cnt3<DayofMonth[i+2])
                        printf("%2d ",++cnt3);
                    else
                        printf("   ");
                }
            }
            printf("\n");
        }
    }
}



@end
