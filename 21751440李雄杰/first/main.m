//
//  smartcal
//  
//
//  Created by xiongjie L on 2017/10/3.
//  Copyright © 2017年 xiongjie L. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "smartcal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Cal *newCal = [[Cal alloc] init];
        NSString *result = [newCal calWithArgc:argc andArgv:argv];
        printf("%s\n",result.UTF8String);
    }
    return 0;
}