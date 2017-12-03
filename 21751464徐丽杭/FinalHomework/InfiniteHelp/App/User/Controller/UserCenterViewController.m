//
//  UserCenterViewController.m
//  InfiniteHelp
//
//  Created by joker on 2017/11/30.
//  Copyright © 2017年 sands. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserHeadView.h"
#import "LoginViewController.h"

@interface UserCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView* tab;
@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setUpTable];
    [self setUpHeadView];
}

- (void)setUpTable {
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tab.backgroundColor = [UIColor clearColor];
    self.tab.delegate = self;
    [self.view addSubview:self.tab];
}

- (void)setUpHeadView {
    UserHeadView* headView = [[[NSBundle mainBundle] loadNibNamed:@"UserHeadView" owner:self options:nil]lastObject];
    headView.frame = CGRectMake(0, 0, kScreenWidth, 250);
    [headView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    self.tab.tableHeaderView = headView;
}

- (void)loginAction{
    LoginViewController* Login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self presentViewController:Login animated:true completion:nil];
}

#pragma mark tablView datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
