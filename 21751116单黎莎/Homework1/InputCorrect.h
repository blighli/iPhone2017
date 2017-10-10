//
//  InputCorrect.h
//  command-cal
//
//  Created by Edith.S on 2017/10/6.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InputCorrect : NSObject
//判断获取的输入字符串是否为数字
-(BOOL) isNumber:(NSString*) str;

@end
