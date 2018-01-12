//
//  HMSSquareCollectionCell.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/9.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSSquareCollectionCell.h"
#import <UIImageView+WebCache.h>
#import "HMSSquareItem.h"

@interface HMSSquareCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation HMSSquareCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setItem:(HMSSquareItem *)item{
    [_iconView sd_setImageWithURL:[NSURL URLWithString: item.icon]];
    _nameView.text = item.name;
}

@end
