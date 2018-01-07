//
//  ContactScreen.m
//  TestNet
//
//  Created by Yif-JJ on 2017/9/22.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import "ContactScreen.h"

@interface ContactScreen ()

@end

@implementation ContactScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯";

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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
