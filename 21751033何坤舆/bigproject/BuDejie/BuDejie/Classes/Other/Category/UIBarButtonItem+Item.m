//
//  UIBarButtonItem+Item.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/7.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    //    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    /* UIButton 包装成 UIBarButtonItem就导致按钮点击区域扩大
     但是我经过测试并没有发现按钮扩大的情况，并且按钮点击区域扩大应当是一种友好的体验，所以这一段仅作注释
     */
    //    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    //    [containView addSubview:btn];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage addTarget:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn sizeToFit];
    //    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    /* UIButton 包装成 UIBarButtonItem就导致按钮点击区域扩大
     但是我经过测试并没有发现按钮扩大的情况，并且按钮点击区域扩大应当是一种友好的体验，所以这一段仅作注释
     */
    //    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    //    [containView addSubview:btn];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action title:(NSString *)title {
    //设置导航条左边按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highImage forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:backButton];
}
@end
