//
//  ESContactsTableViewController.m
//  私人通讯录
//
//  Created by Edith.S on 2017/9/26.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import "ESContactsTableViewController.h"
#import "ESAddViewController.h"
#import "ESContact.h"
#import "ESEditViewController.h"
#import "ESContactTableViewCell.h"

//文件路径
#define ESPath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contact.data"]

@interface ESContactsTableViewController () <UIActionSheetDelegate, ESAddViewControllerDelegate,ESEditViewControllerDelegate>

- (IBAction)logout:(UIButton *)sender;
- (IBAction)addContact;

@property (strong,nonatomic) NSMutableArray* contactArray;

@end

@implementation ESContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[MBProgressHUD hideHUD];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray*) contactArray{
    if (_contactArray == nil) {
        //NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contact.data"];
        //从文件中读取
        _contactArray = [NSKeyedUnarchiver unarchiveObjectWithFile:ESPath];
        //如果文件不存在，则创建array
        if(_contactArray == nil){
        _contactArray = [NSMutableArray array];
        }
    }
    return  _contactArray;
}

/**
  根据目的控制器的类型来执行相应的跳转
 */
    
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //NSLog(@"prepare for segue");
    if ([segue.destinationViewController isKindOfClass:[ESAddViewController class]]) {
        ESAddViewController *addVc = segue.destinationViewController;
        addVc.delegate = self;
    }else if([segue.destinationViewController isKindOfClass:[ESEditViewController class]]) {
        //跳转到editView
        ESEditViewController *editVc = segue.destinationViewController;
        //传递被点击行的数据
        editVc.contact = self.contactArray[[self.tableView indexPathForSelectedRow].row];
        editVc.delegate = self;
    }

}

/**
 点击注销按钮时调用
 弹出UIActionSheet，并进行初始化
 */
- (IBAction)logout:(UIButton *)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定注销？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}

- (IBAction)addContact {
    [self performSegueWithIdentifier:@"addContact" sender:nil];
}


#pragma mark - editViewController的代理方法
-(void)editViewController:(ESEditViewController*)editVc didSaveContact:(ESContact*)contact{
    [self.tableView reloadData];
    [NSKeyedArchiver archiveRootObject:self.contactArray toFile:ESPath];
}

#pragma mark - addViewController的代理方法

/**
 contactsView拿到数据，刷新表格
 */
-(void)addViewController:(ESAddViewController*)addVc didAddContact:(ESContact*)contact{
    //添加模型数据
    [self.contactArray addObject:contact];
    //刷新表格
    [self.tableView reloadData];
    //存储
    [NSKeyedArchiver archiveRootObject:self.contactArray toFile:ESPath];
}

#pragma mark - actionSheet的代理方法

/**
 监听actionSheet的按钮的点击事件

 @param actionSheet 弹窗
 @param buttonIndex 被点击的按钮的索引值
 */
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {//如果点击的是确定按钮
        //返回上个界面
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactArray.count;
}

/**
 数据源方法：创建cell，设置cell数据
 将接受到的数据添加到数组中，刷新数据
 设置cell.accessoryType，使行右侧出现箭头
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    ESContactTableViewCell *cell = [ESContactTableViewCell cellWithTableView:tableView];
    //设置数据
    NSLog(@"%lu",self.contactArray.count);
    NSLog(@"%@",[self.contactArray.lastObject class]);
    cell.contact = self.contactArray[indexPath.row];
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - tableView 代理方法

/**
实现左滑删除功能，点击删除就会调用

 @param editingStyle 编辑的行为（添加\删除)
 @param indexPath 操作的行号
 */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除模型
        [self.contactArray removeObjectAtIndex:indexPath.row];
        //刷新表格— —刷新删除行以后的行
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        //存储
        [NSKeyedArchiver archiveRootObject:self.contactArray toFile:ESPath];
    }
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
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
