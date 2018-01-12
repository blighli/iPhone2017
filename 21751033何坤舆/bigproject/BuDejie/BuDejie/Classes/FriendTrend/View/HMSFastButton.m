//
//  HMSFastButton.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/8.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSFastButton.h"

@implementation HMSFastButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews {
    [super layoutSubviews];
    //设置图片位置
    self.imageView.hms_y = 0;
    self.imageView.hms_centerX = self.hms_width * 0.5;
    //设置标题位置
    self.titleLabel.hms_y = self.hms_height - self.titleLabel.hms_height;
    //计算文字宽度，设置label宽度
    [self.titleLabel sizeToFit];
    self.titleLabel.hms_centerX = self.hms_width * 0.5;
    
    
}
@end
