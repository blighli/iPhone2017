//
//  LoginScreen.m
//  TestNet
//
//  Created by Yif-JJ on 2017/9/20.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import "LoginScreen.h"
#import "RegisterScreen.h"
#import "MessageScreen.h"
#import "ProfileScreen.h"
#import "MainScreen.h"
#import "AlertTimer.h"
#import "UnderlineTextField.h"
#import <AFNetworking/AFNetworking.h>
#define img1 [UIImage imageNamed:@"checkbox-pressed"]
#define img2 [UIImage imageNamed:@"checkbox-checked"]
#define img3 [UIImage imageNamed:@"checkbox"]
#define accountDefaults [NSUserDefaults standardUserDefaults]
@interface LoginScreen ()<UITextFieldDelegate>
@property(nonatomic, strong) UIView *inputBackground;

@end
BOOL rememberSelected = YES;
BOOL autologinSelected = YES;

@implementation LoginScreen
@synthesize username = _username;
@synthesize password = _password;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    self.login.layer.cornerRadius = 5;
    self.reg.layer.cornerRadius =5;
    _username.backgroundColor = [UIColor clearColor];
    _username.textColor = [UIColor grayColor];
    _username.keyboardType = UIKeyboardTypeAlphabet;
    _password.backgroundColor = [UIColor clearColor];
    _password.textColor = [UIColor grayColor];
    _password.keyboardType = UIKeyboardTypeNumberPad;
    _password.secureTextEntry  =YES;


    BOOL remember = [accountDefaults boolForKey:@"rememberPwd"];
    if (remember) {
        [self.rememberPwd setImage:img2 forState:UIControlStateNormal];
        _username.text = [self getDefaultUserName];
        _password.text = [self getDefaultUserPwd];
    }
}

/*获取用户账号*/
- (NSString *)getDefaultUserName {
    NSString *defaultUser =
    [accountDefaults objectForKey:@"username"];
    return defaultUser;
}

/*获取用户密码*/
- (NSString *)getDefaultUserPwd {
    NSString *defaultUserPwd =
    [accountDefaults objectForKey:@"password"];
    return defaultUserPwd;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTap:(id)sender{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
}

- (IBAction)login:(id)sender {
    NSString *username = _username.text;
    NSString *password = _password.text;
    //请求的参数：即向服务器发送的参数，比如登录时的账号和密码
    NSDictionary *parameters = @{@"username":username,
                                 @"password":password,
                                 @"method":@"login",
                                 };
    //请求的网址：即请求的接口，这里的这个无效，具体的用你要用的
    NSString *urlString = @"http://localhost:8080/UserServlet";
    
    //请求的manager，我也不知道找什么词形容比较好，就理解成管理者吧
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    
    //进行POST请求
    [managers POST:urlString parameters:parameters
           success:^(NSURLSessionDataTask *task, id responseObject) {
        if(responseObject != nil){
            NSString *status = responseObject[@"status"];
            if ([status isEqual:@"1"]) {
                [accountDefaults setObject:_username.text forKey:@"username"];
                [accountDefaults setObject:_password.text forKey:@"password"];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                RegisterScreen  *mainVC  = [storyboard instantiateViewControllerWithIdentifier:@"main"];
                [self presentViewController:mainVC animated:YES completion:nil];
            }else{
                [AlertTimer alertWithTitle:@"提示" message:@"密码错误 请重新输入" inController:self];

            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        if(error != nil){
            [AlertTimer alertWithTitle:@"提示" message:@"服务器连接失败" inController:self];
        }
    }];
    

}

- (IBAction)reg:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    RegisterScreen  *regVC  = [storyboard instantiateViewControllerWithIdentifier:@"register"];
    [self presentViewController:regVC animated:YES completion:nil];
}

- (IBAction)autopressed:(id)sender {
    [self.autoLogin setImage:img1 forState:UIControlStateHighlighted];
}

- (IBAction)autoselected:(id)sender {
    if (autologinSelected) {
        [self.autoLogin setImage:img2 forState:UIControlStateNormal];
        autologinSelected = NO;
    }else if (autologinSelected == NO){
        [self.autoLogin setImage:img3 forState:UIControlStateNormal];
        autologinSelected = YES;
    }
}

- (IBAction)rememberpressed:(id)sender {
    [self.rememberPwd setImage:img1 forState:UIControlStateHighlighted];
}

- (IBAction)rememberselected:(id)sender {
    if (rememberSelected) {
        [self.rememberPwd setImage:img2 forState:UIControlStateNormal];
        [accountDefaults setBool:rememberSelected forKey:@"rememberPwd"];//添加bool类类型

        rememberSelected = NO;
    }else if (rememberSelected == NO){
        [self.rememberPwd setImage:img3 forState:UIControlStateNormal];
        rememberSelected = YES;
    }
}
@end
