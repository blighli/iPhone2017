//
//  HMSTabBar.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/6.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSTabBar.h"

@interface HMSTabBar ()

@property (nonatomic, weak) UIButton *plusButton;
/* 上一次点击的按钮 */
@property (nonatomic, weak) UIControl *previousClickedTabBarButton;
@end
@implementation HMSTabBar
- (UIButton *)plusButton {
    if (!_plusButton) {
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        //根据的按钮的内容自适应
        [plusButton sizeToFit];
        
        _plusButton = plusButton;
        
        [self addSubview:plusButton];
    }
    return _plusButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews {
    [super layoutSubviews];
    // 布局tabBarButton
//    NSLog(@"%@",self.subviews);
    NSInteger count = self.items.count + 1;
    CGFloat btnW = self.hms_width /count;
    CGFloat btnH = self.hms_height;
    NSInteger btnX = 0;
    NSInteger i = 0;
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //设置previousClickedTabBarButton默认值为最前面的按钮
            if(i == 0 && self.previousClickedTabBarButton == nil) {
                self.previousClickedTabBarButton = tabBarButton;
            }
            if(i == 2){
                i += 1;
            }
            btnX = i * btnW;
            
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, btnH);
            i++;
            //监听点击
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    //设置加号按钮
    self.plusButton.center = CGPointMake(self.hms_width * 0.5, self.hms_height * 0.5);
}
- (void)tabBarButtonClick:(UIControl *)tabBarButton {
    if(self.previousClickedTabBarButton == tabBarButton) {
//        HMSFunc;
        
        // 发出通知 告知外界背重复点击了 前缀+主题+did\will+动词+notification
        [[NSNotificationCenter defaultCenter] postNotificationName:HMSTabBarButtonDidRepeatClickNotification object:nil];
    }
    self.previousClickedTabBarButton = tabBarButton;
}
@end
