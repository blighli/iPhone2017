//
//  ViewController.m
//  TaskList
//
//  Created by 周新哲 on 2017/10/19.
//  Copyright © 2017年 master. All rights reserved.
//

#import "ViewController.h"

NSString *docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

@interface MyViewController()
@property (weak, nonatomic) IBOutlet UITableView *taskTable;
@property (weak, nonatomic) IBOutlet UITextField *taskField;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = self.getAppDelegateInstance;
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        delegate.tasks = [plist mutableCopy];
    } else {
        delegate.tasks = [[NSMutableArray alloc] init];
    }
    [[self taskTable] setDataSource:self];
    [[self taskField] setDelegate:self];
    if ([[delegate tasks] count] == 0) {
        [[delegate tasks] addObject:@"Walk the dogs"];
        [[delegate tasks] addObject:@"Feed the hogs"];
        [[delegate tasks] addObject:@"Chop the logs"];
        NSLog(@"%ld",[[delegate tasks] count]);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *delegate = self.getAppDelegateInstance;
    return [[delegate tasks] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *delegate = self.getAppDelegateInstance;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    NSString *item = [[delegate tasks] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    return cell;
}
- (IBAction)addTask:(id)sender {
    AppDelegate *delegate = self.getAppDelegateInstance;
    NSString *text = [self.taskField text];
    if ([text isEqualToString:@""]) {
        return;
    }
    [[delegate tasks] addObject:text];
    [self.taskTable reloadData];
    [self.taskField setText:@""];
    [self.taskField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([[[self taskField] text] isEqualToString: @"Type a task, tap Insert"]) {
        [[self taskField] setText:@""];
    }
    [[self taskField] setTextColor:[UIColor blackColor]];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([[[self taskField] text] isEqualToString: @""]) {
        [[self taskField] setTextColor:[UIColor lightGrayColor]];
        [[self taskField] setText:@"Type a task, tap Insert"];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskField resignFirstResponder];
    return YES;
}

-(AppDelegate *)getAppDelegateInstance
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
