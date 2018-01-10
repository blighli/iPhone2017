//
//  ESEditViewController.h
//  私人通讯录
//
//  Created by Edith.S on 2017/9/26.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ESContact,ESEditViewController;

@protocol ESEditViewControllerDelegate <NSObject>

@optional

-(void)editViewController:(ESEditViewController*)editVc didSaveContact:(ESContact*)contact;

@end

@interface ESEditViewController : UIViewController

@property (weak,nonatomic) id<ESEditViewControllerDelegate> delegate;
@property (strong,nonatomic) ESContact *contact;

@end
