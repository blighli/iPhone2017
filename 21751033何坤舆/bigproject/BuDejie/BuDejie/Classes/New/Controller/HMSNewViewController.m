//
//  HMSNewViewController.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/6.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSNewViewController.h"
#import "HMSSubTagViewController.h"
@interface HMSNewViewController ()

@end

@implementation HMSNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    // 设置导航条
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
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] addTarget:self action:@selector(tagClick)];
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}
#pragma mark - 点击订阅标签调用
- (void)tagClick {
//    HMSFunc;
    //进入推荐标签界面
    HMSSubTagViewController *subTag = [[HMSSubTagViewController alloc] init];
    
    [self.navigationController pushViewController:subTag animated:YES];
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
