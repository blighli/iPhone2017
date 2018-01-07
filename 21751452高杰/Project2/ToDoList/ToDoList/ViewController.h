//
//  ViewController.h
//  ToDoList
//
//  Created by Yif-JJ on 2017/10/13.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"
@interface ViewController : UIViewController
<UITableViewDataSource>
@property ToDoItem *toDoItem;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *TextField;
- (IBAction)Add:(id)sender;
@property NSMutableArray *toDoItems;

@end

