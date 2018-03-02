//
//  ESContactTableViewCell.h
//  私人通讯录
//
//  Created by Edith.S on 2017/10/14.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ESContact;

@interface ESContactTableViewCell : UITableViewCell

@property (strong,nonatomic) ESContact *contact;

+(ESContactTableViewCell*) cellWithTableView:(UITableView*)tableView;

@end
