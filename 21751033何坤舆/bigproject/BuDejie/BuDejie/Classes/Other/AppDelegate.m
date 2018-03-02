//
//  AppDelegate.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/6.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "AppDelegate.h"
#import "HMSTabBarController.h"
#import "HMSAdViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
// 自定义类：1. 管理自己的业务
//程序启动的时候就会调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1. 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //2. 设置窗口根控制器
    /*
     UITabBarController
       |-  UIChildViewController
       |-  UITabBar: 49
     */
//    HMSTabBarController *tabBarViewController = [[HMSTabBarController alloc] init];
    HMSAdViewController *adViewController = [[HMSAdViewController alloc]init];
    //init -> WithNibName 1.首先判断有没有指定nibName 2.判断下有没有跟类名同名xib
    self.window.rootViewController = adViewController;
//    self.window.rootViewController = tabBarViewController;
    //3. 显示窗口 1.成为UIApplication主窗口 2.
    [self.window makeKeyAndVisible];
//    NSLog(@"%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 优先级 LauchScreen > LauchImages
 如果是通过LaunchImage设置启动界面，那么屏幕的可视范围由图片决定
 如果使用LaunchImage，必须提供各种尺寸的启动界面
 
 LaunchScreen好处:
 1.自动识别当前真机或者模拟器的尺寸
 2.只要让美工提供一个可拉神的图片
 3.展示更多的东西
 */

/*
 项目架构搭建：
 主流结构（UITabBarController + 导航控制器）
 -> 开发方式： 1. storyboard 2.纯代码
 
 搭建基本结构 -> 设置底部条 -> 设置顶部条 -> 设置顶部条标题字体 -> 处理导航控制器业务逻辑（跳转）
 */

//每次程序启动的时候进入广告界面
//在启动的时候，加广告界面
//启动完成的时候，加入广告界面（展示了启动图片）
/*
 1. 程序一启动就进入广告界面，窗口的根控制器设置为广告控制器
 2. 加上一个广告界面,等时间过去后再将广告界面移除
 */
@end
