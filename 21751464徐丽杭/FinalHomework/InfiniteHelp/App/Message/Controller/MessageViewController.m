
//
//  MessageViewController.m
//  InfiniteHelp
//
//  Created by joker on 2017/11/30.
//  Copyright © 2017年 sands. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "MessageVcTitleView.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource,MessageVcTitleViewDelegate>

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:241.0/255.0 alpha:1];
    [self AddNavigationTitleView];
    [self SettingProjectTab];
}

- (void)SettingProjectTab{
    [self.Tab registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCell"];
    self.Tab.separatorStyle = NO;
    self.Tab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.Tab.backgroundColor = [UIColor clearColor];
}

#pragma mark tablView datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 111;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 导航栏内容
- (void)AddNavigationTitleView {
    MessageVcTitleView* titleView = [[[NSBundle mainBundle] loadNibNamed:@"MessageVcTitleView" owner:self options:nil]lastObject];
    titleView.frame = CGRectMake(0, 0, kScreenWidth, 44);
    titleView.delegate = self;
    self.navigationItem.titleView = titleView;
}

#pragma mark MessageVcTitleViewDelegate
- (void)ButtonOneClick{
    NSLog(@"ButtonOneClick");
}

-(void)ButtonTwoClick{
    NSLog(@"ButtonTwoClick");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
