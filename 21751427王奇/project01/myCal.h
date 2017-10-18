//
//  myCal.h
//  Project01
//
//  Created by 王奇 on 2017/10/10.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myCal : NSObject

@property long year;

- (void) printYear;
- (void) printMonth: (long) month;

@end
