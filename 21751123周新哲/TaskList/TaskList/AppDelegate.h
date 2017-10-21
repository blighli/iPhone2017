//
//  AppDelegate.h
//  TaskList
//
//  Created by 周新哲 on 2017/10/19.
//  Copyright © 2017年 master. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property NSMutableArray *tasks;

@end

