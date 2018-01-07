//
//  MessageScreen.m
//  TestNet
//
//  Created by Yif-JJ on 2017/9/21.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import "MessageScreen.h"

@interface MessageScreen ()
- (IBAction)btnPressed:(id)sender;

@end

@implementation MessageScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    // Do any additional setup after loading the view.
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
- (IBAction)btnPressed:(id)sender {
    NSDate *date = self.datePicker.date;
    NSString *msg = [[NSString alloc] initWithFormat:@"The date and time you selected is %@",date];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Date and Time Selected" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"That's so true!" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
