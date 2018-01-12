//
//  UIView+Frame.h
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/7.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
  写分类：避免跟其他开发者产生冲突
 */
@interface UIView (Frame)

@property CGFloat hms_width;
@property CGFloat hms_height;
@property CGFloat hms_x;
@property CGFloat hms_y;
@property CGFloat hms_centerX;
@property CGFloat hms_centerY;

@end
