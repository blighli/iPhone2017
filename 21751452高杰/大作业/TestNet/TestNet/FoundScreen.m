//
//  FoundScreen.m
//  TestNet
//
//  Created by Yif-JJ on 2017/9/22.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import "FoundScreen.h"

@interface FoundScreen ()

@end

@implementation FoundScreen
@synthesize userOutput;
@synthesize userInput;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    // Do any additional setup after loading the view.
}
- (void)viewDidUnload
{
    self.userInput = nil;
    self.userOutput = nil;
    [self setUserOutput:nil];
    [self setUserInput:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (IBAction)setOutput:(UIButton *)sender {
    self.userOutput.text=self.userInput.text;
}
@end
