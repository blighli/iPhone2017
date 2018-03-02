//
//  MainViewController.m
//  InfiniteHelp
//
//  Created by sands on 16/7/18.
//  Copyright © 2016年 sands. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITabBarControllerDelegate>{
    UIButton* _AddButton;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.tabBar.translucent = NO;
    [self InitAddButton];
}

/**
 *  发布按钮
 */
- (void)InitAddButton{
    
    UILabel* Line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, 0.5)];
    Line.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    [self.tabBar addSubview:Line];
    
    _AddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat Width = self.tabBar.frame.size.width/5;
    _AddButton.frame = CGRectMake(Width*2, -25, 65, 65);
    _AddButton.center = CGPointMake(self.tabBar.frame.size.width/2, self.tabBar.frame.size.height/2-16);
    [_AddButton setBackgroundImage:[UIImage imageNamed:@"发布按钮"] forState:UIControlStateNormal];
    [_AddButton addTarget:self action:@selector(AddButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:_AddButton];
    [self SettingShadowImage];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (viewController == [tabBarController.viewControllers objectAtIndex:2]) //assuming the index of uinavigationcontroller is 2
    {
        return NO;
    }
    else {
        return YES;
    }
}

- (void)AddButtonClick{
    NSLog(@"AddButtonClick");
}

- (void)SettingShadowImage{
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, self.tabBar.bounds.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
}

@end
