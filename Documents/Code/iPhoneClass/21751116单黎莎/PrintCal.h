//
//  PrintCal.h
//  command-cal
//
//  Created by Edith.S on 2017/10/6.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrintCal : NSObject

-(void) printYear:(NSInteger)currentYear;
-(void)printYear:(NSInteger)currentYear andMonth:(NSInteger) currentMonth;

@end
