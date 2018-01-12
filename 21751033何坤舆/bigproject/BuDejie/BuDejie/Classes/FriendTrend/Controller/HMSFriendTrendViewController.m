//
//  HMSFriendTrendViewController.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/6.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSFriendTrendViewController.h"
#import "UIBarButtonItem+Item.h"
#import "HMSLoginRegisterViewController.h"
@interface HMSFriendTrendViewController ()

@end

@implementation HMSFriendTrendViewController
//点击登录注册就会调用
- (IBAction)clickLoginRegister:(id)sender {
    HMSLoginRegisterViewController *loginViewController = [[HMSLoginRegisterViewController alloc] init];
    [self presentViewController:loginViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBar];
}
#pragma mark - 设置导航条
- (void)setupNavBar{
    /*
     UIBarButtonItem: 描述按钮具体的内容
     UINavigationItem: 设置导航条上的内容(左边，右边，中间)
     tabBarItem: 设置tabBar上按钮内容（tabBarButton）
     */
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] addTarget:self action:@selector(friendsRecomment)];
    // titleView
    self.navigationItem.title = @"我的关注";
    
}
#pragma mark - 推荐标签
- (void)friendsRecomment {
    HMSFunc;
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
