//
//  HMSNavigationViewController.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/7.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSNavigationViewController.h"

@interface HMSNavigationViewController () <UIGestureRecognizerDelegate>

@end

@implementation HMSNavigationViewController
+ (void)load {
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    // 只要通过模型设置，都是通过富文本设置
    // 设置导航条标题 -> UINavigationBar决定
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"%@",self.interactivePopGestureRecognizer.delegate);
    // 设置代理的原因： 控制手势什么时候触发 只有非根控制器才需要触发手势
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    [self.view addGestureRecognizer:pan];
    // 用于手势的触发
    pan.delegate = self;
    //停用之前的边缘滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
//    self.interactivePopGestureRecognizer.delegate = self;
    /*
     为什么导航控制器的手势不能全屏滑动？
     <UIScreenEdgePanGestureRecognizer: 0x7f9b6d1278b0; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7f9b6d121e00>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7f9b6d126fd0>)>>
     */
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 只有非根控制器才设置返回按钮
    if(self.childViewControllers.count > 0) {
        //跳转隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        // 回复滑动返回功能->分析：把系统的返回按钮覆盖 -> 手势失效 (1.手势被清空？ x 2.可能手势代理做了一些事情，导致失效)
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] addTarget:self action:@selector(back) title:@"返回"];
//        NSLog(@"%@", self.interactivePopGestureRecognizer);
    }
    
    //真正跳转
    [super pushViewController:viewController animated:animated];
}
- (void)back {
    [self popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
