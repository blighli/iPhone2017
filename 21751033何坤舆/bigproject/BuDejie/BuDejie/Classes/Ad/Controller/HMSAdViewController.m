//
//  HMSAdViewController.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/7.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSAdViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "HMSADItem.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "HMSTabBarController.h"

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"
@interface HMSAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *LauchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (weak, nonatomic) UIImageView *adView;
@property (strong, nonatomic) HMSADItem *item;
@property (weak, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@end

@implementation HMSAdViewController

- (UIImageView *)adView {
    if (_adView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.adContainView addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        
        _adView = imageView;
    }
    return _adView;
}
// 点击广告界面调用
- (void)tap {
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if([app canOpenURL:url]) {
        [app openURL:url];
    }
    //跳转到界面 => 用safari跳转
    
}
/*
 1. 以后添加东西，首先想到加多少次
 2.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /* 启动图片适配
     6p: LaunchImage-800-Portrait-736h@3x.png
     6: LaunchImage-800-667h@2x.png
     5: LaunchImage-568h@2x.png
     4: LaunchImage@2x.png
    */
    [self setupLaunchImage];
    /* 加载广告数据 => 拿到活时间 => 服务器 => 看接口文档 => 解析数据 =>(AFN)
     w_picurl:图片地址
     ori_curl:跳转连接
     w:图片宽
     h:图片高
        导入AFN框架:cocodpods 导入一个框架，会把这个框架依赖的所有框架都导入
        podfile：描述需要导入哪些框架
     */
    [self addAdData];
    //创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}
- (void)timeChange{
    // 倒计时
//    HMSFunc;
    static int i = 3;
    // 设置跳转按钮文字
    if(i == 0) {
        [self clickJump:nil];
    }
    i--;
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%d)",i] forState: UIControlStateNormal];
}
- (IBAction)clickJump:(id)sender {
    //销毁广告界面 进入主框架界面
    HMSTabBarController *tabBarViewController = [[HMSTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarViewController;
    //干掉定时器
    [_timer invalidate];
}
#pragma mark - 加载广告数据
- (void)addAdData {
    // 1.创建请求会话管理者
    // unacceptable content-type: text/html 相应头
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"code2"] = code2;
    
    // 3.发送请求
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
//        [responseObject writeToFile:@"/Users/hekunyu/Desktop/ad.plist" atomically:YES];
        //请求数据 -> 解析数据 -> 设计模型 ->展示数据
//        NSLog(@"%@",responseObject);
        //获取字典
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        //字典转模型
        NSManagedObjectContext *context = nil;
        _item = [HMSADItem mj_objectWithKeyValues:adDict context:context];
        //创建UIImageView展示图片 等比例缩放
        CGFloat h = HMSScreenW / _item.w * _item.h;
        self.adView.frame = CGRectMake(0, 0, HMSScreenW, h);
        //加载广告网页
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
//        NSLog(@"%@",_item);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    //
}
- (void)setupLaunchImage {
    if(iphone6P){ //6p
        self.LauchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x.png"];
    } else if(iphone6) { //6
        self.LauchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x.png"];
    } else if(iphone5) { //5
        self.LauchImageView.image = [UIImage imageNamed:@"LaunchImage-568h@2x.png"];
    } else if (iphone4) { //4
        self.LauchImageView.image = [UIImage imageNamed:@"LaunchImage@2x.png"];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
