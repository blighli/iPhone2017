//
//  HMSEssenceViewController.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/6.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSEssenceViewController.h"
#import "HMSTitleButton.h"
#import "HMSAllViewController.h"
#import "HMSPictureViewController.h"
#import "HMSVideoViewController.h"
#import "HMSVoiceViewController.h"
#import "HMSWordViewController.h"

@interface HMSEssenceViewController () <UIScrollViewDelegate>
/* 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/* 记录上一次点击的按钮 */
@property (nonatomic, weak) HMSTitleButton *previousClickedTitleButton;
/* 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/* 用来存放所有子控制器view */
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation HMSEssenceViewController

/*
 uiscrollview上面有5个uitableview
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化子控制器
    [self setupAllChildViews];
    
    // 设置导航条
    [self setupNavBar];
    
    // scrollView
    [self setupScrollView];
    
    // 标题栏
    [self setupTitlesView];
    
    [self addChildViewControllerIntoScrollView:0];
}
#pragma mark - 初始化
- (void)setupAllChildViews {
    [self addChildViewController:[[HMSAllViewController alloc]init]];
    [self addChildViewController:[[HMSPictureViewController alloc]init]];
    [self addChildViewController:[[HMSVideoViewController alloc]init]];
    [self addChildViewController:[[HMSVoiceViewController alloc]init]];
    [self addChildViewController:[[HMSWordViewController alloc]init]];
}
- (void)setupScrollView {
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
//    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO;//点击状态栏时，这个scrollView不会滚动到顶部
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 100, 50);
//    btn.backgroundColor = [UIColor blueColor];
//
//    [scrollView addSubview:btn];
    
//    for (NSUInteger i = 0 ; i < 5; i++) {
//        UITableView *tableView = [[UITableView alloc] init];
//        tableView.hms_width = scrollView.hms_width;
//        tableView.hms_height = scrollView.hms_height;
//        tableView.hms_y = 0;
//        tableView.hms_x = i * scrollView.hms_width;
//        tableView.backgroundColor = HMSRandomColor;
//        [scrollView addSubview:tableView];
//    }
    NSInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.hms_width;
//    CGFloat scrollViewH = scrollView.hms_height;
//    for (NSUInteger i = 0 ; i < count; i++) {
//        UIView *childViewControllerView = self.childViewControllers[i].view;
//        childViewControllerView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
//        [scrollView addSubview:childViewControllerView];
//    }
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
}
- (void)setupTitlesView {
    UIView *titlesView = [[UIView alloc] init];
    //设置半透明背景色
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];

    titlesView.frame = CGRectMake(0, 64, self.view.hms_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //标题栏按钮
    [self setupTitleButtons];
    //下划线
    [self setupTitleUnderline];
    
    
}
/*标题栏按钮*/
- (void)setupTitleButtons {
    //文字数组
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    //标题按钮的尺寸
    CGFloat titleButtonW = self.titlesView.hms_width / count;
    CGFloat titleButtonH = self.titlesView.hms_height;
    //创建5个标题按钮
    for (NSInteger i = 0 ; i < count; i++) {
        HMSTitleButton *titleButton = [[HMSTitleButton alloc] init];
        titleButton.tag = i;
        //事件
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        //文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        [self.titlesView addSubview:titleButton];
    }
}
/**
 标题下划线
 */
- (void)setupTitleUnderline {
    //标题按钮
    HMSTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.hms_height = 2;
    titleUnderline.hms_y = self.titlesView.hms_height - titleUnderline.hms_height;
    titleUnderline.hms_width = 70;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    
    [self.titlesView addSubview:titleUnderline];
    _titleUnderline = titleUnderline;
    
    //默认点击最前面的按钮
    [firstTitleButton.titleLabel sizeToFit];
    //处理下划线
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    self.titleUnderline.hms_width = firstTitleButton.titleLabel.hms_width + 8;
    self.titleUnderline.hms_centerX = firstTitleButton.hms_centerX;
}
#pragma mark - 监听按钮

/**
 点击标题按钮
 */
- (void)titleButtonClick:(HMSTitleButton *)titleButton {
    //重复点击了标题按钮
    if (self.previousClickedTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:HMSTitleButtonDidRepeatClickNotification object:nil];
    }
    /* 切换按钮状态 */
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    NSUInteger index = titleButton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        //处理下划线
        self.titleUnderline.hms_width = titleButton.titleLabel.hms_width + 8;
        self.titleUnderline.hms_centerX = titleButton.hms_centerX;
        //滚动scrollview到标题按钮对应的控制器view
        //控制偏移量
//        NSInteger index = [self.titlesView.subviews indexOfObject:titleButton];
        CGFloat offsetX = self.scrollView.hms_width * index;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
        
    } completion:^(BOOL finished) {
        //    CGFloat scrollViewH = scrollView.hms_height;
        //    for (NSUInteger i = 0 ; i < count; i++) {
        //        UIView *childViewControllerView = self.childViewControllers[i].view;
        //        childViewControllerView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        //        [scrollView addSubview:childViewControllerView];
        //    }
        //添加子控制器view
        [self addChildViewControllerIntoScrollView:index];
    }];
    // 设置index位置对应的tableView.scrollsToTop = YES， 其他都设置为NO
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        // 如果view还没有被创建，就不用去处理
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        scrollView.scrollsToTop = (i == index);
    }
}

#pragma mark - 设置导航条
- (void)setupNavBar{
    /*
     UIBarButtonItem: 描述按钮具体的内容
     UINavigationItem: 设置导航条上的内容(左边，右边，中间)
     tabBarItem: 设置tabBar上按钮内容（tabBarButton）
     */
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] addTarget:self action:@selector(game)];
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandomN"] highImage:[UIImage imageNamed:@"navigationButtonRandomClickN"] addTarget:self action:@selector(random)];
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}

- (void)game {
    HMSFunc;
}
- (void)random {
    HMSFunc;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - <UIScrollViewDelegate>
//速度减为0的滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.hms_width;
    //点击对应的按钮
    HMSTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleButtonClick:titleButton];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 其他
-(void)addChildViewControllerIntoScrollView:(NSInteger)index {
    UIView *childViewControllerView = self.childViewControllers[index].view;
    if(childViewControllerView.superview) return;
    
    childViewControllerView.frame = CGRectMake(self.scrollView.contentOffset.x, 0, self.scrollView.hms_width,self.scrollView.hms_height);
    [self.scrollView addSubview:childViewControllerView];
}

@end
