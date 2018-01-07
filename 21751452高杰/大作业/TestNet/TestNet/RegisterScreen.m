//
//  RegisterScreen.m
//  TestNet
//
//  Created by Yif-JJ on 2017/9/20.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import "RegisterScreen.h"
#import "LoginScreen.h"
#import <AFNetworking/AFNetworking.h>
#import "AlertTimer.h"
@interface RegisterScreen ()

@end

@implementation RegisterScreen
@synthesize username = _username;
@synthesize password = _password;
@synthesize repassword = _repassword;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _username.backgroundColor = [UIColor clearColor];
    _password.backgroundColor = [UIColor clearColor];
    _repassword.backgroundColor = [UIColor clearColor];
    _password.secureTextEntry = YES;
    _repassword.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)back:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginScreen  *logVC  = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self presentViewController:logVC animated:YES completion:nil];

}

- (IBAction)register:(id)sender {
    NSString *username = _username.text;
    NSString *password = _password.text;
    NSString *repassword = _repassword.text;
    if(![password isEqualToString:repassword]){
        [AlertTimer alertWithTitle:@"提示" message:@"2次密码输入不一致" inController:self];
    }else if(username.length>0&&password.length>0){
        //请求的参数：即向服务器发送的参数，比如注册时的账号和密码
        NSDictionary *parameters = @{@"username":username,
                                     @"password":password,
                                     @"method":@"register",
                                     };
        //请求的网址：即请求的接口，这里的这个无效，具体的用你要用的
        NSString *urlString = @"http://localhost:8080/UserServlet";
        //请求的manager，我也不知道找什么词形容比较好，就理解成管理者吧
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        
        //进行POST请求
        [managers POST:urlString parameters:parameters
            success:^(NSURLSessionDataTask *task, id responseObject){
                if(responseObject != nil){
                    NSString *status = responseObject[@"status"];
                    if ([status isEqual:@"1"]) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }else{
                        [AlertTimer alertWithTitle:@"提示" message:@"用户名已存在" inController:self];

                    }
                }
            } failure:^(NSURLSessionDataTask *task, NSError * error) {
                if(error != nil){
                    [AlertTimer alertWithTitle:@"提示" message:@"服务器连接失败" inController:self];
                }
            }];
    }else if(username.length==0||password.length==0){
        [AlertTimer alertWithTitle:@"提示" message:@"用户名与密码不能为空" inController:self];
    }

}

@end
