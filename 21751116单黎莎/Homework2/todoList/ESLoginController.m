//
//  ESLoginController.m
//  todoList
//
//  Created by Edith.S on 2017/10/17.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import "ESLoginController.h"
#import "MBProgressHUD+MJ.h"

@interface ESLoginController ()
- (IBAction)login;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UISwitch *rmbPwdSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)rmbPwdChange;
- (IBAction)autoLoginChange;

@end

@implementation ESLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pwdField setSecureTextEntry:YES];
    //监听通知：当文本框文字改变时发出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accountField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    //[self.pwdField resignFirstResponder];
    // Do any additional setup after loading the view.
}

//当文字发生改变是要做的事情：文本框文字发生变化时调用，用于控制按钮的状态
-(void)textChange{
    self.loginBtn.enabled = self.accountField.text.length && self.pwdField.text.length;
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

/**
 当点击登录按钮时调用
 */
- (IBAction)login {
    //账号：123 密码：123456
    if (![self.accountField.text isEqualToString:@"Edith.S"]){
        [MBProgressHUD showError:@"该账号不存在"];
        return;
    }
    else if(![self.pwdField.text isEqualToString:@"123456"]) {
        //提示错误
        [MBProgressHUD showError:@"密码错误"];
    }
    else{
        //使用蒙板着该页面
        [MBProgressHUD showMessage:@"Loading"];
        
        //在两秒之后执行代码块里的代码
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (1.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //移除遮盖
            [MBProgressHUD hideHUD];
            //跳转
            [self performSegueWithIdentifier:@"login2list" sender:nil];
        });
    }
}


/**
 执行segue后，跳转之前调用该方法
 一般用于给下一个控制器传递数据
 */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //    取得目标控制器（联系人列表控制器）
    UIViewController *contactVC = segue.destinationViewController;
    //    设置目标控制器的标题
    //    可以使用navigationItem.title，将账号文本输入框的text传递进去
    //contactVC.navigationController.title =[NSString stringWithFormat:@"%@的联系人", self.accountField.text];
    //    直接设置控制器的title，与上一个方法等价
    contactVC.title = [NSString stringWithFormat:@"%@的联系人", self.accountField.text];
}

- (IBAction)rmbPwdChange {
    if (self.rmbPwdSwitch.isOn == NO) {
        [self.autoLoginSwitch setOn:NO animated:YES];
        // self.autoLoginSwitch.on = NO;
    }
}

- (IBAction)autoLoginChange {
    if (self.autoLoginSwitch.isOn == YES) {
        [self.rmbPwdSwitch setOn:YES animated:YES];
    }
}
@end
