//
//  LoginScreen.h
//  TestNet
//
//  Created by Yif-JJ on 2017/9/20.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "STLVideoViewController.h"
@interface LoginScreen : STLVideoViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *login;

- (IBAction)reg:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *reg;

@property (weak, nonatomic) IBOutlet UIButton *autoLogin;
@property (weak, nonatomic) IBOutlet UIButton *rememberPwd;
- (IBAction)autopressed:(id)sender;

- (IBAction)autoselected:(id)sender;
- (IBAction)rememberpressed:(id)sender;

- (IBAction)rememberselected:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *top_logo;

@end
