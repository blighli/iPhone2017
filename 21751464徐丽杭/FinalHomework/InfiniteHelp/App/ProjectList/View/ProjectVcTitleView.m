//
//  ProjectVcTitleView.m
//  InfiniteHelp
//
//  Created by sands on 16/7/22.
//  Copyright © 2016年 sands. All rights reserved.
//

#import "ProjectVcTitleView.h"

@implementation ProjectVcTitleView

- (void)awakeFromNib{
    self.selectView.layer.masksToBounds = YES;
    self.selectView.layer.cornerRadius = self.selectView.bounds.size.height/2;
    
    self.BackLabel.layer.masksToBounds = YES;
    self.BackLabel.layer.cornerRadius = self.BackLabel.bounds.size.height/2;
}


- (IBAction)ButtonClick:(UIButton *)sender {
    if (sender == self.ButtonOne) {
        if (self.BackLabel.center.x == self.ButtonTwo.center.x-1) {
            [self StatusWithAnimation:-((self.selectView.bounds.size.width/2)-2)];
            [self.delegate ButtonOneClick];
        }
    }else{
        if (self.BackLabel.center.x == self.ButtonOne.center.x+1) {
            [self StatusWithAnimation:(self.selectView.bounds.size.width/2)-2];
            [self.delegate ButtonTwoClick];
        }
    }
}

- (void)StatusWithAnimation:(CGFloat)xNumber{
    [UIView beginAnimations:nil context:nil]; // 开始动画
    [UIView setAnimationDuration:1.0]; // 动画时长
    CGPoint point = self.BackLabel.center;
    point.x += xNumber;
    [self.BackLabel setCenter:point];
    [UIView commitAnimations]; // 提交动画
}


@end
