//
//  HMSTitleButton.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/11.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSTitleButton.h"

@implementation HMSTitleButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted {
    //重写这个方法 按钮就无法进入高亮状态
}
@end
