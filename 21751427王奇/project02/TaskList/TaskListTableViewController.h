//
//  ViewController.h
//  TaskList
//
//  Created by 王奇 on 2017/10/24.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListModel.h"

@interface TaskListTableViewController : UITableViewController

@property (nonatomic) id<ListModel> taskList;

@end

