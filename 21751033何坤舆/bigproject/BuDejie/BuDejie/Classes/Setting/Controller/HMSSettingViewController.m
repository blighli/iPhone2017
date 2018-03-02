//
//  HMSSettingViewController.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/7.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSSettingViewController.h"
#import <SDWebImage/SDImageCache.h>
#import "HMSFileTool.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@interface HMSSettingViewController ()
@property (nonatomic, assign) NSInteger totalSize;
@end

@implementation HMSSettingViewController
static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"设置";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    [SVProgressHUD showWithStatus:@"正在计算缓存大小..."];
    
    [HMSFileTool getFileSize:CachePath completion:^(NSInteger totalSize){
        //在子线程不能刷新UI界面 -> 回到子线程刷新
        _totalSize = totalSize;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    // 计算整个应用的缓存数据 => 沙盒(Cache) => 获取cache文件夹尺寸
    
   
    // SDWebImage: 帮我们做了缓存
    NSInteger size = [SDImageCache sharedImageCache].getSize;
    NSLog(@"%ld", size);
    
    
    cell.textLabel.text = [self sizeStr];
    return cell;
}
// 点击cell就会调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除文件夹所有文件
    [HMSFileTool removeDirectoryPath:CachePath];
    _totalSize = 0;
    [self.tableView reloadData];
}
- (NSString *)sizeStr {
    NSInteger totalSize = _totalSize;
    NSString *sizeStr = @"清除缓存";
    //mb kb b
    if (totalSize > 1000 * 1000) {
        //mb
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    } else if (totalSize > 1000) {
        //kb
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    } else if (totalSize > 0) {
        //b
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    return sizeStr;
}
/*
 业务类： 以后开发中专门用来处理某件事情，网络处理，缓存处理
 */


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
