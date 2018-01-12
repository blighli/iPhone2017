//
//  ESAddViewController.m
//  私人通讯录
//
//  Created by Edith.S on 2017/9/26.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import "ESAddViewController.h"
#import "ESContact.h"

@interface ESAddViewController ()

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *tagField;

- (IBAction)add;

@end

@implementation ESAddViewController

-(void) viewDidLoad{
    //在viewDidLoad中监听两个文本框，当文字改变的时候，改变按钮的enable状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.tagField];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/**
 点击添加按钮，将新的信息传递回上一个控制器

 */
- (IBAction)add {
    //关闭当前控制器：出栈
    [self.navigationController popViewControllerAnimated:YES];
    //使用代理传递数据给上一个控制器,使联系人列表成为addView的代理,当被点击，通知代理，将当前控制器、name、phone打包成模型传出去
    if ([self.delegate respondsToSelector:@selector(addViewController:didAddContact:)]) {
        ESContact *contact = [[ESContact alloc] init];
        contact.name = self.nameField.text;
        contact.phone = self.phoneField.text;
        contact.contactTag = self.tagField.text;
        [self.delegate addViewController:self didAddContact:contact];
    }

}

//一点击添加进入添加界面时。默认弹出键盘：当控制器的view完全加载完全之后viewDidAppear，使姓名文本框成为第一响应becomeFirstResponder
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.nameField becomeFirstResponder];
}

-(void)textChange{
    self.addBtn.enabled = self.nameField.text.length && self.phoneField.text.length&&self.tagField.text.length;
}

@end
