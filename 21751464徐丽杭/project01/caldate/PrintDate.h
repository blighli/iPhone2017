//
//  PrintDate.h
//  caldate
//
//  Created by lihang  Xu on 2017/10/10.
//  Copyright © 2017年 lihang  Xu. All rights reserved.
//

@interface PrintDate:NSObject
{

}
- (void) printMonth:(int)Y andMonth:(int)M;
- (void) printYear:(int)year;
+ (NSMutableString *) transformMonthToChinese:(int)month;
@end
