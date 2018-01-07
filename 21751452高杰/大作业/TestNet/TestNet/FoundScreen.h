//
//  FoundScreen.h
//  TestNet
//
//  Created by Yif-JJ on 2017/9/22.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoundScreen : UIViewController
@property (strong,nonatomic) IBOutlet UILabel *userOutput;
@property (strong,nonatomic) IBOutlet UITextField *userInput;

- (IBAction)setOutput:(UIButton *)sender;
@end
