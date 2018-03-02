//
//  HMSTabBarController.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/6.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSTabBarController.h"
#import "HMSEssenceViewController.h"
#import "HMSFriendTrendViewController.h"
#import "HMSMeViewController.h"
#import "HMSNewViewController.h"
#import "HMSPublishViewController.h"

#import "UIImage+image.h"
#import "HMSTabBar.h"
#import "HMSNavigationViewController.h"

@interface HMSTabBarController ()

@end

@implementation HMSTabBarController
// 只会调用一次
+ (void)load {
    /*
        appearance:
        1.只要遵守UIAppearence协议并且实现
        2.哪些属性可以appearance设置，只有被UI_APPEARANCE_SELECTOR宏修饰的属性才能设置
        使用场景：只能在控件显示之前设置，才有作用
     */
    
    //获取整个应用程序下的UITabBarItem
//    UITabBarItem *item = [UITabBarItem appearance];
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    //设置按钮选中标题的颜色 富文本：描述一个文字颜色，字体，阴影，空心，图文混排
    //创建一个描述文本属性的字典
    //设置颜色 字体尺寸
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}
#warning TODO
/*
 问题：
 - [x] 1. 选中按钮的图片被渲染 -> ios7之后默认tabBar上按钮都会被渲染 1.修改图片 2.通过代码
 - [x] 2. 标题选中文字是黑色的而不是蓝色的，字体 -> 对应子控制器
 - [ ] 3. 发布按钮显示不出来 -> 发布按钮图片太大 显示不出来
 
    1. 图片太大，系统帮你渲染 => 能显示 => 位置不对 => 高亮达不到
    2. 加号的图片比其他图片大因此就会超出tabBar
    3. 不想要超出，让加号的图片垂直居中 => 修改加号按钮位置 => tabBar上按钮位置由系统决定，我们不能自己决定 =>　系统的tabBarButton没有提供高亮图片状态，因此做不了效果 => 加号按钮应该是普通按钮才能有高亮状态
    4. 最终方案：调整系统tabBar上按钮位置，平均分成5等份，再把加号按钮显示在中间
    调整系统自带控件的子控件的位置 => 自定义tabBar => 使用tabBar
    研究系统的tabBarButton什么时候添加到self.tabBar，在viewWillAppear
    
 
    解决： 不能修改图片尺寸，效果：让发布图片居中

 */

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //2.1 添加子控制器（5个子控制器）-> 自定义控制器 -> 划分项目文件结构
    [self setupAllChildViewController];
    
    //2.2 设置tabBar上按钮内容 -> 由对应的子控制器的tabBarItem属性
    [self setupAllTitleButton];
    
    //2.3 自定tabBar
    [self setupTabBar];
}

#pragma mark - 添加所有子控制器
- (void) setupAllChildViewController {
    // 精华 essence
    HMSEssenceViewController *essenceViewController = [[HMSEssenceViewController alloc]init];
    //tabBarViewController: 会把第0个子控制器的view添加进去
    /*
     UINavigationController
     |-  UIChildViewController
     |-  UINav: 44 margin-top:20
     */
    HMSNavigationViewController *navForEssence = [[HMSNavigationViewController alloc] initWithRootViewController:essenceViewController];
    //initWithRootViewController:push入栈
    [self addChildViewController:navForEssence];
    
    // 新帖 new
    HMSNewViewController *NewViewController = [[HMSNewViewController alloc]init];
    HMSNavigationViewController *navForNew = [[HMSNavigationViewController alloc] initWithRootViewController:NewViewController];
    [self addChildViewController:navForNew];
    
    // 发布 publish
//    HMSPublishViewController *publishViewController = [[HMSPublishViewController alloc]init];
//    [self addChildViewController:publishViewController];
    
    // 关注 friend
    HMSFriendTrendViewController *friendTrendViewController = [[HMSFriendTrendViewController alloc]init];
    HMSNavigationViewController *navForFriend = [[HMSNavigationViewController alloc] initWithRootViewController:friendTrendViewController];
    [self addChildViewController:navForFriend];
    
    // 我 me
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([HMSMeViewController class]) bundle:nil];
    //加载箭头指向的控制器
    HMSMeViewController *meViewController = [storyboard instantiateInitialViewController];
    HMSNavigationViewController *navForMe = [[HMSNavigationViewController alloc] initWithRootViewController:meViewController];
    [self addChildViewController:navForMe];
    
}

//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear: animated];
//    NSLog(@"%@", self.tabBar.subviews);
//}

- (void)setupTabBar {
    HMSTabBar *tabBar = [[HMSTabBar alloc]init];
    [self setValue:tabBar forKeyPath:@"tabBar"]; //KVC 1.找setter 2.找tabBar属性 直接通过属性值赋值
}
// 设置tabBar上的内容
-(void)setupAllTitleButton {
    // 精华 essence
    UINavigationController *navForEssence = self.childViewControllers[0];
    navForEssence.tabBarItem.title = @"精华";
    navForEssence.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    //快速生成没有渲染的图片
    navForEssence.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    // 新帖 new
    UINavigationController *navForNew = self.childViewControllers[1];
    navForNew.tabBarItem.title = @"新帖";
    navForNew.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    navForNew.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    // 发布 publish
//    HMSPublishViewController *publishViewController = self.childViewControllers[2];
//    publishViewController.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
//    publishViewController.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
//    publishViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    // 关注 friendTrend
    UINavigationController *navForFriend = self.childViewControllers[2];
    navForFriend.tabBarItem.title = @"关注";
    navForFriend.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    navForFriend.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    // 我 Me
    UINavigationController *navForMe = self.childViewControllers[3];
    navForMe.tabBarItem.title = @"我";
    navForMe.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    navForMe.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
