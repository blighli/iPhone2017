//
//  MainScreen.m
//  TestNet
//
//  Created by Yif-JJ on 2017/9/20.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import "MainScreen.h"
#import "MessageScreen.h"
#import "ProfileScreen.h"
#import "FoundScreen.h"
#import "ContactScreen.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MainScreen ()

@end

@implementation MainScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    
}
- (void)initViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MessageScreen *msgVC  = [storyboard instantiateViewControllerWithIdentifier:@"message"];
    ContactScreen *contactVC = [storyboard instantiateViewControllerWithIdentifier:@"contact"];
    FoundScreen *foundVC = [storyboard instantiateViewControllerWithIdentifier:@"found"];
    ProfileScreen *profileVC = [storyboard instantiateViewControllerWithIdentifier:@"profile"];
    NSArray *vcArray = @[msgVC,contactVC,foundVC,profileVC];
    NSMutableArray *tabArray = [NSMutableArray arrayWithCapacity:vcArray.count];
    //初始化导航控制器
    for (int i = 0; i < vcArray.count; i++) {
        UINavigationController *navCtrl = [[UINavigationController alloc]
                                           initWithRootViewController:vcArray[i]];
        [tabArray addObject:navCtrl];
    }
    //将导航控制器给标签控制器
    self.viewControllers = tabArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showTabBar:(BOOL)show{
    CGRect frame = self.tabBarView.frame;
    if (show) {
        frame.origin.x = 0;
    }else{
        frame.origin.x = - kScreenWidth;
    }
    [UIView animateWithDuration:0.2 animations:^{self.tabBarView.frame = frame;} completion:nil];
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
