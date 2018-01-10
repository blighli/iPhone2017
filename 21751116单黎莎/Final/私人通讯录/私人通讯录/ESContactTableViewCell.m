//
//  ESContactTableViewCell.m
//  私人通讯录
//
//  Created by Edith.S on 2017/10/14.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import "ESContactTableViewCell.h"
#import "ESContact.h"

@interface ESContactTableViewCell ()
@property (weak,nonatomic) UIView *divider;
@end

@implementation ESContactTableViewCell

+(ESContactTableViewCell*) cellWithTableView:(UITableView*)tableView{
    NSString* cellID = @"contactCell";
    ESContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor blackColor];
    divider.alpha = 0.2;
    [self.contentView addSubview:divider];
    self.divider = divider;
}

-(void)setContact:(ESContact *)contact{
    _contact = contact;
    self.textLabel.text = contact.name;
    self.detailTextLabel.text = contact.phone;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat dividerX = 0;
    CGFloat dividerH = 1;
    CGFloat dividerY = self.frame.size.height - dividerH;
    CGFloat dividerW = self.frame.size.width;
    
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
