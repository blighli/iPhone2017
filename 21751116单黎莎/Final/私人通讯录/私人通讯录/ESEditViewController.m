//
//  ESEditViewController.m
//  私人通讯录
//
//  Created by Edith.S on 2017/9/26.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

/*
 实现按钮的点击事件：判断点击的是取消还是编辑，取消的话，文本框变回原来的状态（文本框不可点、显示为原来文字）
 细节完善：进入编辑模式之后，根据文本框中的文字，判断保存按钮是否可点
 点击保存按钮，传递数据回contactView
 更新模型数据
 使用代理传递数据
 在contactView中实现代理方法：刷新列表
 */

#import "ESEditViewController.h"
#import "ESContact.h"

@interface ESEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *tagField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtn;
- (IBAction)edit:(id)sender;
- (IBAction)save;

@end

@implementation ESEditViewController


/**
 为编辑界面的文本框设置数据：在viewDidLoad中设置文本框的text
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameField.text = self.contact.name;
    self.phoneField.text = self.contact.phone;
    self.tagField.text = self.contact.contactTag;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.tagField];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textChange{
    self.addBtn.enabled = self.nameField.text.length && self.phoneField.text.length;
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
 点击保存按钮，传递数据回contactView, 更新模型数据
 */
- (IBAction)save {
    //关闭当前页面
    [self.navigationController popViewControllerAnimated:YES];
    //通知代理传递数据
    if ([self.delegate respondsToSelector:@selector(editViewController:didSaveContact:)]) {
        //保存输入后的数据
        self.contact.name = self.nameField.text;
        self.contact.phone = self.phoneField.text;
        self.contact.contactTag = self.tagField.text;
        [self.delegate editViewController:self didSaveContact:self.contact];
    }
}


/**
 点击编辑使文本框可输入, 保存按钮可见 ，编辑按钮变成“取消”
 */
- (IBAction)edit:(id)sender {
    if (self.nameField.enabled == YES) {//点的是取消
        //恢复原来数据
        self.nameField.text = self.contact.name;
        self.phoneField.text = self.contact.phone;
        self.tagField.text = self.contact.contactTag;
        //文本框不可输入
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        self.tagField.enabled = NO;
        //键盘隐藏
        [self.view endEditing:YES];
        //保存按钮不可见
        self.addBtn.hidden = YES;
        //按钮变成编辑
        self.editBtn.title = @"编辑";
        
    }else{//点的是编辑
        //编辑按钮变成取消
        self.editBtn.title = @"取消";
        NSLog(@"%@",self.editBtn.title);
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        self.tagField.enabled = YES;
        //保存按钮可见
        self.addBtn.hidden = NO;
        
        [self.phoneField becomeFirstResponder];
    }
}
@end
