//
//  HMSSubTagViewController.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/8.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSSubTagViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "HMSSubTagItem.h"
#import "HMSSubTagCell.h"

#import <SVProgressHUD/SVProgressHUD.h>

static NSString * const ID = @"cell";
@interface HMSSubTagViewController ()
@property (nonatomic, strong) NSArray *subTags;
@property (nonatomic, weak)AFHTTPSessionManager *mgr;

@end

@implementation HMSSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //展示标签数据 -> 请求数据 -> 解析数据 -> image_list theme_name sub_number ->展示数据
    [self loadData];
    [self.tableView registerNib:[UINib nibWithNibName:@"HMSSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    self.title = @"推荐标签";
    /*
     头像变圆角
        |- 设置头像圆角
        |- 裁剪图片
     处理数字 -> 超过万元处理
     */
    //处理cell分割线 1.自定义分割线 2.系统属性 3.重写cell的setFrame 了解tableView底层实现
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    //清空tableView分割线内边距 清空cell的约束边缘
    self.tableView.separatorInset = UIEdgeInsetsZero;
    //提示用户当前正在加载数据 SVPro
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    
}
//- (void) viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    HMSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.separatorInset));
//}
#pragma mark - 请求数据
- (void)loadData {
    //1.请求会话管理者
    _mgr = [AFHTTPSessionManager manager];
    
    _mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    //3.发送请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nullable responseObject) {
            //去除进度条
            [SVProgressHUD dismiss];
            
            //        [responseObject writeToFile:@"/Users/hekunyu/Desktop/tag.plist" atomically:YES];
            //字典数组转模型
            _subTags = [HMSSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
            //刷新表格
            [self.tableView reloadData];
            //        NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
        }];
    });
    
}
// 页面消失的时候调用
- (void)viewWillDisappear:(BOOL)animated {
    //去除进度条
    [SVProgressHUD dismiss];
    //取消之前的请求
    [_mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    [super viewWillDisappear: animated];
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
    return self.subTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //自定义cell
    static NSString *ID = @"cell";
    HMSSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //如果cell从xib加载，一定要记得绑定标识符 利用循环利用
    //还有一种注册cell
//    if(cell == nil) {
//        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HMSSubTagCell class]) owner:nil options:nil][0];
//    }
    //获取模型
    HMSSubTagItem *item = self.subTags[indexPath.row];
    cell.item = item;
//    cell.textLabel.text = item.theme_name;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
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
