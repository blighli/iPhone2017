//
//  UIBarButtonItem+Item.h
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/7.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
//快速创建UIBarButtonItem
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(id)target action:(SEL)action title:(NSString *)title;
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage addTarget:(id)target action:(SEL)action;

@end
