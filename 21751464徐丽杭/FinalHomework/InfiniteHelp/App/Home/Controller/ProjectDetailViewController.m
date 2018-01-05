//
//  ProjectDetailViewController.m
//  InfiniteHelp
//
//  Created by sands on 16/7/25.
//  Copyright © 2016年 sands. All rights reserved.
//

#import "ProjectDetailViewController.h"
#import "ProjectDetailCell.h"
@interface ProjectDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务详情";
    [self.ProjectTabel registerNib:[UINib nibWithNibName:@"ProjectDetailCell" bundle:nil] forCellReuseIdentifier:@"ProjectDetailCell"];
}



#pragma mark tableview Datasourece delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 420;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProjectDetailCell* cell = (ProjectDetailCell*)[tableView dequeueReusableCellWithIdentifier:@"ProjectDetailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
