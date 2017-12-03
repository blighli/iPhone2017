//
//  ProjectCategory.m
//  CooperateHappily
//
//  Created by 余盛褚 on 15/12/20.
//  Copyright © 2015年 sands.yu. All rights reserved.
//

#import "ProjectCategory.h"

@implementation ProjectCategory

@end

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end

@implementation UIView (AdjustPosition)

- (void)setTop:(CGFloat)top{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)left{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

@end

@implementation NSString (HPDString)

- (NSString *)removeCommas
{
    return [self stringByReplacingOccurrencesOfString:@"," withString:@""];
}

- (BOOL)checkMatchRegex:(NSString *)regex
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:self];
}

- (BOOL)isMoneyFormmat
{
    return [self checkMatchRegex:@"^(([1-9]\\d{0,9})|0)(\\.\\d{1,2})?$"];
}

- (BOOL)isEmailFormat
{
    return [self checkMatchRegex:@"^(\\w+([-+.]\\w+)*@\\w+([-.]\\\\w+)*\\.\\w+([-.]\\w+)*)|(\\?)$"];
}

- (BOOL)isPhoneNumberFormat
{
    return [self checkMatchRegex:@"((\\(\\d{3}\\))|(\\d{3}\\-))?1(1|2|3|4|5|6|7|8|9)\\d{9}|(\\?){1,1}|(10000000000)$"];
}

- (BOOL)isIDCardFormart
{
    return [self checkMatchRegex:@"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X|x)$"];
}

@end