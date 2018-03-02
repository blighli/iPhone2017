//
//  UIView+Frame.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/7.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setHms_height:(CGFloat)hms_height {
    CGRect rect = self.frame;
    rect.size.height = hms_height;
    self.frame = rect;
}
- (CGFloat)hms_height {
    return self.frame.size.height;
}

- (void)setHms_width:(CGFloat)hms_width {
    CGRect rect = self.frame;
    rect.size.width = hms_width;
    self.frame = rect;
}
- (CGFloat)hms_width {
    return self.frame.size.width;
}

- (void)setHms_x:(CGFloat)hms_x {
    CGRect rect = self.frame;
    rect.origin.x = hms_x;
    self.frame = rect;
}
- (CGFloat)hms_x {
    return self.frame.origin.x;
}

- (void)setHms_y:(CGFloat)hms_y {
    CGRect rect = self.frame;
    rect.origin.y = hms_y;
    self.frame = rect;
}
- (CGFloat)hms_y {
    return self.frame.origin.y;
}

- (void)setHms_centerX:(CGFloat)hms_centerX {
    CGPoint center = self.center;
    center.x = hms_centerX;
    self.center = center;
}
- (CGFloat)hms_centerX {
    return self.center.x;
}

- (void)setHms_centerY:(CGFloat)hms_centerY {
    CGPoint center = self.center;
    center.y = hms_centerY;
    self.center = center;
}
- (CGFloat)hms_centerY {
    return self.center.y;
}
@end
