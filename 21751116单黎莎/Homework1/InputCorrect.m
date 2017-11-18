//
//  InputCorrect.m
//  command-cal
//
//  Created by Edith.S on 2017/10/6.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import "InputCorrect.h"

@implementation InputCorrect

-(BOOL) isNumber:(NSString*) testStr{
    //判断输入是否为一位以上的数字
    //正则表达式的使用：http://blog.csdn.net/RunIntoLove/article/details/51454874
    NSString *input = @"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", input];
    
    //NSLog(@"%d", [numberPre evaluateWithObject:testStr]);
//    if (![numberPre evaluateWithObject:testStr]) {
//        printf("输入非法");
//    }
    
    return [numberPre evaluateWithObject:testStr];
    
}

@end
