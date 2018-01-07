//
//  MainScreen.h
//  TestNet
//
//  Created by Yif-JJ on 2017/9/20.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScreen : UITabBarController
@property (weak, nonatomic) IBOutlet UITabBar *tabBarView;
- (void)showTabBar:(BOOL)show;

@end
