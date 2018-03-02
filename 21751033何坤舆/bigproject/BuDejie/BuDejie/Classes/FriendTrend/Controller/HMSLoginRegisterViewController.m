//
//  HMSLoginRegisterViewController.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/8.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSLoginRegisterViewController.h"
#import "HMSLoginRegisterView.h"
#import "HMSFastLoginView.h"

@interface HMSLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadConstraint;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation HMSLoginRegisterViewController
/*
 1. 划分结构 （顶部、中间、底部）
 2. 一个结构一个结构搭建 越复杂的界面越要封装（复用）
 3.
 */
- (IBAction)clickReigster:(UIButton *)sender {
    sender.selected = !sender.selected;
    //平移中间view
    _leadConstraint.constant = _leadConstraint.constant == 0 ? -self.middleView.hms_width * 0.5 : 0;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*
     屏幕适配：
     1.一个view从xib加载，需不需要重新固定尺寸 需要再确定一下
     2.在viewDidLoad设置好不好？开发中一般在viewDidLayoutSubviews布局子控件
     
     */
    //创建登录的view
    HMSLoginRegisterView *loginView = [HMSLoginRegisterView loginView];
    
    //添加到中间的view
    [self.middleView addSubview:loginView];
    
    //添加注册界面
    HMSLoginRegisterView *registerView = [HMSLoginRegisterView registerView];
    
    registerView.hms_x = self.middleView.hms_width * 0.5;
    //添加到中间的view
    [self.middleView addSubview:registerView];
    
    //添加快速登录界面
    HMSFastLoginView *fastLoginView = [HMSFastLoginView fastLoginView];
    //添加到底部的view
    [self.bottomView addSubview:fastLoginView];
    
   
    
    
}
//会调用多次 用来设置控件 会根据布局调整控件的尺寸
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    HMSLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.hms_width * 0.5, self.middleView.hms_height);
    
    HMSLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.hms_width * 0.5, 0, self.middleView.hms_width * 0.5, self.middleView.hms_height);
    
    HMSFastLoginView *fastLoginView = self.middleView.subviews.firstObject;
    fastLoginView.frame = self.bottomView.bounds;
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
