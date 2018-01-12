//
//  HMSMeViewController.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/6.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSMeViewController.h"
#import "HMSSettingViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "HMSSquareItem.h"
#import <MJExtension/MJExtension.h>
#import "HMSSquareCollectionCell.h"
#import <SafariServices/SafariServices.h>
#import <WebKit/WebKit.h>

static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (HMSScreenW - (cols - 1) * margin) / cols

@interface HMSMeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSMutableArray *squareItems;
@property (weak, nonatomic) UICollectionView *collectionView;
@end

@implementation HMSMeViewController
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"%@", NSStringFromCGRect(cell.frame));
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // 设置导航条
    [self setupNavBar];
    
    // 设置tableView底部视图
    [self setupFootView];
    
    // 请求数据
    [self loadData];
    
    /* 细节
     1. collectionView高度重新计算 => 高度需要根据内容去计算 => 有数据了 需要再计算高度
     2. collectionView不需要滚动
     */
    
    //处理cell间距，默认tableView分组样式，有额外头部和尾部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}
#pragma mark - 请求数据
- (void)loadData {
    //1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    //2.拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    //3.发送请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        [responseObject writeToFile:@"/Users/hekunyu/Desktop/square.plist" atomically:YES];
        NSArray *dicArr = responseObject[@"square_list"];
        //去重
        NSMutableArray *nameArr = [[NSMutableArray alloc]init];
        NSMutableArray *listAry = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in dicArr) {
            if (![nameArr containsObject:dic[@"name"]]) {
                [nameArr addObject:dic[@"name"]];
                [listAry addObject:dic];
            }
        }
        
        //字典数组转化成模型数组
        _squareItems = [HMSSquareItem mj_objectArrayWithKeyValuesArray:listAry];
        
        //处理数据 填满
        [self resolveData];
        
        //设置collectionView 计算collectionView高度 = rows * itemWH
        //rows = (count - 1) / cols + 1
        NSInteger count = _squareItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        self.collectionView.hms_height = rows * itemWH;
        //设置tableView滚动范围增加
        self.tableView.tableFooterView = self.collectionView;
        
        //刷新表格
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 处理请求完成的数据
- (void)resolveData {
    NSInteger count = self.squareItems.count;
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter ; i++) {
            HMSSquareItem *item = [[HMSSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
}
#pragma mark - 设置tableView底部视图
- (void)setupFootView {
    /*
     1. 初始化要设置流水布局
     2. cell必须要注册
     3. cell必须自定义
     */
    //创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置cell尺寸
    
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
   
    //创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    
    collectionView.dataSource = self;
    collectionView.scrollEnabled = NO;
    collectionView.delegate = self;
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"HMSSquareCollectionCell" bundle:nil] forCellWithReuseIdentifier:ID];
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HMSLog(@"点击");
    //跳转界面 push展示网页
    /*
     1. safari openURL (自带很多功能)
     2. UIWebView (没有功能)
     3. 需求：既想要在当前应用展示网页，又要有对应功能
       3.1 导入SFSafariViewController
     4. WKWebView iOS8 （UIWebView升级版本，添加功能 1监听进度，2缓存）
     
     */
    HMSSquareItem *item = self.squareItems[indexPath.row];
    if (![item.url containsString:@"http"]) return;
    NSURL *url = [NSURL URLWithString:item.url];
    //SFSafariViewController推荐使用modal
    SFSafariViewController *safariViewController = [[SFSafariViewController alloc]initWithURL:url];
//    safariViewController.delegate = self;
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:safariViewController animated:YES];
    [self presentViewController:safariViewController animated:YES completion:nil];
    
}
//#pragma mark - SFSafariViewControllerDelegate
//-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
//    [self.navigationController popViewControllerAnimated:YES];
//}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 从缓存池取
    HMSSquareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.item = self.squareItems[indexPath.row];
    
    return cell;
}

#pragma mark - 设置导航条
- (void)setupNavBar{
    /*
     UIBarButtonItem: 描述按钮具体的内容
     UINavigationItem: 设置导航条上的内容(左边，右边，中间)
     tabBarItem: 设置tabBar上按钮内容（tabBarButton）
     */
    // 夜间模式
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] addTarget:self action:@selector(night:)];
    // 设置
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] addTarget:self action:@selector(setting)];
    // 右边按钮
    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];
    // titleView
    self.navigationItem.title = @"我的";
}
#pragma mark - 设置调用
- (void)setting {
    HMSFunc;
    //跳转到设置界面
    HMSSettingViewController *settingViewController = [[HMSSettingViewController alloc] init];
//    settingViewController.hidesBottomBarWhenPushed = YES;// 该属性必须在跳转之前设置
    
    [self.navigationController pushViewController:settingViewController animated:YES];
    /*
     1. 底部条没有隐藏
     2. 处理返回按钮的样式 1. 通过上一个控制器设置 2.当前控制器 导航条左边按钮设置
     */
    
}
- (void)night:(UIButton *)button{
    HMSFunc;
    button.selected = !button.selected;
}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
