//
//  ESTodoListController.m
//  todoList
//
//  Created by Edith.S on 2017/10/17.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import "ESTodoListController.h"
#define ESFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"things.plist"]
@interface ESTodoListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)add:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray* todoArray;

@end

@implementation ESTodoListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.textField];
    //[self todoArray];
    //[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray*)todoArray{
    if (_todoArray == nil) {
        //从文件中读取
        _todoArray = [NSKeyedUnarchiver unarchiveObjectWithFile:ESFilepath];
        if (_todoArray == nil) { // 文件不存在
            _todoArray = [NSMutableArray array];
        }
        //NSLog(@"%lu",_todoArray.count);
    }
    
    return _todoArray;
}


-(void)textChange{
    self.addBtn.enabled = self.textField.text.length;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)add:(UIButton *)sender {
    [self.textField resignFirstResponder];
    [self.todoArray addObject:self.textField.text];
    self.textField.text = nil;
    self.addBtn.enabled = NO;
    [NSKeyedArchiver archiveRootObject:self.todoArray toFile:ESFilepath];
    [self.tableView reloadData];
}

#pragma mark - tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)self.todoArray.count);
    return self.todoArray.count;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除模型
    [self.todoArray removeObjectAtIndex:indexPath.row];
    //刷新列表
    [self.tableView deleteRowsAtIndexPaths:@[indexPath ] withRowAnimation:UITableViewRowAnimationLeft];
    
    [NSKeyedArchiver archiveRootObject:self.todoArray toFile:ESFilepath];
}

#pragma mark - tableVie数据源方法
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"listCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.todoArray[indexPath.row];
    return cell;
}



@end
