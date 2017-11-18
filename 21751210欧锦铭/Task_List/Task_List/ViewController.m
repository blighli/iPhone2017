//
//  ViewController.m
//  Task_List
//
//  Created by ououou on 2017/10/26.
//  Copyright © 2017年 ououou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *taskField;
@property (weak, nonatomic) IBOutlet UIButton *insertButton;
@property (weak, nonatomic) IBOutlet UITableView *taskTable;
@property (nonatomic,strong) NSMutableArray *tasks;

@end

@implementation ViewController

#pragma mark- Life Cycle

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tasks = [NSMutableArray array];
}

#pragma mark- Event Response

- (IBAction)insertData:(UIButton *)sender {
    NSString *text = [self.taskField text]; //从输入框获取新的任务
    if ([text  isEqualToString:@""]) {
        return; //如果是空的什么也不做
    }
    
    [self.tasks addObject: text]; //将新的任务添加到模型
    [self.tasks writeToFile:[self docPath] atomically:YES];
    
    [self.taskTable reloadData]; //表格视图重新载入数据
    [self.taskField setText:@""]; //清空输入框
    [self.taskField resignFirstResponder]; //关闭软键盘
    
}

#pragma mark- Private method

-(NSString *)docPath
{
    
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(
                                                            NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0]
            stringByAppendingPathComponent:@"data.txt"];
}

#pragma mark- UITableViewDelegate, UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self getTasks] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.taskTable dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell ) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"cellID"];
    }
    NSString *item = [[self getTasks] objectAtIndex: [indexPath row]];
    cell.textLabel.text = item;
    return cell ;
}

#pragma mark- getter and setter

-(NSMutableArray *)getTasks
{
    NSArray *plist = [NSArray arrayWithContentsOfFile:[self docPath]];
    if (plist)
    {
        return [plist mutableCopy];
    } else{
        return [NSMutableArray array];
    }
}

@end
