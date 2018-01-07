//
//  AlertTimer.h
//  TestNet
//
//  Created by Yif-JJ on 2017/9/22.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AlertTimer : NSObject
+ (void) alertWithTitle:(NSString *)title message:(NSString *)message inController:(UIViewController *)controller;

@end
