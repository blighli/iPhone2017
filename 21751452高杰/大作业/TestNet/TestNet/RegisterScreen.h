//
//  RegisterScreen.h
//  TestNet
//
//  Created by Yif-JJ on 2017/9/20.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STLVideoViewController.h"
@interface RegisterScreen : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repassword;
- (IBAction)back:(id)sender;
- (IBAction)register:(id)sender;

@end
