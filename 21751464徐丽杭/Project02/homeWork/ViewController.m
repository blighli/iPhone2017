//
//  ViewController.m
//  homeWork
//
//  Created by  丽杭 徐 on 2017/10/24.
//  Copyright © 2017年 丽杭 徐. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray* dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSource = [[NSMutableArray alloc]initWithCapacity:0];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (IBAction)add:(id)sender {
    NSString* work = self.textField.text;
    [self.dataSource addObject:work];
    self.textField.text=nil;
    
    [self.tab reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
