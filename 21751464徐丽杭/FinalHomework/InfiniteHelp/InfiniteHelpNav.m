//
//  InfiniteHelpNav.m
//  InfiniteHelp
//
//  Created by sands on 16/7/26.
//  Copyright © 2016年 sands. All rights reserved.
//

#import "InfiniteHelpNav.h"

@interface InfiniteHelpNav ()

@end

@implementation InfiniteHelpNav

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SettingNavLine];
    [self SettingNavFontAndColor];
}

- (void)SettingNavLine{
    NSLog(@"SettingNavLine");
    [self.navigationBar setBackgroundImage:[UIImage new]
                                            forBarPosition:UIBarPositionAny
                                            barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}

#pragma mark 自定义返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count != 0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回箭头"]
                                                                                          style:UIBarButtonItemStyleDone
                                                                                         target:self
                                                                                         action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

#pragma mark 设置导航栏字体和颜色
- (void)SettingNavFontAndColor{
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                    NSFontAttributeName : [UIFont systemFontOfSize:16]};
}
@end
