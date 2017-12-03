//
//  ProjectVcTitleView.h
//  InfiniteHelp
//
//  Created by sands on 16/7/22.
//  Copyright © 2016年 sands. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProjectVcTitleViewDelegate <NSObject>

- (void)ButtonOneClick;
- (void)ButtonTwoClick;

@end


@interface ProjectVcTitleView : UIView

@property (weak, nonatomic) IBOutlet UILabel *BackLabel;
@property (weak, nonatomic) IBOutlet UIButton *ButtonOne;
@property (weak, nonatomic) IBOutlet UIButton *ButtonTwo;
@property (weak, nonatomic) IBOutlet UIView *selectView;

@property (nonatomic,strong) id<ProjectVcTitleViewDelegate>delegate;

@end
