//
//  ViewController.h
//  TaskList
//
//  Created by 周新哲 on 2017/10/19.
//  Copyright © 2017年 master. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NSString *docPath(void);

@interface MyViewController : UIViewController<UITableViewDataSource,UITextFieldDelegate>

-(AppDelegate *)getAppDelegateInstance;
@end

