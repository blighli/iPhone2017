//
//  UITextField+placeholder.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/9.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "UITextField+placeholder.h"
#import <objc/message.h>

@implementation UITextField (placeholder)
-(void)setPlaceholderColor:(UIColor *)placeholderColor {
    // 给成员属性赋值 用runtime
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 获取占位文字label控件
    UILabel *placeholderLable = [self valueForKey:@"placeholderLabel"];
    
    // 设置占位文字颜色
    placeholderLable.textColor = placeholderColor;
}
-(UIColor *)placeholderColor {
    return objc_getAssociatedObject(self, @"placeholderColor");
}
@end
