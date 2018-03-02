//
//  ESAddViewController.h
//  私人通讯录
//
//  Created by Edith.S on 2017/9/26.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ESAddViewController;
@class ESContact;

@protocol ESAddViewControllerDelegate <NSObject>

@optional
-(void)addViewController:(ESAddViewController*)addVc didAddContact:(ESContact*)contact;

@end

@interface ESAddViewController : UIViewController
@property (weak,nonatomic) id<ESAddViewControllerDelegate> delegate;
@end
