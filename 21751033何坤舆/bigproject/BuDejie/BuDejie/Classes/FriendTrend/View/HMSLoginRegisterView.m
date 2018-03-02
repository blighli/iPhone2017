//
//  HMSLoginRegisterView.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/8.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSLoginRegisterView.h"
@interface HMSLoginRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;

@end
@implementation HMSLoginRegisterView
/* 越复杂的界面，封装 有特殊效果界面，封装 */
+(instancetype)loginView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
+(instancetype)registerView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib {
    UIImage *image = _loginRegisterButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    // 让按钮的背景图片不要被拉伸
    [_loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
}

@end
