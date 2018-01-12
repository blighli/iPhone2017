//
//  HMSLoginField.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/9.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSLoginField.h"
#import "UITextField+placeholder.h"

@implementation HMSLoginField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) awakeFromNib {
    [super awakeFromNib];
    /*
     1. 文本框光标变成白色
     2. 开始编辑的时候，占位文字颜色变成白色
     */
    //设置光标颜色为白色
    self.tintColor = [UIColor whiteColor];
    //监听文本框编辑 1.代理 2.通知 3. target
    //原则：不要自己成为代理
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    //快速设置占位文字颜色 => 文本框占位文字可能是label
    self.placeholderColor = [UIColor grayColor];
}
//文本框开始编辑调用
-(void) textBegin {
    //设置占位文字颜色变成白色
    self.placeholderColor = [UIColor whiteColor];
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}
//文本框结束编辑调用
-(void) textEnd {
    //设置占位文字颜色变成灰色
    self.placeholderColor = [UIColor grayColor];
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}
@end
