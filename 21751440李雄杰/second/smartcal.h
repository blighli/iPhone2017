//
 
//
//  Created by  xiongjie L on 2017/10/3.
//  Copyright © 2017年 xiongjie L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cal : NSObject

- (NSString *)calWithArgc : (int)argc andArgv : (const char **)argv;

-(NSString *)calForDate:(NSDate *)date;

-(NSString *)calForYear:(int)year;

-(NSDate *)GMT2Locale:(NSDate *)GMTDate;
@end