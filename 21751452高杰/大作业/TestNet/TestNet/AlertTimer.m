//
//  AlertTimer.m
//  TestNet
//
//  Created by Yif-JJ on 2017/9/22.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import "AlertTimer.h"

@implementation AlertTimer
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message inController:(UIViewController *)controller{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle: UIAlertControllerStyleAlert];
    [controller presentViewController:alert animated:true completion:nil];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:alert repeats:NO];
}
+ (void)timerAction:(NSTimer*)timer
{
    UIAlertController * alert = (UIAlertController *)[timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;
}
@end
