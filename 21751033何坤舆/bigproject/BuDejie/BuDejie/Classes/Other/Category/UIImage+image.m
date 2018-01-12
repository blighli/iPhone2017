//
//  UIImage+image.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/6.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)
+ (UIImage *)imageOriginalWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed: imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
