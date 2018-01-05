//
//  ProjectListViewController.m
//  InfiniteHelp
//
//  Created by sands on 16/7/22.
//  Copyright © 2016年 sands. All rights reserved.
//

#import "ProjectListViewController.h"
#import "ProjectTabVCell.h"
#import "ProjectVcTitleView.h"

@interface ProjectListViewController ()<UITableViewDelegate,UITableViewDataSource,ProjectVcTitleViewDelegate>{
    CGFloat cellHeight;
}
@end

@implementation ProjectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self AddNavigationTitleView];
    [self SettingProjectTab];
}

- (void)SettingProjectTab{
    cellHeight = (kScreenWidth-24)*0.6+74;
    [self.ProjectTab registerNib:[UINib nibWithNibName:@"ProjectTabVCell" bundle:nil] forCellReuseIdentifier:@"ProjectTabVCell"];
    self.ProjectTab.separatorStyle = NO;
    self.ProjectTab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.ProjectTab.backgroundColor = [UIColor clearColor];
}

#pragma mark 导航栏内容
- (void)AddNavigationTitleView {
    ProjectVcTitleView* titleView = [[[NSBundle mainBundle] loadNibNamed:@"ProjectVcTitleView" owner:self options:nil]lastObject];
    titleView.frame = CGRectMake(0, 0, kScreenWidth, 44);
    titleView.delegate = self;
    self.navigationItem.titleView = titleView;
}

#pragma mark tablView datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProjectTabVCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectTabVCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark ProjectVcTitleViewDelegate
- (void)ButtonOneClick{
    NSLog(@"ButtonOneClick");
}

-(void)ButtonTwoClick{
    NSLog(@"ButtonTwoClick");
}

@end
