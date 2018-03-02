//
//  HMSAllViewController.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/11.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSAllViewController.h"

@interface HMSAllViewController ()
/* 数据量 */
@property (nonatomic, assign) NSInteger dataCount;
/* 上拉刷新控件 */
@property (nonatomic, weak) UIView *footer;
/* 上拉刷新控件 */
@property (nonatomic, weak) UILabel *footerLabel;
/* 上拉刷新控件时候正在刷新 */
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
@end

@implementation HMSAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataCount = 30;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = HMSRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:HMSTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:HMSTitleButtonDidRepeatClickNotification object:nil];
    
    [self setupRefresh];
    
}
#pragma mark - 监听
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupRefresh {
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, self.tableView.hms_width, 35);
    self.footer = footer;
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.frame = footer.bounds;
    footerLabel.backgroundColor = [UIColor redColor];
    footerLabel.text = @"上拉可以加载更多";
    footerLabel.textColor = [UIColor whiteColor];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:footerLabel];
    self.footerLabel = footerLabel;
    
    self.tableView.tableFooterView = footer;
}
#pragma mark - 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(self.tableView.contentSize.height == 0) return;
    CGFloat ofsetY = self.tableView.contentSize.height + 50 - self.tableView.hms_height;
    // 如果正在刷新，直接返回
    if (self.isFooterRefreshing) return;
    
    
    if(self.tableView.contentOffset.y >= ofsetY) {
        // 进入刷新状态
//        HMSLog(@"footer已经完全出现");
        self.footerRefreshing = YES;
        self.footerLabel.text = @"正在加载更多数据...";
        self.footerLabel.backgroundColor = [UIColor blueColor];
        
        // 发送请求给服务器
//        HMSLog(@"发送请求给服务器");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //服务器请求回归
            self.dataCount += 5;
            [self.tableView reloadData];
            //结束刷新
            self.footerRefreshing = NO;
            self.footerLabel.text = @"上拉可以加载更多";
            self.footerLabel.backgroundColor = [UIColor redColor];
            
        });
    }
}

-(void)tabBarButtonDidRepeatClick{
    //if (重复点击的不是精华按钮) return;
    if (self.view.window == nil) return;
    
    //if (显示在正中间的不是AllViewController) return;
    if (self.tableView.scrollsToTop == NO) return;
    
    HMSLog(@"%@ - 刷新数据", self.class);
}
/* 监听titleButton重复点击 */
-(void)titleButtonDidRepeatClick{
    [self tabBarButtonDidRepeatClick];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.footer.hidden = (self.dataCount == 0);
    return self.dataCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"text-%zd", indexPath.row];
    return cell;
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
