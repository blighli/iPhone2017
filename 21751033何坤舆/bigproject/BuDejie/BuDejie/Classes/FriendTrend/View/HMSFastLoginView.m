//
//  HMSFastLoginView.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/8.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSFastLoginView.h"

@implementation HMSFastLoginView
+ (instancetype)fastLoginView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
